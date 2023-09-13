include: "//looker-hub/firefox_accounts/views/fxa_events_table.view.lkml"

explore: event_counts {

  view_name: fxa_events
  description: "Event counts over time."
  sql_always_where: ${fxa_events.timestamp_date} >= '2010-01-01' AND ${fxa_events.fxa_log} IN ('oauth', 'auth', 'content') ;;

  always_filter: {
    filters: [
      timestamp_date: "28 days"
    ]
  }

  query: all_event_counts {
    description: "Event counts from all events over the past two weeks."
    dimensions: [timestamp_date]
    measures: [event_count]
    filters: [
      timestamp_date: "14 days",
    ]
  }

  dimension: checkout_type {hidden: yes}
  dimension: country_code {hidden: yes}
  dimension: country_code_source {hidden: yes}
  dimension: entrypoint_experiment {hidden: yes}
  dimension: entrypoint_variation {hidden: yes}
  dimension: error_id {hidden: yes}
  dimension: event_properties {hidden: yes}
  dimension: fxa_log {hidden: yes}
  dimension: payment_provider {hidden: yes}
  dimension: plan_id {hidden: yes}
  dimension: previous_plan_id {hidden: yes}
  dimension: previous_product_id {hidden: yes}
  dimension: product_id {hidden: yes}
  dimension: promotion_code {hidden: yes}
  dimension: provider_event_id {hidden: yes}
  dimension: source_country {hidden: yes}
  dimension: subscribed_plan_ids {hidden: yes}
  dimension: subscription_id {hidden: yes}
  dimension: user_properties {hidden: yes}
  dimension: voluntary_cancellation {hidden: yes}
  dimension: event {hidden: yes}

}
