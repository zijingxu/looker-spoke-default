include: "//looker-hub/firefox_accounts/views/all_events_table.view.lkml"

view: fxa_events {
  extends: [all_events_table]

  measure: event_count {
    type: count
    description: "The number of times the event(s) occurred."
  }

}
