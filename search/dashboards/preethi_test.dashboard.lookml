- dashboard: preethi_test
  title: preethi_test
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  preferred_slug: sleK4zWPTtjUTTAsR2iO4U
  elements:
  - title: Untitled
    name: Untitled
    model: search
    explore: desktop_search_counts
    type: looker_line
    fields: [search_clients_engines_sources_daily.total_ad_clicks, search_clients_engines_sources_daily.submission_date]
    fill_fields: [search_clients_engines_sources_daily.submission_date]
    filters:
      search_clients_engines_sources_daily.submission_date: 28 days
    sorts: [search_clients_engines_sources_daily.submission_date desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    series_types: {}
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    row:
    col:
    width:
    height:
