include: "//looker-hub/firefox_desktop/views/clients_last_seen.view.lkml"

view: client_properties {
  extends: [clients_last_seen]

  filter: date {
    type: date
    sql: {% condition date %} CAST(clients_last_seen.submission_date AS TIMESTAMP) {% endcondition %} ;;
  }

  measure: count_is_default_browser {
    type: count

    filters: [is_default_browser: "yes"]
  }

  measure: count_clients {
    label: "Count Clients"
    type: count
  }

  measure: fraction_is_default_browser {
    sql: SAFE_DIVIDE(${count_is_default_browser}, ${count_clients}) ;;
    type: number
  }
}
