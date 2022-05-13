###  Period over Period Method 6: Compare two arbitrary date ranges


# provides functionality like Google Analytics, which allows you to compare two arbitrary date ranges

view: pop_method6 {
  derived_table: {
    sql_trigger_value: SELECT CURRENT_DATE() ;;
    sql:
      SELECT
        submission_date,
        client_id,
        days_created_profile_bits,
        days_seen_bits,
        days_since_created_profile,
        days_since_seen,
        first_seen_date,
        country,
        locale
      FROM `telemetry.nondesktop_clients_last_seen`
      WHERE product = 'Focus Android'
      AND submission_date >= "2020-01-01";;
  }

#######################################
## ------------------ USER FILTERS  ------------------ ##

  filter: first_period_filter {
    view_label: "_PoP"
    group_label: "Arbitrary Period Comparisons"
    description: "Choose the first date range to compare against. This must be before the second period"
    type: date
  }

  filter: second_period_filter {
    view_label: "_PoP"
    group_label: "Arbitrary Period Comparisons"
    description: "Choose the second date range to compare to. This must be after the first period"
    type: date
  }

#######################################
  dimension_group: submission {
    type: time
    view_label: "_PoP"
    timeframes: [
      raw,
      date,
      day_of_month,
      day_of_year,
      week,
      month,
      month_name,
      month_num,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.submission_date ;;
  }

#######################################

## ------------------ HIDDEN HELPER DIMENSIONS  ------------------ ##

  dimension: days_from_start_first {
    view_label: "_PoP"
    # hidden: yes
    type: number
    # the order here matters because
    # BigQuery doc: "If the first DATE is earlier than the second one, the output is negative."
    # Redshift doc: "If the second date or time is earlier than the first date or time, the result is negative."
    sql: DATE_DIFF(${submission_date}, DATE({% date_start first_period_filter %}), DAY)  ;;

  }

  dimension: days_from_start_second {
    view_label: "_PoP"
    # hidden: yes
    type: number
    # the order here matters because
    # BigQuery doc: "If the first DATE is earlier than the second one, the output is negative."
    # Redshift doc: "If the second date or time is earlier than the first date or time, the result is negative."
    sql: DATE_DIFF( ${submission_date}, DATE({% date_start second_period_filter %}), DAY)  ;;
  }



  ## ------------------ DIMENSIONS TO PLOT ------------------ ##

  dimension: days_from_first_period {
    view_label: "_PoP"
    description: "Select for Grouping (Rows)"
    group_label: "Arbitrary Period Comparisons"
    type: number
    sql:
        CASE
        WHEN ${days_from_start_second} >= 0
        THEN ${days_from_start_second}
        WHEN ${days_from_start_first} >= 0
        THEN ${days_from_start_first}
        END;;
  }


  dimension: period_selected {
    view_label: "_PoP"
    group_label: "Arbitrary Period Comparisons"
    label: "First or second period"
    description: "Select for Comparison (Pivot)"
    type: string
    sql:
        CASE
            WHEN {% condition first_period_filter %} TIMESTAMP(${submission_date}) {% endcondition %}
            THEN 'First Period'
            WHEN {% condition second_period_filter %} TIMESTAMP(${submission_date}) {% endcondition %}
            THEN 'Second Period'
            END ;;
  }



#######################################

  dimension: days_since_seen {
    type: number
    hidden: yes
  }

  dimension: active_this_day {
    type: yesno
    sql: ${days_since_seen} < 1 ;;
    hidden: yes
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  measure: user_count_active_this_day {
    label: "Daily Active Users"
    type: count

    filters: {
      field: active_this_day
      value: "yes"
    }


    drill_fields: [country, user_count_active_this_day]
  }



  measure: current_period_user_count_active_this_day {
    view_label: "_PoP"
    type: count
    # sql: ${sale_price};;
    filters: [period_selected: "Second Period", active_this_day: "yes"]
  }

  measure: previous_period_user_count_active_this_day {
    view_label: "_PoP"
    type: count
    # sql: ${sale_price};;
    filters: [period_selected: "First Period", active_this_day: "yes"]
  }

  measure: sales_pop_change {
    view_label: "_PoP"
    label: "Total sales period-over-period % change"
    type: number
    sql: (1.0 * ${current_period_user_count_active_this_day / NULLIF(${previous_period_user_count_active_this_day} ,0)) - 1 ;;
    value_format_name: percent_2
  }
}

###  Period over Period Method 7: Compare any period with the previous preceding period of the same length

# Like Method 2, but here we define any date filter (not just current) and
# compare it to the previous period of the same length - great for single value visualization comparisons

view: pop_method7 {
  derived_table: {
    sql_trigger_value: SELECT CURRENT_DATE() ;;
    sql:
      SELECT
        submission_date,
        client_id,
        days_created_profile_bits,
        days_seen_bits,
        days_since_created_profile,
        days_since_seen,
        first_seen_date,
        country,
        locale
      FROM `telemetry.nondesktop_clients_last_seen`
      WHERE product = 'Focus Android'
      AND submission_date >= "2020-01-01";;
  }

#######################################
  filter: date_filter {
    view_label: "_PoP"
    description: "Use this date filter in combination with the timeframes dimension for dynamic date filtering"
    type: date
  }

  dimension_group: filter_start_date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    #You can replace the '2013-01-01' with the first date in your database
    sql: CASE WHEN {% date_start date_filter %} IS NULL THEN '2021-01-01' ELSE CAST({% date_start date_filter %} AS DATE) END;;
  }


#######################################
  dimension_group: submission {
    type: time
    view_label: "_PoP"
    timeframes: [
      raw,
      date,
      day_of_month,
      day_of_year,
      week,
      month,
      month_name,
      month_num,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.submission_date ;;
  }

#######################################

  dimension_group: filter_end_date {
    hidden: yes
    type: time
    timeframes: [raw,date]
    sql: CASE WHEN {% date_end date_filter %} IS NULL THEN CURRENT_DATE ELSE CAST({% date_end date_filter %} AS DATE) END;;
  }

  dimension: interval {
    hidden: yes
    type: number
    sql: DATE_DIFF(${filter_end_date_raw}, ${filter_start_date_raw}, DAY) ;;
  }

#start date of the previous period
  dimension: previous_start_date {
    hidden: yes
    type: string
    sql: DATE_ADD(${filter_start_date_raw}, INTERVAL- ${interval} DAY);;
  }


  dimension: timeframes {
    view_label: "_PoP"
    type: string
    case: {
      when: {
        sql: ${is_current_period} = true;;
        label: "Selected Period"
      }
      when: {
        sql: ${is_previous_period} = true;;
        label: "Previous Period"
      }
      else: "Not in time period"
    }
  }

## For filtered measures


  dimension: is_current_period {
    hidden: yes
    type: yesno
    sql: ${submission_date} >= ${filter_start_date_date} AND ${submission_date} < ${filter_end_date_date} ;;
  }

  dimension: is_previous_period {
    hidden: yes
    type: yesno
    sql: ${submission_date} >= ${previous_start_date} AND ${submission_date} < ${filter_start_date_date} ;;
  }




#######################################

  dimension: days_since_seen {
    type: number
    hidden: yes
  }

  dimension: active_this_day {
    type: yesno
    sql: ${days_since_seen} < 1 ;;
    hidden: yes
  }

  dimension: country {
    type: string
    sql: ${TABLE}.country ;;
  }

  measure: user_count_active_this_day {
    label: "Daily Active Users"
    type: count

    filters: {
      field: active_this_day
      value: "yes"
    }


    drill_fields: [country, user_count_active_this_day]
  }

  measure: selected_period_user_count_active_this_day{
    view_label: "_PoP"
    type: count
    # sql: ${sale_price} ;;
    filters: [is_current_period: "yes", active_this_day: "yes"]

  }
  measure: previous_period_user_count_active_this_day {
    view_label: "_PoP"
    type: count
    # sql: ${sale_price} ;;
    filters: [is_previous_period: "yes",active_this_day: "yes"]

  }

}
