include: "//looker-hub/data_integrity_monitoring/views/*"
view: +run_history {
#   derived_table: {
#     sql: SELECT DATE(actual_run_date) as actual_run_date, COUNTIF(passed= FALSE) as total_failed, count(*) as total_checks
#     FROM `data-monitoring-dev.dim.dim_run_history_v1`
# GROUP BY date(actual_run_date);;
  measure: total_tests_run {
    label: "Total tests run"
    type: count
  }

  measure: total_tests_failed {
    label: "Total tests failed"
    type: count
    filters:[passed:"No"]
  }

  measure: total_tests_passed {
    label: "Total tests passed"
    type: count
    filters:[passed:"Yes"]
  }

}
