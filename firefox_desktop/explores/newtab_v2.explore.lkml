include: "../views/newtab_v2.view.lkml"
include: "../../shared/views/countries.view.lkml"

explore: newtab_interactions_v2 {
  sql_always_where: ${newtab_interactions_v2.submission_date} >= '2022-07-01' ;;
  label: "New Tab Interactions"
  from: newtab_interaction

  always_filter: {
    filters: [
      submission_date: "28 days",
    ]
  }

  join: countries {
    type: left_outer
    relationship: one_to_one
    sql_on: ${newtab_interactions_v2.country_code} = ${countries.code} ;;
  }

  join: interaction__topsite_interactions {
    relationship: one_to_many
    view_label: "Topsite Interactions"
    sql: LEFT JOIN UNNEST(${newtab_interactions_v2.topsite_interactions}) AS interaction__topsite_interactions ;;
  }

  join: interaction__search_interactions {
    relationship: one_to_many
    view_label: "Search Interactions"
    sql: LEFT JOIN UNNEST(${newtab_interactions_v2.search_interactions}) AS interaction__search_interactions ;;
  }

  join: interaction__pocket_interactions {
    relationship: one_to_many
    view_label: "Pocket Interactions"
    sql: LEFT JOIN UNNEST(${newtab_interactions_v2.pocket_interactions}) AS interaction__pocket_interactions ;;
  }

}
