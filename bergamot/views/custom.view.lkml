view: custom {
  sql_table_name: `mozdata.org_mozilla_bergamot.custom` ;;

  dimension: additional_properties {
    sql: ${TABLE}.additional_properties ;;
    type: string
  }

  dimension: client_info__android_sdk_version {
    group_item_label: "Android Sdk Version"
    group_label: "Client Info"
    sql: ${TABLE}.client_info.android_sdk_version ;;
    type: string
  }

  dimension: client_info__app_build {
    group_item_label: "App Build"
    group_label: "Client Info"
    sql: ${TABLE}.client_info.app_build ;;
    type: string
  }

  dimension: client_info__app_channel {
    group_item_label: "App Channel"
    group_label: "Client Info"
    sql: ${TABLE}.client_info.app_channel ;;
    type: string
  }

  dimension: client_info__app_display_version {
    group_item_label: "App Display Version"
    group_label: "Client Info"
    sql: ${TABLE}.client_info.app_display_version ;;
    type: string
  }

  dimension: client_info__architecture {
    group_item_label: "Architecture"
    group_label: "Client Info"
    sql: ${TABLE}.client_info.architecture ;;
    type: string
  }

  dimension: client_info__client_id {
    hidden: yes
    sql: ${TABLE}.client_info.client_id ;;
  }

  dimension: client_info__device_manufacturer {
    group_item_label: "Device Manufacturer"
    group_label: "Client Info"
    sql: ${TABLE}.client_info.device_manufacturer ;;
    type: string
  }

  dimension: client_info__device_model {
    group_item_label: "Device Model"
    group_label: "Client Info"
    sql: ${TABLE}.client_info.device_model ;;
    type: string
  }

  dimension: client_info__first_run_date {
    group_item_label: "First Run Date"
    group_label: "Client Info"
    sql: ${TABLE}.client_info.first_run_date ;;
    type: string
  }

  dimension: client_info__locale {
    group_item_label: "Locale"
    group_label: "Client Info"
    sql: ${TABLE}.client_info.locale ;;
    type: string
  }

  dimension: client_info__os {
    group_item_label: "Os"
    group_label: "Client Info"
    sql: ${TABLE}.client_info.os ;;
    type: string
  }

  dimension: client_info__os_version {
    group_item_label: "Os Version"
    group_label: "Client Info"
    sql: ${TABLE}.client_info.os_version ;;
    type: string
  }

  dimension: client_info__telemetry_sdk_build {
    group_item_label: "Telemetry Sdk Build"
    group_label: "Client Info"
    sql: ${TABLE}.client_info.telemetry_sdk_build ;;
    type: string
  }

  dimension: document_id {
    hidden: yes
    sql: ${TABLE}.document_id ;;
  }

  dimension: events {
    hidden: yes
    sql: ${TABLE}.events ;;
  }

  dimension: metadata__geo__city {
    group_item_label: "City"
    group_label: "Metadata Geo"
    sql: ${TABLE}.metadata.geo.city ;;
    type: string
  }

  dimension: metadata__geo__country {
    group_item_label: "Country"
    group_label: "Metadata Geo"
    map_layer_name: countries
    sql: ${TABLE}.metadata.geo.country ;;
    type: string
  }

  dimension: metadata__geo__db_version {
    group_item_label: "Db Version"
    group_label: "Metadata Geo"
    sql: ${TABLE}.metadata.geo.db_version ;;
    type: string
  }

  dimension: metadata__geo__subdivision1 {
    group_item_label: "Subdivision1"
    group_label: "Metadata Geo"
    sql: ${TABLE}.metadata.geo.subdivision1 ;;
    type: string
  }

  dimension: metadata__geo__subdivision2 {
    group_item_label: "Subdivision2"
    group_label: "Metadata Geo"
    sql: ${TABLE}.metadata.geo.subdivision2 ;;
    type: string
  }

  dimension: metadata__header__date {
    group_item_label: "Date"
    group_label: "Metadata Header"
    sql: ${TABLE}.metadata.header.date ;;
    type: string
  }

  dimension: metadata__header__dnt {
    group_item_label: "Dnt"
    group_label: "Metadata Header"
    sql: ${TABLE}.metadata.header.dnt ;;
    type: string
  }

  dimension: metadata__header__parsed_x_source_tags {
    hidden: yes
    sql: ${TABLE}.metadata.header.parsed_x_source_tags ;;
  }

  dimension: metadata__header__x_debug_id {
    group_item_label: "X Debug Id"
    group_label: "Metadata Header"
    sql: ${TABLE}.metadata.header.x_debug_id ;;
    type: string
  }

  dimension: metadata__header__x_pingsender_version {
    group_item_label: "X Pingsender Version"
    group_label: "Metadata Header"
    sql: ${TABLE}.metadata.header.x_pingsender_version ;;
    type: string
  }

  dimension: metadata__header__x_source_tags {
    group_item_label: "X Source Tags"
    group_label: "Metadata Header"
    sql: ${TABLE}.metadata.header.x_source_tags ;;
    type: string
  }

  dimension: metadata__isp__db_version {
    group_item_label: "Db Version"
    group_label: "Metadata Isp"
    sql: ${TABLE}.metadata.isp.db_version ;;
    type: string
  }

  dimension: metadata__isp__name {
    group_item_label: "Name"
    group_label: "Metadata Isp"
    sql: ${TABLE}.metadata.isp.name ;;
    type: string
  }

  dimension: metadata__isp__organization {
    group_item_label: "Organization"
    group_label: "Metadata Isp"
    sql: ${TABLE}.metadata.isp.organization ;;
    type: string
  }

  dimension: metadata__user_agent__browser {
    group_item_label: "Browser"
    group_label: "Metadata User Agent"
    sql: ${TABLE}.metadata.user_agent.browser ;;
    type: string
  }

  dimension: metadata__user_agent__os {
    group_item_label: "Os"
    group_label: "Metadata User Agent"
    sql: ${TABLE}.metadata.user_agent.os ;;
    type: string
  }

  dimension: metadata__user_agent__version {
    group_item_label: "Version"
    group_label: "Metadata User Agent"
    sql: ${TABLE}.metadata.user_agent.version ;;
    type: string
  }

  dimension: metrics__counter__errors_marian {
    group_item_label: "Errors Marian"
    group_label: "Metrics Counter"
    sql: ${TABLE}.metrics.counter.errors_marian ;;
    type: number
  }

  dimension: metrics__counter__errors_memory {
    group_item_label: "Errors Memory"
    group_label: "Metrics Counter"
    sql: ${TABLE}.metrics.counter.errors_memory ;;
    type: number
  }

  dimension: metrics__counter__errors_model_download {
    group_item_label: "Errors Model Download"
    group_label: "Metrics Counter"
    sql: ${TABLE}.metrics.counter.errors_model_download ;;
    type: number
  }

  dimension: metrics__counter__errors_translation {
    group_item_label: "Errors Translation"
    group_label: "Metrics Counter"
    sql: ${TABLE}.metrics.counter.errors_translation ;;
    type: number
  }

  dimension: metrics__counter__service_lang_mismatch {
    group_item_label: "Service Lang Mismatch"
    group_label: "Metrics Counter"
    sql: ${TABLE}.metrics.counter.service_lang_mismatch ;;
    type: number
  }

  dimension: metrics__counter__service_not_suppported {
    group_item_label: "Service Not Suppported"
    group_label: "Metrics Counter"
    sql: ${TABLE}.metrics.counter.service_not_suppported ;;
    type: number
  }

  dimension: metrics__counter__test_counter_test {
    group_item_label: "Test Counter Test"
    group_label: "Metrics Counter"
    sql: ${TABLE}.metrics.counter.test_counter_test ;;
    type: number
  }

  dimension: metrics__jwe {
    hidden: yes
    sql: ${TABLE}.metrics.jwe ;;
  }

  dimension: metrics__labeled_rate {
    hidden: yes
    sql: ${TABLE}.metrics.labeled_rate ;;
  }

  dimension: metrics__string__metadata_from_lang {
    group_item_label: "Metadata From Lang"
    group_label: "Metrics String"
    sql: ${TABLE}.metrics.string.metadata_from_lang ;;
    type: string
  }

  dimension: metrics__string__metadata_to_lang {
    group_item_label: "Metadata To Lang"
    group_label: "Metrics String"
    sql: ${TABLE}.metrics.string.metadata_to_lang ;;
    type: string
  }

  dimension: metrics__string__performance_model_download_time {
    group_item_label: "Performance Model Download Time"
    group_label: "Metrics String"
    sql: ${TABLE}.metrics.string.performance_model_download_time ;;
    type: string
  }

  dimension: metrics__string__performance_model_load_time {
    group_item_label: "Performance Model Load Time"
    group_label: "Metrics String"
    sql: ${TABLE}.metrics.string.performance_model_load_time ;;
    type: string
  }

  dimension: metrics__string__performance_translation_quality {
    group_item_label: "Performance Translation Quality"
    group_label: "Metrics String"
    sql: ${TABLE}.metrics.string.performance_translation_quality ;;
    type: string
  }

  dimension: metrics__string__performance_translation_time {
    group_item_label: "Performance Translation Time"
    group_label: "Metrics String"
    sql: ${TABLE}.metrics.string.performance_translation_time ;;
    type: string
  }

  dimension: metrics__string__performance_words_per_second {
    group_item_label: "Performance Words Per Second"
    group_label: "Metrics String"
    sql: ${TABLE}.metrics.string.performance_words_per_second ;;
    type: string
  }

  dimension: metrics__string__test_string_test {
    group_item_label: "Test String Test"
    group_label: "Metrics String"
    sql: ${TABLE}.metrics.string.test_string_test ;;
    type: string
  }

  dimension: normalized_app_name {
    sql: ${TABLE}.normalized_app_name ;;
    type: string
  }

  dimension: normalized_channel {
    sql: ${TABLE}.normalized_channel ;;
    type: string
  }

  dimension: normalized_country_code {
    sql: ${TABLE}.normalized_country_code ;;
    type: string
  }

  dimension: normalized_os {
    sql: ${TABLE}.normalized_os ;;
    type: string
  }

  dimension: normalized_os_version {
    sql: ${TABLE}.normalized_os_version ;;
    type: string
  }

  dimension: ping_info__end_time {
    group_item_label: "End Time"
    group_label: "Ping Info"
    sql: ${TABLE}.ping_info.end_time ;;
    type: string
  }

  dimension: ping_info__experiments {
    hidden: yes
    sql: ${TABLE}.ping_info.experiments ;;
  }

  dimension: ping_info__ping_type {
    group_item_label: "Ping Type"
    group_label: "Ping Info"
    sql: ${TABLE}.ping_info.ping_type ;;
    type: string
  }

  dimension: ping_info__reason {
    group_item_label: "Reason"
    group_label: "Ping Info"
    sql: ${TABLE}.ping_info.reason ;;
    type: string
  }

  dimension: ping_info__seq {
    group_item_label: "Seq"
    group_label: "Ping Info"
    sql: ${TABLE}.ping_info.seq ;;
    type: number
  }

  dimension: ping_info__start_time {
    group_item_label: "Start Time"
    group_label: "Ping Info"
    sql: ${TABLE}.ping_info.start_time ;;
    type: string
  }

  dimension: sample_id {
    sql: ${TABLE}.sample_id ;;
    type: number
  }

  dimension_group: metadata__header__parsed {
    group_item_label: "Parsed Date"
    group_label: "Metadata Header"
    sql: ${TABLE}.metadata.header.parsed_date ;;
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    type: time
  }

  dimension_group: ping_info__parsed_end {
    group_item_label: "Parsed End Time"
    group_label: "Ping Info"
    sql: ${TABLE}.ping_info.parsed_end_time ;;
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    type: time
  }

  dimension_group: ping_info__parsed_start {
    group_item_label: "Parsed Start Time"
    group_label: "Ping Info"
    sql: ${TABLE}.ping_info.parsed_start_time ;;
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    type: time
  }

  dimension_group: submission {
    sql: ${TABLE}.submission_timestamp ;;
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    type: time
  }

  measure: clients {
    type: count_distinct
    sql: ${client_info__client_id} ;;
  }

  measure: ping_count {
    type: count
  }
}