include: "../views//aua_attr_rollup.view.lkml"
include: "/shared/views/*"

explore: aua_attr_rollup{
  view_name: active_users_aggregates_attribution
  always_filter: {
    filters: [active_users_aggregates_attribution.app_name: "Firefox Desktop",
      active_users_aggregates_attribution.submission_date: "after 4 weeks ago"]
  }

  join: countries {
    type: left_outer
    relationship: one_to_one
    sql_on: ${active_users_aggregates_attribution.country} = ${countries.code} ;;
  }

  aggregate_table: attr_rollup__period_over_period {
    query: {
      dimensions: [period_over_period_pivot, period_over_period_row, active_users_aggregates_attribution.app_name, active_users_aggregates_attribution.submission_date]
      measures: [daily_active_users, weekly_active_users, monthly_active_users, new_profile, ad_click, organic_search_counts, search_counts, search_with_ad, uri_counts, active_hour]
      filters: [
        active_users_aggregates_attribution.choose_breakdown: "Month^_Day",
        active_users_aggregates_attribution.choose_comparison: "Year",
        active_users_aggregates_attribution.submission_date: "after 1 year ago",
        active_users_aggregates_attribution.ytd_only: "Yes"
      ]
    }

    materialization: {
      sql_trigger_value: SELECT CURRENT_DATE() ;;
      increment_key: active_users_aggregates_attribution.submission_date
      increment_offset: 1
    }
  }
}
