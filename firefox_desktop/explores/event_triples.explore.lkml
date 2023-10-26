include: "../views/event_triples.view.lkml"

explore: event_triples {
  sql_always_where: ${event_triples.submission_date} >= '2010-01-01' ;;
  view_name: event_triples
  description: "Triples of events."

  always_filter: {
    filters: [
      submission_date: "28 days",
    ]
  }
}
