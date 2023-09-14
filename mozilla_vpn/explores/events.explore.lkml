include: "//looker-hub/mozilla_vpn/explores/events.explore.lkml"

explore: +event_counts {
  sql_always_where:  ${events.submission_date} >= '2010-01-01'
      AND (
        -- For version below 2.16 Kotlin and JS were the main Glean integrations.
        -- For version 2.16 and above Kotlin, Swift, and Rust are the main Glean integrations.
        CASE WHEN (SAFE_CAST(SPLIT(${events.client_info__app_display_version}, '.')[SAFE_ORDINAL(1)] AS INTEGER) < 2 OR (SAFE_CAST(SPLIT(${events.client_info__app_display_version}, '.')[SAFE_ORDINAL(1)] AS INTEGER) = 2 AND SAFE_CAST(SPLIT(${events.client_info__app_display_version}, '.')[SAFE_ORDINAL(2)] AS INTEGER) < 16 ))
        THEN (${events.metadata__header__x_telemetry_agent} LIKE ANY ("%Kotlin%", "%JS%"))
        ELSE (${events.metadata__header__x_telemetry_agent} LIKE ANY ("%Kotlin%", "%Swift%", "%Rust%"))
        END
      ) ;;
}
