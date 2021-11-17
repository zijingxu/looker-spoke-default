connection: "telemetry"
label: "Experimentation"
include: "//looker-hub/experimentation/views/*"
include: "//looker-hub/firefox_desktop/views/events.view.lkml"
include: "views/*"

# View customizations

view: +experiment_enrollment_daily_active_population {
  dimension: experiment {
    suggest_explore: experimenter_experiments
    suggest_dimension: experimenter_experiments.normandy_slug
  }

  measure: Total {
    type: number
    sql: SUM(${value}) ;;
  }
}

view: +experiment_enrollment_cumulative_population_estimate {
  # Resource exceeded when querying mozdata.telemetry.experiment_enrollment_cumulative_population_estimate
  derived_table: {
    sql:
      WITH all_branches AS (
        -- We need to determine all available branches for this experiment
        SELECT DISTINCT
          branch,
          experiment
        FROM
          `moz-fx-data-shared-prod.telemetry_derived.experiment_enrollment_aggregates_live_v1`
        WHERE experiment = {% parameter experiment_slug %}
      ),
      non_null_branches AS (
        -- We need to determine if the experiment is a rollout. Rollouts do not have any branches,
        -- so unlike other experiments, null branches cannot be ignored.
        -- To determine if an experiment is a rollout, we can simply determine the number of non-null
        -- branches. If that number is 0, then we have a rollout.
        SELECT
          experiment,
          COUNTIF(branch IS NOT NULL) AS non_null_count
        FROM
          all_branches
        GROUP BY
          experiment
      ),
      branches AS (
        SELECT
          experiment,
          IF(
            all_branches.branch IS NULL,
            IF(non_null_count = 0, 'null', all_branches.branch),
            all_branches.branch
          ) AS branch
        FROM
          all_branches
        LEFT JOIN
          non_null_branches
        USING
          (experiment)
      ),
      cumulative_populations AS (
        SELECT
          window_start,
          branch,
          experiment,
          SUM(COALESCE(enroll_count, 0)) OVER previous_rows_window AS cumulative_enroll_count,
          SUM(COALESCE(unenroll_count, 0)) OVER previous_rows_window AS cumulative_unenroll_count,
          SUM(COALESCE(graduate_count, 0)) OVER previous_rows_window AS cumulative_graduate_count
        FROM (
          SELECT
            branch,
            window_start,
            experiment,
            enroll_count,
            unenroll_count,
            graduate_count
          FROM `moz-fx-data-shared-prod.telemetry_derived.experiment_enrollment_aggregates_live_v1`
          WHERE experiment = {% parameter experiment_slug %}
        )
        WINDOW
          previous_rows_window AS (
            PARTITION BY
              experiment,
              branch
            ORDER BY
              window_start
            ROWS BETWEEN
              UNBOUNDED PRECEDING
              AND CURRENT ROW
          )
      )
      SELECT
        `time`,
        experiment,
        branch,
        (SELECT COUNT(branch) FROM all_branches) AS total_branches,
        sum(cumulative_population) AS value
      FROM
        (
          SELECT
            window_start AS `time`,
            branch,
            experiment,
            min(`cumulative_enroll_count`) - min(`cumulative_unenroll_count`) - min(
              `cumulative_graduate_count`
            ) AS cumulative_population
          FROM
            cumulative_populations
          GROUP BY
            1,
            2,
            3
          ORDER BY
            1
        )
      GROUP BY
        1,
        2,
        3,
        4;;
  }

  dimension: total_branches {
    hidden: yes
    type: number
    sql: ${TABLE}.total_branches ;;
  }

  parameter: experiment_slug {
    type: string
    suggest_dimension: experimenter_experiments.normandy_slug
    suggest_explore: experimenter_experiments
  }

  parameter: by_branch {
    type: yesno
    default_value: "no"
  }

  measure: branch_count {
    hidden: yes
    type: number
    sql: COUNT(DISTINCT ${branch}) ;;
  }

  measure: Total {
    type: number
    sql: IF((${branch_count} < MAX(${total_branches}) AND NOT {% parameter by_branch %}), NULL, SUM(${value})) ;;
  }

  filter: timeframe {
    type: date
  }
}

