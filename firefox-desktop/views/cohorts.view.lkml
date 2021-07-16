include: "//looker-hub/firefox_desktop/views/*.view.lkml"
view: cohorts {
  # # You can specify the table name if it's different from the view name:
  extends: [clients_last_seen]

  dimension: cohort_date {
    type: date
    sql: DATE_SUB(${submission_date}, INTERVAL 27 DAY) ;;
  }

  measure: new_profiles {
    type: count
    filters: [days_since_first_seen: "=27"]
  }

  measure: new_profiles_core_active {
    type: count
    filters: [days_since_first_seen: "=27", is_core_active_v1: "yes"]
  }
}
