- dashboard: leifdemo
  title: leif-demo
  layout: newspaper
  preferred_viewer: dashboards-next
  elements:
  - title: Untitled
    name: Untitled
    model: kpi
    explore: recent_desktop_forecast
    type: looker_line
    fields: [recent_desktop_forecast.date, recent_desktop_forecast.dau_forecast_7day_ma]
    fill_fields: [recent_desktop_forecast.date]
    filters:
      recent_desktop_forecast.forecast_recency: '1'
    sorts: [recent_desktop_forecast.date desc]
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
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    defaults_version: 1
    series_types: {}
    row:
    col:
    width:
    height:
