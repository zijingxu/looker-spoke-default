view: data_incidents {
  sql_table_name: `moz-fx-data-shared-prod.telemetry_derived.data_incidents_v1` ;;

  dimension: start_date {
    type: date
    sql: ${TABLE}.start_date ;;
  }

  dimension: end_date {
    type: date
    sql: ${TABLE}.end_date ;;
  }

  dimension: incident {
    type: string
    sql: ${TABLE}.incident ;;
  }

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }
}
