include: "../views/telemetry_dev_cycle_probes.view.lkml"
include: "../views/telemetry_dev_cycle_metrics.view.lkml"
include: "../views/telemetry_dev_cycle_probe_versions.view.lkml"
include: "../views/telemetry_dev_cycle_experiments.view.lkml"

explore: telemetry_dev_cycle_probes {}
explore: telemetry_dev_cycle_metrics {}
explore: telemetry_dev_cycle_probe_versions {}
explore: telemetry_dev_cycle_experiments {}
