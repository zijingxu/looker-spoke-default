view: telemetry_dev_cycle_experiments {
  sql_table_name: `leli-sandbox.telemetry_dashboard.experiments` ;;

  dimension_group: end_date {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.endDate ;;
  }
  dimension_group: enrollment_end {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.enrollmentEndDate ;;
  }
  dimension: has_config {
    type: yesno
    sql: ${TABLE}.has_config ;;
  }
  dimension: slug {
    type: string
    sql: ${TABLE}.slug ;;
  }
  dimension_group: start {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.startDate ;;
  }
  measure: count {
    type: count
  }
}
