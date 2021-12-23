include: "//looker-hub/firefox_desktop/views/feature_usage_table.view.lkml"

view: new_tab_table {
  extends: [feature_usage_table]
  fields_hidden_by_default: yes

  dimension: has_searches {
    type: yesno
    sql: ${search_count_all} > 0 ;;
    hidden:  no
  }

  dimension: has_new_tab_sessions {
    type: yesno
    sql: ${activitystream_sessions_newtab} > 0;;   # TODO: Verify
    hidden:  no
  }

  dimension: has_pocket_enabled {
    type: string
    sql: CASE
          WHEN ${activitystream_reported_pocket_off} = true THEN 'Yes'
          WHEN ${activitystream_reported_pocket_off} = false THEN 'No'
          ELSE 'Unknown'
        END ;; # TODO Figure out why so many of these are unknown
    hidden: no
  }

  dimension: app_version {
    type: string
    hidden:  no
  }

  dimension: os {
    type: string
    hidden:  no
  }

  dimension: normalized_os_version {
    type:  string
    hidden:  no
  }

  # dimension: has_pocket_impressions {
  #   type: yesno
  #   sql: ${}  TODO: Verify, we can't tell whether particular clients have any pocket impressions
  # }

  dimension: country {
    hidden: no
  }

  measure: number_of_clients {
     type: count_distinct
     sql: ${client_id} ;;
     hidden: no
 }

  measure: number_of_new_tab_sessions {
    type: sum
    sql:  ${activitystream_sessions_newtab} ;;
    hidden: no
  }

  # measure: daily_active_users {
  #   type: sum
  #   sql:  ${} ;;    TODO: Verify, how would we get DAU at this grain?
  # }

  # measure: new_tab_searches {
  #   type: sum
  #   sql: ${search_count_newtab} + ${search_count_urlbar_handoff} ;;  TODO: Add search_count_urlbar_handoff to feature_usage
  # }

  measure: number_of_urlbar_handoff_searches {
    type: sum
    sql:  ${search_count_urlbar_handoff} ;;
    hidden: no
  }

  # searches by engine ???

  measure: number_of_sponsored_topite_clicks_on_the_new_tab {
    type: sum
    sql: ${num_new_tab_topsites_clicks_sponsored} ;;
    hidden: no
  }

  measure: number_of_sponsored_topite_clicks_on_the_new_tab_activity_stream {
    type: sum
    sql: ${activitystream_sponsored_topsite_clicks} ;;
    hidden: no
  }

  measure: number_of_sponsored_topsite_impressions_on_the_new_tab {
    type: sum
    sql: ${num_topsites_new_tab_impressions_sponsored} ;;
    hidden: no
  }

  # dimension: pocket_impressions {
  #   type: sum
  #   sql: ${}  TODO: Verify, we can't tell whether particular clients have any pocket impressions
  # }

  measure: number_of_sponsored_pocket_clicks_activity_stream {
    type: sum
    sql: ${activitystream_sponsored_pocket_clicks} ;;
    hidden: no
  }

  measure: number_of_organic_pocket_clicks_activity_stream {
    type: sum
    sql:  ${activitystream_organic_pocket_clicks} ;;
    hidden: no
  }

  # Pocket stories loaded ???

  # Pocket stories pocketed ???

  # AdMarketplace revenue by Partner ???

  # AdMarketplace clicks ???

}
