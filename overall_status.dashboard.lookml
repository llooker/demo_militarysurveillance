- dashboard: overall_status
  title: Overall Status
  layout: newspaper
  elements:
  - title: Case Summary
    name: Case Summary
    model: military_surveillance
    explore: person
    type: looker_column
    fields:
    - status.date_last_updated
    - status.status
    - status.count_statuses
    pivots:
    - status.status
    fill_fields:
    - status.date_last_updated
    sorts:
    - status.date_last_updated desc
    - status.status
    limit: 90
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors:
      Submitted - status.count_statuses: "#00BCD4"
      Confirmed - status.count_statuses: "#4CAF50"
      Waiting - status.count_statuses: "#607D8B"
    series_labels:
      Submitted - status.count_statuses: Submitted
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen: {}
    row: 0
    col: 0
    width: 10
    height: 7
  - title: Riskiest Open Cases
    name: Riskiest Open Cases
    model: military_surveillance
    explore: person
    type: table
    fields:
    - status.date_last_updated
    - status.person_id
    - status.modality
    - status.status
    - person.average_risk_score
    filters:
      status.status: "-Confirmed"
    sorts:
    - person.average_risk_score desc
    limit: 90
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      Submitted - status.count_statuses: Submitted
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting:
    - type: high to low
      value:
      background_color:
      font_color:
      palette:
        name: Red to Yellow to Green
        colors:
        - "#F36254"
        - "#FCF758"
        - "#4FBC89"
      bold: false
      italic: false
      strikethrough: false
      fields:
      - person.average_risk_score
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
    series_colors:
      Submitted - status.count_statuses: "#ffbc3b"
      Confirmed - status.count_statuses: "#4CAF50"
      Waiting - status.count_statuses: "#ff3b3b"
    series_types: {}
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    listen: {}
    row: 0
    col: 10
    width: 14
    height: 7
