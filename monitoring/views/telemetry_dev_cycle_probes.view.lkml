view: telemetry_dev_cycle_probes {
  sql_table_name: `leli-sandbox.telemetry_dashboard.probes` ;;

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }
  dimension_group: expiry {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.expiry_date ;;
  }
  dimension: last_version {
    type: number
    sql: ${TABLE}.last_version ;;
  }
  dimension: probe {
    type: string
    sql: ${TABLE}.probe ;;
  }
  dimension_group: release {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.release_date ;;
  }
  dimension: release_version {
    type: number
    sql: ${TABLE}.release_version ;;
  }
  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
  dimension: expiry_version {
    type: string
    sql: ${TABLE}.expiry_version ;;
  }
  measure: count {
    type: count
  }
  measure: active_probes {
    type: count
    filters: [expiry_date: "NULL"]
  }
  measure: number_of_new_probes_last_90_days {
    type: count
    filters: [release_date: "90 days ago for 90 days"]
  }
  measure: number_of_expired_probes_last_90_days {
    type: count
    filters: [expiry_date: "90 days ago for 90 days"]
  }
}
