import logging
import os
import yaml

import click
import looker_sdk

from looker_sdk import methods, models


logging.basicConfig(
    format="%(asctime)s %(levelname)-8s %(message)s",
    level=logging.INFO,
    datefmt="%Y-%m-%d %H:%M:%S",
)


def setup_sdk(client_id, client_secret, instance) -> methods.Looker31SDK:
    os.environ["LOOKERSDK_BASE_URL"] = instance
    os.environ["LOOKERSDK_API_VERSION"] = "3.1"
    os.environ["LOOKERSDK_VERIFY_SSL"] = "true"
    os.environ["LOOKERSDK_TIMEOUT"] = "120"
    os.environ["LOOKERSDK_CLIENT_ID"] = client_id
    os.environ["LOOKERSDK_CLIENT_SECRET"] = client_secret

    return looker_sdk.init31()


def lookml_uud_mapping(config: dict) -> dict:
    """
    Transforms local config and remote config for comparison purposes.

    {"lookml_link_id": ["dashboard_id1", "dashboard_id2"]}

    """
    mappings = {}

    for dashboard_id, lookml_dashboard_id in config.items():
        if mappings.get(lookml_dashboard_id):
            mappings[lookml_dashboard_id].append(str(dashboard_id))
        else:
            mappings[lookml_dashboard_id] = [str(dashboard_id)]

    return mappings


def get_all_linked_dashboards(sdk: methods.Looker31SDK) -> dict:
    """
    Get all dashboards that contain a lookml_link_id.
    """
    config = {}

    dashboards = sdk.search_dashboards(deleted=False)

    for dashboard in dashboards:
        if dashboard.model is None and dashboard.lookml_link_id:
            config[dashboard.id] = dashboard.lookml_link_id

    remote_mappings = lookml_uud_mapping(config)

    return remote_mappings


def sync_dashboards(
    sdk: methods.Looker31SDK, mappings: dict, remote_mappings: dict
) -> None:
    try:
        for lookml_dashboard_id, dashboard_ids in mappings.items():
            # unlink any UUDs that are not included in the local mapping
            if remote_mappings.get(lookml_dashboard_id):
                unlink_dashboard_ids = set(remote_mappings[lookml_dashboard_id]) - set(
                    dashboard_ids
                )
                for unlink_dashboard_id in unlink_dashboard_ids:
                    sdk.update_dashboard(
                        unlink_dashboard_id, models.WriteDashboard(lookml_link_id="")
                    )
                    logging.warning(
                        f"Dashboard {unlink_dashboard_id} unlinked from LookML dashboard {lookml_dashboard_id}"
                    )

            # link and sync UUDs based on local mappings
            for dashboard_id in dashboard_ids:
                dashboard = sdk.dashboard(dashboard_id)
                sdk.dashboard_lookml(lookml_dashboard_id)
                sdk.update_dashboard(
                    str(dashboard_id),
                    models.WriteDashboard(lookml_link_id=lookml_dashboard_id),
                )

                sdk.sync_lookml_dashboard(lookml_dashboard_id, models.WriteDashboard())
                logging.info(
                    f"Dashboard {dashboard_id} synced with LookML dashboard {lookml_dashboard_id}"
                )
    except looker_sdk.error.SDKError as e:
        logging.error(f"Dashboard {dashboard_id} dashboard sync failed with {e}")


def load_config(filename: str) -> dict:

    with open(filename) as f:
        load = yaml.load(f, Loader=yaml.SafeLoader)
        mappings = lookml_uud_mapping(load)

    return mappings


@click.command()
@click.option("--client_id", envvar="LOOKER_API_CLIENT_ID", required=True)
@click.option("--client_secret", envvar="LOOKER_API_CLIENT_SECRET", required=True)
@click.option("--instance_uri", envvar="LOOKER_INSTANCE_URI", required=True)
@click.argument("config", type=click.Path(exists=True))
def main(client_id: str, client_secret: str, instance_uri: str, config: str):
    sdk = setup_sdk(client_id, client_secret, instance_uri)
    mappings = load_config(config)
    remote_mappings = get_all_linked_dashboards(sdk)
    sync_dashboards(sdk, mappings, remote_mappings)


if __name__ == "__main__":
    main()
