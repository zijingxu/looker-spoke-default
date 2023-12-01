include: "../views/multi_service_accounts.view.lkml"

explore: multi_service_accounts {
  label: "Daily Multi-Service Active Accounts"

  conditionally_filter: {
    filters: [date_date: "30 days ago for 30 days"]
    unless: [date_week, date_month, date_quarter, date_year]
  }

}
