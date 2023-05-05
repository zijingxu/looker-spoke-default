
# *Do not manually modify this file*
#
# This file has been generated via https://github.com/mozilla/lookml-generator
# You can extend this view in the looker-spoke-default project (https://github.com/mozilla/looker-spoke-default)

view: newtab_interaction {
  dimension: activity_segment {
    sql: ${TABLE}.activity_segment ;;
    type: string
  }

  dimension: blocked_sponsors {
    sql: ${TABLE}.blocked_sponsors ;;
    hidden: yes
  }

  dimension: browser_name {
    sql: ${TABLE}.browser_name ;;
    type: string
  }

  dimension: browser_version {
    sql: ${TABLE}.browser_version ;;
    type: string
  }

  dimension: channel {
    sql: ${TABLE}.channel ;;
    type: string
  }

  dimension: client_id {
    sql: ${TABLE}.client_id ;;
    hidden: yes
  }

  dimension: country_code {
    sql: ${TABLE}.country_code ;;
    type: string
  }

  dimension: default_private_search_engine {
    sql: ${TABLE}.default_private_search_engine ;;
    type: string
  }

  dimension: default_search_engine {
    sql: ${TABLE}.default_search_engine ;;
    type: string
  }

  dimension: experiments {
    sql: ${TABLE}.experiments ;;
    hidden: yes
  }

  dimension: is_new_profile {
    sql: ${TABLE}.is_new_profile ;;
    type: yesno
  }

  dimension: legacy_telemetry_client_id {
    sql: ${TABLE}.legacy_telemetry_client_id ;;
    type: string
  }

  dimension: newtab_homepage_category {
    sql: ${TABLE}.newtab_homepage_category ;;
    type: string
  }

  dimension: newtab_newtab_category {
    sql: ${TABLE}.newtab_newtab_category ;;
    type: string
  }

  dimension: newtab_open_source {
    sql: ${TABLE}.newtab_open_source ;;
    type: string
  }

  dimension: newtab_search_enabled {
    sql: ${TABLE}.newtab_search_enabled ;;
    type: yesno
  }

  dimension: newtab_visit_ended_at {
    sql: ${TABLE}.newtab_visit_ended_at ;;
    type: number
  }

  dimension: newtab_visit_id {
    sql: ${TABLE}.newtab_visit_id ;;
    type: string
    primary_key: yes
  }

  dimension: newtab_visit_started_at {
    sql: ${TABLE}.newtab_visit_started_at ;;
    type: number
  }

  dimension: normalized_os {
    sql: ${TABLE}.normalized_os ;;
    type: string
  }

  dimension: normalized_os_version {
    sql: ${TABLE}.normalized_os_version ;;
    type: string
  }

  dimension: pocket_enabled {
    sql: ${TABLE}.pocket_enabled ;;
    type: yesno
  }

  dimension: pocket_interactions {
    sql: ${TABLE}.pocket_interactions ;;
    hidden: yes
  }

  dimension: pocket_is_signed_in {
    sql: ${TABLE}.pocket_is_signed_in ;;
    type: yesno
  }

  dimension: pocket_sponsored_stories_enabled {
    sql: ${TABLE}.pocket_sponsored_stories_enabled ;;
    type: yesno
  }

  dimension: search_interactions {
    sql: ${TABLE}.search_interactions ;;
    hidden: yes
  }

  dimension: topsite_interactions {
    sql: ${TABLE}.topsite_interactions ;;
    hidden: yes
  }

  dimension: topsites_enabled {
    sql: ${TABLE}.topsites_enabled ;;
    type: yesno
  }

  dimension: topsites_rows {
    sql: ${TABLE}.topsites_rows ;;
    type: number
  }

  dimension_group: submission {
    sql: ${TABLE}.submission_date ;;
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year,
    ]
    convert_tz: no
    datatype: date
  }

  measure: visits {
    type: count
  }

  measure: clients {
    sql: ${TABLE}.client_id ;;
    type: count_distinct
    approximate: yes
  }

  sql_table_name: `moz-fx-data-shared-prod.analysis.newtab_interactions_v2_test` ;;
}

