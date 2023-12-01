Checklist for reviewer:

When adding a new derived dataset:
- [ ] Ensure that the data is not available already (fully or partially) and recommend extending an existing dataset in favor of creating new ones. Data may be available in [bigquery-etl repository](https://github.com/mozilla/bigquery-etl), [looker-hub](https://github.com/mozilla/looker-hub) or in [looker-spoke-default](https://github.com/mozilla/looker-spoke-default/tree/e1315853507fc1ac6e78d252d53dc8df5f5f322b).
- [ ] Avoid merging a PR that includes the logic of a [core metric](https://docs.telemetry.mozilla.org/metrics/index.html) or complex business logic. The recommendation is to implement core business logic in bigquery-etl. E.g. The [type of search](https://github.com/mozilla/bigquery-etl/blob/a3e59f90326816a2ecaaa3e9d5b57fe9552f7d70/sql/moz-fx-data-shared-prod/search_derived/mobile_search_clients_daily_v1/query.sql#L781) or the [calculation of DAU or visited URIs](https://github.com/mozilla/bigquery-etl/blob/9bca48821a8a0d40b1700cc14ecd8068d132ed06/sql/moz-fx-data-shared-prod/telemetry_derived/firefox_desktop_exact_mau28_by_dimensions_v1/query.sql).
- [ ] Avoid merging code in Looker Explores/Views that implement analysis with multiple lines of code or that will be likely replicated in the future. Instead, aim for extending an existing dataset to include the required logic, and use [Looker aggregates](https://cloud.google.com/looker/docs/aggregate_awareness) to facilitate the analysis.
- [ ] Avoid merging a PR with logic that requires validation and health checks. It is recommended to implement it in bigquery-etl for full test coverage and failure alerts.