view: +experiment_cumulative_ad_clicks {
  dimension: experiment {
    suggest_explore: experimenter_experiments
    suggest_dimension: experimenter_experiments.normandy_slug
  }

  measure: Total {
    type: number
    sql: SUM(${value}) ;;
  }

  filter: timeframe {
    type: date
  }
}

view: +experiment_cumulative_search_count {
  dimension: experiment {
    suggest_explore: experimenter_experiments
    suggest_dimension: experimenter_experiments.normandy_slug
  }

  measure: Total {
    type: number
    sql: SUM(${value}) ;;
  }

  filter: timeframe {
    type: date
  }
}

view: +experiment_cumulative_search_with_ads_count {
  dimension: experiment {
    suggest_explore: experimenter_experiments
    suggest_dimension: experimenter_experiments.normandy_slug
  }

  measure: Total {
    type: number
    sql: SUM(${value}) ;;
  }

  filter: timeframe {
    type: date
  }
}

view: +experiment_enrollment_other_events_overall {
  dimension: experiment {
    suggest_explore: experimenter_experiments
    suggest_dimension: experimenter_experiments.normandy_slug
  }

  dimension: timestamp {
    type: date_time
    sql: CASE
        WHEN DATE_DIFF(DATE({% date_end timeframe %}), DATE({% date_start timeframe %}), DAY) BETWEEN 5 AND 30 THEN TIMESTAMP_TRUNC(TIMESTAMP(${time_time}), HOUR)
        WHEN DATE_DIFF(DATE({% date_end timeframe %}), DATE({% date_start timeframe %}), DAY) >= 30 THEN TIMESTAMP_TRUNC(TIMESTAMP(${time_time}), DAY)
        ELSE TIMESTAMP(${time_time})
      END;;
  }

  measure: Total {
    type: number
    sql: SUM(${value}) ;;
  }

  filter: timeframe {
    type: date
  }
}

view: +experiment_enrollment_overall {
  dimension: experiment {
    suggest_explore: experimenter_experiments
    suggest_dimension: experimenter_experiments.normandy_slug
  }

  dimension: timestamp {
    type: date_time
    sql: CASE
        WHEN DATE_DIFF(DATE({% date_end timeframe %}), DATE({% date_start timeframe %}), DAY) BETWEEN 5 AND 30 THEN TIMESTAMP_TRUNC(TIMESTAMP(${time_time}), HOUR)
        WHEN DATE_DIFF(DATE({% date_end timeframe %}), DATE({% date_start timeframe %}), DAY) >= 30 THEN TIMESTAMP_TRUNC(TIMESTAMP(${time_time}), DAY)
        ELSE TIMESTAMP(${time_time})
      END;;
  }

  measure: Total {
    type: number
    sql: SUM(${value}) ;;
  }

  filter: timeframe {
    type: date
  }
}

view: +experiment_unenrollment_overall {
  dimension: experiment {
    suggest_explore: experimenter_experiments
    suggest_dimension: experimenter_experiments.normandy_slug
  }

  dimension: timestamp {
    type: date_time
    sql: CASE
        WHEN DATE_DIFF(DATE({% date_end timeframe %}), DATE({% date_start timeframe %}), DAY) BETWEEN 5 AND 30 THEN TIMESTAMP_TRUNC(TIMESTAMP(${time_time}), HOUR)
        WHEN DATE_DIFF(DATE({% date_end timeframe %}), DATE({% date_start timeframe %}), DAY) >= 30 THEN TIMESTAMP_TRUNC(TIMESTAMP(${time_time}), DAY)
        ELSE TIMESTAMP(${time_time})
      END;;
  }

  measure: Total {
    type: number
    sql: SUM(${value}) ;;
  }

  filter: timeframe {
    type: date
  }
}

