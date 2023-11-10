view: telemetry_dev_cycle_probe_versions {
  sql_table_name: `leli-sandbox.telemetry_dashboard.probe_versions` ;;

  dimension: channel {
    type: string
    sql: ${TABLE}.channel ;;
  }
  dimension: expiry_version {
    type: string
    sql: ${TABLE}.expiry_version ;;
  }
  dimension: last_version {
    type: number
    sql: ${TABLE}.last_version ;;
  }
  dimension: probe {
    type: string
    sql: ${TABLE}.probe ;;
  }
  dimension: real_expiry_version {
    type: number
    sql: ${TABLE}.real_expiry_version ;;
  }
  dimension: release_version {
    type: number
    sql: ${TABLE}.release_version ;;
  }
  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }
  dimension: current_version {
    type: number
    sql: ${TABLE}.current_version ;;
  }
  dimension: released_last_3_versions {
    type: yesno
    sql: ${release_version} >= ${current_version} - 3;;
  }

  dimension: expired_last_3_versions {
    type: yesno
    sql: ${real_expiry_version} >= ${current_version} - 3 ;;
  }
  dimension: release_version_diff {
    type: number
    sql: ${TABLE}.release_version_diff ;;
  }
  dimension: expiry_version_diff {
    type: number
    sql: ${TABLE}.expiry_version_diff ;;
  }
  measure: count {
    type: count
  }
  measure: active_probes {
    type: count
    filters: [real_expiry_version: "NULL"]
  }
  measure: number_of_new_probes_last_3_versions {
    type: count
    filters: [released_last_3_versions: "yes"]
  }
  measure: number_of_expired_probes_last_3_versions {
    type: count
    filters: [expired_last_3_versions: "yes"]
  }


}