view: interaction__experiments {
  dimension: key {
    sql: ${TABLE}.key ;;
    type: string
  }

  dimension: value__branch {
    sql: ${TABLE}.value.branch ;;
    type: string
    group_label: "Value"
    group_item_label: "Branch"
  }

  dimension: value__extra__enrollment_id {
    sql: ${TABLE}.value.extra.enrollment_id ;;
    type: string
    group_label: "Value Extra"
    group_item_label: "Enrollment Id"
  }

  dimension: value__extra__type {
    sql: ${TABLE}.value.extra.type ;;
    type: string
    group_label: "Value Extra"
    group_item_label: "Type"
  }
}

view: interaction__pocket_interactions {
  dimension: pocket_story_position {
    sql: ${TABLE}.pocket_story_position ;;
    type: number
    primary_key: yes
  }

  measure: organic_pocket_clicks {
    sql: ${TABLE}.organic_pocket_clicks ;;
    type: sum
  }

  measure: organic_pocket_impressions {
    sql: ${TABLE}.organic_pocket_impressions ;;
    type: sum
  }

  measure: organic_pocket_saves {
    sql: ${TABLE}.organic_pocket_saves ;;
    type: sum
  }

  measure: pocket_clicks {
    sql: ${TABLE}.pocket_clicks ;;
    type: sum
  }

  measure: pocket_impressions {
    sql: ${TABLE}.pocket_impressions ;;
    type: sum
  }

  measure: pocket_saves {
    sql: ${TABLE}.pocket_saves ;;
    type: sum
  }

  measure: sponsored_pocket_clicks {
    sql: ${TABLE}.sponsored_pocket_clicks ;;
    type: sum
  }

  measure: sponsored_pocket_impressions {
    sql: ${TABLE}.sponsored_pocket_impressions ;;
    type: sum
  }

  measure: sponsored_pocket_saves {
    sql: ${TABLE}.sponsored_pocket_saves ;;
    type: sum
  }
}

view: interaction__search_interactions {
  dimension: primary_key {
    sql: CONCAT(${search_access_point}, ${search_engine}) ;;
    hidden: yes
    primary_key: yes
  }

  dimension: search_access_point {
    sql: ${TABLE}.search_access_point ;;
    type: string
  }

  dimension: search_engine {
    sql: ${TABLE}.search_engine ;;
    type: string
  }

  measure: follow_on_search_ad_clicks {
    sql: ${TABLE}.follow_on_search_ad_clicks ;;
    type: sum
  }

  measure: follow_on_search_ad_impressions {
    sql: ${TABLE}.follow_on_search_ad_impressions ;;
    type: sum
  }

  measure: searches {
    sql: ${TABLE}.searches ;;
    type: sum
  }

  measure: tagged_follow_on_search_ad_clicks {
    sql: ${TABLE}.tagged_follow_on_search_ad_clicks ;;
    type: sum
  }

  measure: tagged_follow_on_search_ad_impressions {
    sql: ${TABLE}.tagged_follow_on_search_ad_impressions ;;
    type: sum
  }

  measure: tagged_search_ad_clicks {
    sql: ${TABLE}.tagged_search_ad_clicks ;;
    type: sum
  }

  measure: tagged_search_ad_impressions {
    sql: ${TABLE}.tagged_search_ad_impressions ;;
    type: sum
  }
}

view: interaction__topsite_interactions {
  dimension: primary_key {
    sql: CONCAT(${topsite_position}, ${topsite_advertiser_name}) ;;
    hidden: yes
    primary_key: yes
  }

  dimension: topsite_position {
    sql: ${TABLE}.topsite_position ;;
    type: number
  }

  dimension: topsite_advertiser_name {
    sql: ${TABLE}.topsite_advertiser_name ;;
    type: string
  }

  measure: organic_topsite_clicks {
    sql: ${TABLE}.organic_topsite_clicks ;;
    type: sum
  }

  measure: organic_topsite_impressions {
    sql: ${TABLE}.organic_topsite_impressions ;;
    type: sum
  }

  measure: sponsored_topsite_clicks {
    sql: ${TABLE}.sponsored_topsite_clicks ;;
    type: sum
  }

  measure: sponsored_topsite_impressions {
    sql: ${TABLE}.sponsored_topsite_impressions ;;
    type: sum
  }

  measure: topsite_clicks {
    sql: ${TABLE}.topsite_clicks ;;
    type: sum
  }

  measure: topsite_impressions {
    sql: ${TABLE}.topsite_impressions ;;
    type: sum
  }

}
