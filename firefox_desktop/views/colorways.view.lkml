# not finished, for demo only
view: colorways {
  derived_table: {
    sql: WITH DATA AS
        (SELECT
                submission_date,
                count(DISTINCT client_id) AS cc,
                colorway_id,
                count(DISTINCT CASE
                                   WHEN active_theme.addon_id IN ("visionary-balanced-colorway@mozilla.org", "visionary-bold-colorway@mozilla.org", "visionary-soft-colorway@mozilla.org",
                                                                  "playmaker-balanced-colorway@mozilla.org", "playmaker-bold-colorway@mozilla.org", "playmaker-soft-colorway@mozilla.org",
                                                                  "innovator-balanced-colorway@mozilla.org", "innovator-bold-colorway@mozilla.org", "innovator-soft-colorway@mozilla.org",
                                                                  "expressionist-balanced-colorway@mozilla.org", "expressionist-bold-colorway@mozilla.org", "expressionist-soft-colorway@mozilla.org",
                                                                  "dreamer-balanced-colorway@mozilla.org", "dreamer-bold-colorway@mozilla.org", "dreamer-soft-colorway@mozilla.org",
                                                                  "activist-balanced-colorway@mozilla.org", "activist-bold-colorway@mozilla.org", "activist-soft-colorway@mozilla.org") THEN client_id
                                   ELSE NULL
                               END) AS has_colorway
         FROM telemetry.main_summary_v4
         WHERE submission_date >= '2022-10-18'
           AND channel = 'release'
           AND SAFE_CAST(substr(app_version, 1, 3) AS float64) >= 106
          GROUP BY submission_date)
      SELECT submission_date, has_colorway,
             has_colorway/ cc * 100 AS pct_has_colorway,
      FROM DATA
      ORDER BY submission_date
       ;;
  }

  dimension: submission_date {
    type: date
    datatype: date
    sql: ${TABLE}.submission_date ;;
  }

  measure: has_colorway {
    type: sum
    sql: ${TABLE}.has_colorway ;;
  }

  measure: pct_has_colorway {
    type: number
    sql: ${TABLE}.pct_has_colorway ;;
  }

  set: detail {
    fields: [submission_date, has_colorway, pct_has_colorway]
  }
}
