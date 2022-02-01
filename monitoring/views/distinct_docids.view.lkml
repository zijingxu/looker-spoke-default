view: distinct_docids {
  derived_table: {
    sql:
      SELECT
        submission_date,
        namespace,
        doc_type,
        decoded,
        live,
        stable,
      FROM `moz-fx-data-shared-prod.monitoring.structured_distinct_docids`
      UNION ALL
      SELECT
        submission_date,
        'telemetry',
        doc_type,
        decoded,
        live,
        stable,
      FROM `moz-fx-data-shared-prod.monitoring.telemetry_distinct_docids`
    ;;
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

  dimension: namespace {
    sql: ${TABLE}.namespace ;;
    type: string
  }

  dimension: doc_type {
    sql: ${TABLE}.doc_type ;;
    type: string
  }

  dimension: decoded {
    sql: ${TABLE}.decoded ;;
    type: number
  }

  dimension: live {
    sql: ${TABLE}.live ;;
    type: number
  }

  dimension: stable {
    sql: ${TABLE}.stable ;;
    type: number
  }


}

view: non_matching {
  derived_table: {
    sql: SELECT
    submission_date,
    COUNTIF(
      decoded != live OR decoded != stable
    ) AS non_matching_count,
    FROM distinct_docids
    GROUP BY
    submission_date;;
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

  dimension: non_matching_count {
    sql: ${TABLE}.non_matching_count ;;
    type: number
  }
}
view: all_schema_errors {
  derived_table: {
    sql: WITH top_errors AS
        (SELECT document_namespace,
                document_type,
                PATH,
                sum(error_count) AS error_count
         FROM `mozdata`.monitoring.schema_error_counts
         GROUP BY document_namespace,
                  document_type,
                  PATH
         ORDER BY error_count DESC
         LIMIT 10),
           filtered AS
        (SELECT date_trunc(cast(HOUR AS date), DAY) AS submission_date,
                document_namespace,
                document_type,
                PATH,
                sum(error_count) AS error_count
         FROM `mozdata`.monitoring.schema_error_counts
         RIGHT JOIN
           (SELECT * except(error_count)
            FROM top_errors) USING (document_namespace,
                                    document_type,
                                    PATH)
         GROUP BY submission_date,
                  document_namespace,
                  document_type,
                  PATH)
      SELECT submission_date,
             concat(PATH, " [", document_namespace, ".", document_type, "]") AS grouped,
             error_count
      FROM filtered
      WHERE submission_date between date_sub(current_date, interval 28 day) and current_date
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: submission_date {
    type: date
    datatype: date
    sql: ${TABLE}.submission_date ;;
  }

  dimension: grouped {
    type: string
    sql: ${TABLE}.grouped ;;
  }

  dimension: error_count {
    type: number
    sql: ${TABLE}.error_count ;;
  }

  set: detail {
    fields: [submission_date, grouped, error_count]
  }
}