view: +experiment_search_aggregates_live {
  dimension: experiment {
    suggest_explore: experimenter_experiments
    suggest_dimension: experimenter_experiments.normandy_slug
  }

  dimension: timestamp {
    type: date_time
    sql: CASE
        WHEN DATE_DIFF(DATE({% date_end timeframe %}), DATE({% date_start timeframe %}), DAY) BETWEEN 5 AND 30 THEN TIMESTAMP_TRUNC(TIMESTAMP(${window_start_time}), HOUR)
        WHEN DATE_DIFF(DATE({% date_end timeframe %}), DATE({% date_start timeframe %}), DAY) >= 30 THEN TIMESTAMP_TRUNC(TIMESTAMP(${window_start_time}), DAY)
        ELSE TIMESTAMP(${window_start_time})
      END;;
  }

  measure: total_search_count {
    type: number
    sql: SUM(${search_count}) ;;
  }

  measure: total_ad_clicks {
    type: number
    sql: SUM(${ad_clicks_count}) ;;
  }

  measure: total_searches_with_ads {
    type: number
    sql: SUM(${search_with_ads_count}) ;;
  }

  filter: timeframe {
    type: date
  }
}


# Explores

explore: experiment_cumulative_ad_clicks {
  hidden: yes
  sql_always_where:
        ${branch} IS NOT NULL AND
    {% condition experiment_cumulative_ad_clicks.timeframe %} TIMESTAMP(${time_time}) {% endcondition %} AND
    ((EXTRACT(MINUTE FROM TIMESTAMP(${time_time})) = 0 AND
     DATE_DIFF(DATE({% date_end experiment_cumulative_ad_clicks.timeframe %}), DATE({% date_start experiment_cumulative_ad_clicks.timeframe %}), DAY) BETWEEN 5 AND 30) OR
     (EXTRACT(HOUR FROM TIMESTAMP(${time_time})) = 0 AND EXTRACT(MINUTE FROM TIMESTAMP(${time_time})) = 0 AND
     DATE_DIFF(DATE({% date_end experiment_cumulative_ad_clicks.timeframe %}), DATE({% date_start experiment_cumulative_ad_clicks.timeframe %}), DAY) >= 30) OR
     DATE_DIFF(DATE({% date_end experiment_cumulative_ad_clicks.timeframe %}), DATE({% date_start experiment_cumulative_ad_clicks.timeframe %}), DAY) < 5) ;;
}

explore: experiment_cumulative_search_count {
  hidden: yes
  sql_always_where:
  ${branch} IS NOT NULL AND
  {% condition experiment_cumulative_search_count.timeframe %} TIMESTAMP(${time_time}) {% endcondition %} AND
  ((EXTRACT(MINUTE FROM TIMESTAMP(${time_time})) = 0 AND
  DATE_DIFF(DATE({% date_end experiment_cumulative_search_count.timeframe %}), DATE({% date_start experiment_cumulative_search_count.timeframe %}), DAY) BETWEEN 5 AND 30) OR
  (EXTRACT(HOUR FROM TIMESTAMP(${time_time})) = 0 AND EXTRACT(MINUTE FROM TIMESTAMP(${time_time})) = 0 AND
  DATE_DIFF(DATE({% date_end experiment_cumulative_search_count.timeframe %}), DATE({% date_start experiment_cumulative_search_count.timeframe %}), DAY) >= 30) OR
  DATE_DIFF(DATE({% date_end experiment_cumulative_search_count.timeframe %}), DATE({% date_start experiment_cumulative_search_count.timeframe %}), DAY) < 5) ;;
}

