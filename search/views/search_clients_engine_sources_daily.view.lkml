include: "//looker-hub/search/views/search_clients_engines_sources_daily.view.lkml"

view: +search_clients_engines_sources_daily {
  dimension_group: submission {
    sql: ${TABLE}.submission_date ;;
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      month_name,
      quarter,
      year,
    ]
    convert_tz: no
    datatype: date
  }

  dimension_group: submission {
    type: time
    view_label: "PoP"
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      day_of_week,
      day_of_week_index,
      day_of_month,
      day_of_year,
      week,
      week_of_year,
      month,
      month_name,
      month_num,
      quarter,
      year
    ]
    sql: ${TABLE}.submission_date;;
    convert_tz: no
  }
  filter: current_date_range {
    type: date
    view_label: "PoP"
    label: "1. Current Date Range"
    description: "Select the current date range you are interested in. Make sure any other filter on Event Date covers this period, or is removed."
    sql: ${submission_date} IS NOT NULL ;;
  }

  parameter: compare_to {
    view_label: "PoP"
    description: "Select the templated previous period you would like to compare to. Must be used with Current Date Range filter"
    label: "2. Compare To:"
    type: unquoted
    allowed_value: {
      label: "Previous Period"
      value: "Period"
    }
    allowed_value: {
      label: "Previous Week"
      value: "Week"
    }
    allowed_value: {
      label: "Previous Month"
      value: "Month"
    }
    allowed_value: {
      label: "Previous Quarter"
      value: "Quarter"
    }
    allowed_value: {
      label: "Previous Year"
      value: "Year"
    }
    default_value: "Period"
  }


  measure: total_searches {
    label: "SAP Searches"
    type: sum
    sql: ${sap} ;;
    description: "Total searches from all Search Access Points (SAPs), not including follow-ons.
     These may or may not be tagged."
  }

  measure: total_tagged_sap_searches {
    label: "Tagged SAP Searches"
    type: sum
    sql: ${tagged_sap} ;;
    description: "Total tagged searches from all Search Access Points (SAPs)."
  }

  measure: total_tagged_searches {
    label: "Tagged Searches"
    type: sum
    sql: ${tagged_sap} + ${tagged_follow_on} ;;
    description: "Total tagged searches from all Search Access Points (SAPs) and follow-ons."
  }

  measure: total_tagged_follow_on_searches {
    label: "Tagged Follow-on Searches"
    type: sum
    sql: ${tagged_follow_on} ;;
    description: "Total follow-on searches, which occur after a search from a Search Access Point (SAP)."
  }

  measure: total_organic_searches {
    label: "Organic Searches"
    type: sum
    sql: ${organic} ;;
    description: "Total organic searches, made directly at the engine's website."
  }

  measure: total_searches_with_ads {
    label: "Searches With Ads"
    type: sum
    sql: ${search_with_ads} ;;
    description: "Total searches with ads. Does not include organic searches."
  }

  measure: total_organic_searches_with_ads {
    label: "Organic Searches With Ads"
    type: sum
    sql: ${search_with_ads_organic} ;;
    description: "Total organic searches with ads. "
  }

  measure: total_ad_clicks {
    label: "Ad Clicks"
    type: sum
    sql: ${ad_click} ;;
    description: "Total ad clicks. Does not include ad clicks resulting from organic searches."
  }

  measure: total_organic_ad_clicks {
    label: "Organic Ad Clicks"
    type: sum
    sql: ${ad_click_organic} ;;
    description: "Total organic ad clicks."
  }
}
