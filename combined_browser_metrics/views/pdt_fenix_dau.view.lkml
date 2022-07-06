view: pdt_fenix_dau {
  derived_table: {
    explore_source: active_users_aggregates {
      column: daily_active_users {}
      column: period_over_period_pivot {}
      column: period_over_period_row {}
      filters: {
        field: active_users_aggregates.submission_date
        value: "after 2021/01/01"
      }
      filters: {
        field: active_users_aggregates.ytd_only
        value: "Yes"
      }
      filters: {
        field: active_users_aggregates.app_name
        value: "Focus Android"
      }
      filters: {
        field: active_users_aggregates.choose_comparison
        value: "Year"
      }
      filters: {
        field: active_users_aggregates.choose_breakdown
        value: "Month^_Day"
      }
    }
  }
  dimension: daily_active_users {
    label: "Active Users Aggregates DAU"
    description: ""
    type: number
  }
  dimension: period_over_period_pivot {
    label: "Date/Period Selection Period Over Period Pivot"
    description: ""
  }
  dimension: period_over_period_row {
    label: "Date/Period Selection Period Over Period Row"
    description: ""
  }
}