explore: experiment_cumulative_search_with_ads_count {
  hidden: yes
  sql_always_where:
  ${branch} IS NOT NULL AND
  {% condition experiment_cumulative_search_with_ads_count.timeframe %} TIMESTAMP(${time_time}) {% endcondition %} AND
  ((EXTRACT(MINUTE FROM TIMESTAMP(${time_time})) = 0 AND
  DATE_DIFF(DATE({% date_end experiment_cumulative_search_with_ads_count.timeframe %}), DATE({% date_start experiment_cumulative_search_with_ads_count.timeframe %}), DAY) BETWEEN 5 AND 30) OR
  (EXTRACT(HOUR FROM TIMESTAMP(${time_time})) = 0 AND EXTRACT(MINUTE FROM TIMESTAMP(${time_time})) = 0 AND
  DATE_DIFF(DATE({% date_end experiment_cumulative_search_with_ads_count.timeframe %}), DATE({% date_start experiment_cumulative_search_with_ads_count.timeframe %}), DAY) >= 30) OR
  DATE_DIFF(DATE({% date_end experiment_cumulative_search_with_ads_count.timeframe %}), DATE({% date_start experiment_cumulative_search_with_ads_count.timeframe %}), DAY) < 5) ;;
}

explore: experiment_enrollment_cumulative_population_estimate {
  hidden: yes
  sql_always_where:
    ${branch} IS NOT NULL AND
    {% condition experiment_enrollment_cumulative_population_estimate.timeframe %} TIMESTAMP(${time_time}) {% endcondition %} AND
    ((EXTRACT(MINUTE FROM TIMESTAMP(${time_time})) = 0 AND
     DATE_DIFF(DATE({% date_end experiment_enrollment_cumulative_population_estimate.timeframe %}), DATE({% date_start experiment_enrollment_cumulative_population_estimate.timeframe %}), DAY) BETWEEN 5 AND 30) OR
     (EXTRACT(HOUR FROM TIMESTAMP(${time_time})) = 0 AND EXTRACT(MINUTE FROM TIMESTAMP(${time_time})) = 0 AND
     DATE_DIFF(DATE({% date_end experiment_enrollment_cumulative_population_estimate.timeframe %}), DATE({% date_start experiment_enrollment_cumulative_population_estimate.timeframe %}), DAY) >= 30) OR
     DATE_DIFF(DATE({% date_end experiment_enrollment_cumulative_population_estimate.timeframe %}), DATE({% date_start experiment_enrollment_cumulative_population_estimate.timeframe %}), DAY) < 5) ;;
}

explore: experiment_enrollment_other_events_overall {
  hidden: yes
  sql_always_where:
  ${branch} IS NOT NULL AND
  {% condition experiment_enrollment_other_events_overall.timeframe %} TIMESTAMP(${time_time}) {% endcondition %};;
}

explore: experiment_enrollment_overall {
  hidden: yes
  sql_always_where:
    ${branch} IS NOT NULL AND
    {% condition experiment_enrollment_overall.timeframe %} TIMESTAMP(${time_time}) {% endcondition %};;
}

explore: experiment_unenrollment_overall {
  hidden: yes
  sql_always_where:
    ${branch} IS NOT NULL AND
    {% condition experiment_unenrollment_overall.timeframe %} TIMESTAMP(${time_time}) {% endcondition %};;
}

explore: experiment_search_aggregates_live {
  hidden: yes
  sql_always_where:
    ${branch} IS NOT NULL AND
    {% condition experiment_search_aggregates_live.timeframe %} TIMESTAMP(${window_start_time}) {% endcondition %};;
}

explore: experiment_enrollment_daily_active_population {
  hidden: yes
}

view: +events {
  dimension: reason {
    type: string
    sql: mozfun.map.get_key(event_map_values, 'reason') ;;
  }
}

explore: unenrollment_reasons {
  view_name: events
  hidden: yes

  sql_always_where:
    ${events.event_method} LIKE "unenroll%" AND
    ${events.event_category} = "normandy";;

  always_filter: {
    filters: [
      events.submission_date: "7 days"
    ]
  }
}

explore: enrollment_status {
  hidden: yes
}

explore: sample_ratio_mismatch {
  hidden: yes
}

explore: logs {
  hidden: yes
}

explore: query_cost {
  hidden: yes
}

explore: task_monitoring_logs {
  hidden: yes
}

explore: task_profiling_logs {
  hidden: yes
}

explore: experimenter_experiments {
  hidden: yes
}