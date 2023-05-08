include: "//looker-hub/mozilla_vpn/views/events.view.lkml"

explore: events {
  sql_always_where:  ${events.submission_date} >= '2010-01-01'
    AND (
      ${events.metadata__header__x_telemetry_agent} LIKE "%Kotlin%"
      OR ${events.metadata__header__x_telemetry_agent} LIKE "%JS%"
    ) ;;
}
