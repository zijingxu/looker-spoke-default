view: event_triples {
#   # Or, you could make this view a derived table, like this:
   derived_table: {
    increment_key: "submission_date"
    increment_offset: 1
    sql_trigger_value: select current_date() ;;
    sql: with event_triple as (
          select
              date(submission_timestamp) as submission_date,
              concat(event_category, ".", event_name) as current_event,
              lead(concat(event_category, ".", event_name)) over (partition by client_info.client_id order by ping_info.seq, event_timestamp) as next_event,
              lag(concat(event_category, ".", event_name)) over (partition by client_info.client_id order by ping_info.seq, event_timestamp) as prev_event,
          from `moz-fx-data-shared-prod.firefox_desktop.events_unnested`
          where {% incrementcondition %} submission_date {%  endincrementcondition %}
          and date(submission_timestamp) > "2023-01-01"
      )

      select
        submission_date,
        prev_event,
        current_event,
        next_event,
        count(1) as triple_count
      from event_triple
      group by 1, 2, 3, 4
      having count(1) > 10000
      order by 5 desc
      ;;
  }

  dimension: submission_date {
    description: "Submission Date"
    type:  date
    sql: ${TABLE}.submission_date ;;
  }

  dimension: previous_event {
    description: "Previous event in the sequence"
    type: string
    sql: ${TABLE}.prev_event ;;
  }

  dimension: current_event {
    description: "Current event in the sequence"
    type: string
    sql: ${TABLE}.current_event ;;
  }

  dimension: next_event {
    description: "Next event in the sequence"
    type: string
    sql: ${TABLE}.next_event ;;
  }

  measure: count {
    description: "Count of unique triples"
    type: number
    sql: ${TABLE}.triple_count ;;
  }
}
