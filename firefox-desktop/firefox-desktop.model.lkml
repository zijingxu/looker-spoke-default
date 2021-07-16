connection: "telemetry"

include: "views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "dashboards/*.dashboard"

explore: firefox_desktop_last_seen {
  label: "Firefox Desktop Clients Last Seen"
  from: client_counts
  hidden: no
}

explore: firefox_desktop_cohorts {
  label: "Firefox Desktop Cohorts"
  from: cohorts
  hidden: no
}
