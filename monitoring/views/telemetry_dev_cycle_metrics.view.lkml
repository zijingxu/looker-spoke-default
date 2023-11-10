view: telemetry_dev_cycle_metrics {
  sql_table_name: `leli-sandbox.telemetry_dashboard.metrics` ;;

  dimension_group: expiry {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.expiry_date ;;
  }
  dimension_group: last {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.last_date ;;
  }
  dimension: metric {
    type: string
    sql: ${TABLE}.metric ;;
  }
  dimension: product {
    type: string
    sql: ${TABLE}.product ;;
  }
  dimension_group: release {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.release_date ;;
  }
  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
  measure: count {
    type: count
  }
  measure: active_metrics {
    type: count
    filters: [expiry_date: "NULL"]
  }
  measure: number_of_new_metrics_last_90_days {
    type: count
    filters: [release_date: "90 days ago for 90 days"]
  }
  measure: number_of_expired_metrics_last_90_days {
    type: count
    filters: [expiry_date: "90 days ago for 90 days"]
  }
}
