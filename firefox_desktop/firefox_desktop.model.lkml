connection: "telemetry"

include: "//looker-hub/firefox_desktop/views/*.view.lkml"
include: "//looker-hub/firefox_desktop/explores/*.explore.lkml"
include: "explores/*.explore.lkml"
include: "views/*.view.lkml"
# include: "dashboards/*.dashboard"

explore: firefox_desktop_last_seen {
  label: "Firefox Dekstop Clients Last Seen"
  from: clients_last_seen_table
  hidden: yes
}

explore: +client_counts {
  label: "Client Counts (Legacy Telemetry)"
  always_filter: {
    filters: [
      client_counts.submission_date: "7 days",
      client_counts.sample_id: "0"
    ]
  }
}

explore: +event_counts {
  label: "Event Counts (Legacy Telemetry)"
  always_filter: {
    filters: [
      events.submission_date: "7 days",
      events.sample_id: "0"
    ]
  }
}

explore: +funnel_analysis {
  label: "Funnel Analysis (Legacy Telemetry)"
  always_filter: {
    filters: [
      funnel_analysis.submission_date: "7 days",
      funnel_analysis.sample_id: "0"
    ]
  }
}

explore: +growth_accounting {
  label: "Growth Accounting (Legacy Telemetry)"
  always_filter: {
    filters: [
      growth_accounting.submission_date: "7 days",
      growth_accounting.sample_id: "0"
    ]
  }
}

explore: +baseline {
  label: "Baseline (Glean)"
  always_filter: {
    filters: [
      baseline.submission_date: "7 days",
      baseline.sample_id: "0"
    ]
  }
}

explore: feature_usage {
  view_name: feature_usage_table
  label: "Feature Usage (Legacy Telemetry)"
  description: "A daily aggregation of specific browser feature usages by 1% of Firefox desktop client."

  always_filter: {
    filters: [
      feature_usage_table.submission_date: "7 days"
    ]
  }
}

explore: new_tab {
  view_name: new_tab_table
  label:  "New Tab Explore (Legacy Telemetry"
  description: "A daily aggregation of specific new tab feature usages by 1% of Firefox desktop clients."

  always_filter: {
    filters: [
      new_tab_table.submission_date: "7 days"
    ]
  }
}

explore: +metrics {
  label: "Metrics (Glean)"
  always_filter: {
    filters: [
      metrics.submission_date: "7 days",
      metrics.sample_id: "0"
    ]
  }
}
