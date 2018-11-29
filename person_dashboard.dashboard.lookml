- dashboard: person_dashboard
  title: Person Dashboard
  layout: newspaper
  elements:
  - title: Full Name
    name: Full Name
    model: military_surveillance
    explore: person
    type: single_value
    fields:
    - person.full_name
    sorts:
    - person.full_name
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
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
    series_types: {}
    listen:
      Person ID: person.id
      Risk Threshold: person.threshold_for_risk
    row: 0
    col: 0
    width: 5
    height: 2
  - title: Photo
    name: Photo
    model: military_surveillance
    explore: person
    type: single_value
    fields:
    - person.photo_suspect
    limit: 500
    custom_color_enabled: false
    custom_color: forestgreen
    show_single_value_title: false
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
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
    series_types: {}
    listen:
      Person ID: person.id
      Risk Threshold: person.threshold_for_risk
    row: 0
    col: 5
    width: 4
    height: 4
  - title: Details
    name: Details
    model: military_surveillance
    explore: person
    type: looker_single_record
    fields:
    - person.full_name
    - person.id
    - person.height
    - person.weight
    sorts:
    - person.full_name
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
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
    series_types: {}
    listen:
      Person ID: person.id
      Risk Threshold: person.threshold_for_risk
    row: 4
    col: 5
    width: 4
    height: 4
  - title: Status Update
    name: Status Update
    model: military_surveillance
    explore: person
    type: table
    fields:
    - status.id
    - status.modality
    - status.status
    - status.date_last_updated
    sorts:
    - status.date_last_updated desc
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: false
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      status.date_last_updated: Date
      status.id: ID
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Person ID: person.id
      Risk Threshold: person.threshold_for_risk
    row: 4
    col: 0
    width: 5
    height: 4
  - title: Evidence List
    name: Evidence List
    model: military_surveillance
    explore: person
    type: table
    fields:
    - evidence.id
    - evidence.file_type
    - evidence.evidence_type
    - evidence.file_name_photo
    - evidence.file_name
    sorts:
    - evidence.id
    limit: 500
    column_limit: 50
    show_view_names: true
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Person ID: person.id
      Risk Threshold: person.threshold_for_risk
    row: 18
    col: 0
    width: 24
    height: 7
  - title: Risk Score
    name: Risk Score
    model: military_surveillance
    explore: person
    type: looker_column
    fields:
    - risk.risk_score
    - person.average_risk_score
    - person_to_person_activity.connection_score_risk
    - average_suspicious_score.average_suspicious_activity_score
    limit: 500
    column_limit: 50
    stacking: ''
    colors:
    - "#5245ed"
    - "#ed6168"
    - "#1ea8df"
    - "#353b49"
    - "#49cec1"
    - "#b3a0dd"
    - "#db7f2a"
    - "#706080"
    - "#a2dcf3"
    - "#776fdf"
    - "#e9b404"
    - "#635189"
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors: {}
    series_labels:
      person.average_risk_score: Biometrics Risk
      person_to_person_activity.connection_score_risk: Connections Risk
      average_suspicious_score.average_suspicious_activity_score: Suspicious Activity
        Risk
    series_types: {}
    limit_displayed_rows: false
    y_axes:
    - label: ''
      orientation: left
      series:
      - id: person.average_risk_score
        name: Biometrics Risk
        axisId: person.average_risk_score
      - id: person_to_person_activity.connection_score_risk
        name: Connections Risk
        axisId: person_to_person_activity.connection_score_risk
      - id: average_suspicious_score.average_suspicious_activity_score
        name: Suspicious Activity Risk
        axisId: average_suspicious_score.average_suspicious_activity_score
      showLabels: true
      showValues: true
      maxValue: 1
      minValue: 0
      unpinAxis: false
      tickDensity: default
      tickDensityCustom: 5
      type: linear
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
    listen:
      Person ID: person.id
      Risk Threshold: person.threshold_for_risk
      Weight - Biometrics: risk.weight_biometric_risk
      Weight - Connection: risk.weight_connection_risk
      Weight - Activity: risk.weight_activity_risk
    row: 0
    col: 9
    width: 6
    height: 8
  - title: Top Connections
    name: Top Connections
    model: military_surveillance
    explore: person
    type: table
    fields:
    - person_to_person_activity.connected_person
    - person_to_person_activity.connected_person_photo
    - person_to_person_activity.connection_score
    - person_to_person_activity.total_talk_time
    - person_to_person_activity.total_photos
    - person_to_person_activity.avg_risk_score_out
    sorts:
    - person_to_person_activity.connection_score desc
    limit: 20
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      person_to_person_activity.connected_person: PersonID
      person_to_person_activity.avg_risk_score_out: Biometric Risk
      person_to_person_activity.connection_score: Connection Score
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
      - person_to_person_activity.avg_risk_score_out
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Person ID: person.id
      Risk Threshold: person.threshold_for_risk
    row: 0
    col: 15
    width: 9
    height: 8
  - title: Map of Top Connections
    name: Map of Top Connections
    model: military_surveillance
    explore: person
    type: looker_map
    fields:
    - person_to_person_activity.location_person
    - person_to_person_activity.location_person_out
    - person_to_person_activity.avg_risk_score_out
    sorts:
    - person_to_person_activity.location_person
    limit: 15
    column_limit: 50
    map_plot_mode: lines
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: false
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      person_to_person_activity.connected_person: PersonID
      person_to_person_activity.avg_risk_score_out: Biometric Risk
      person_to_person_activity.connection_score: Connection Score
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting:
    - type: low to high
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
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    listen:
      Person ID: person.id
      Risk Threshold: person.threshold_for_risk
    row: 8
    col: 16
    width: 8
    height: 5
  - title: Talk Time by Risk
    name: Talk Time by Risk
    model: military_surveillance
    explore: person
    type: looker_pie
    fields:
    - person_to_person_activity.total_talk_time
    - person_to_person_activity.is_risky_suspect_out
    fill_fields:
    - person_to_person_activity.is_risky_suspect_out
    sorts:
    - person_to_person_activity.is_risky_suspect_out
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    series_colors:
      'No': "#8BC34A"
      'Yes': "#ff3b3b"
    series_labels:
      'No': Not Risky
      'Yes': Risky
    series_types: {}
    listen:
      Person ID: person.id
      Risk Threshold: person.threshold_for_risk
    row: 13
    col: 12
    width: 4
    height: 5
  - title: "# Photos by Risk"
    name: "# Photos by Risk"
    model: military_surveillance
    explore: person
    type: looker_pie
    fields:
    - person_to_person_activity.is_risky_suspect_out
    - person_to_person_activity.total_photos
    fill_fields:
    - person_to_person_activity.is_risky_suspect_out
    sorts:
    - person_to_person_activity.is_risky_suspect_out
    limit: 500
    column_limit: 50
    value_labels: legend
    label_type: labPer
    series_colors:
      'No': "#8BC34A"
      'Yes': "#ff3b3b"
    series_labels:
      'No': Not Risky
      'Yes': Risky
    series_types: {}
    listen:
      Person ID: person.id
      Risk Threshold: person.threshold_for_risk
    row: 13
    col: 8
    width: 4
    height: 5
  - title: "# Calls by Month by Risk"
    name: "# Calls by Month by Risk"
    model: military_surveillance
    explore: person
    type: looker_area
    fields:
    - person_to_person_activity.is_risky_suspect_out
    - call.call_month
    - call.count_calls
    pivots:
    - person_to_person_activity.is_risky_suspect_out
    fill_fields:
    - person_to_person_activity.is_risky_suspect_out
    - call.call_month
    filters:
      call.call_month: 12 months
    sorts:
    - person_to_person_activity.is_risky_suspect_out desc
    limit: 500
    column_limit: 50
    stacking: normal
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    point_style: none
    series_colors:
      'No': "#8BC34A"
      'Yes': "#ff3b3b"
    series_labels:
      'No': Not Risky
      'Yes': Risky
    series_types: {}
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
    show_null_points: true
    interpolation: linear
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    value_labels: legend
    label_type: labPer
    listen:
      Person ID: person.id
      Risk Threshold: person.threshold_for_risk
    row: 13
    col: 0
    width: 8
    height: 5
  - title: Social Media
    name: Social Media
    model: military_surveillance
    explore: person
    type: table
    fields:
    - social_media.post
    - social_media.score
    sorts:
    - social_media.score
    limit: 500
    column_limit: 50
    listen:
      Person ID: person.id
      Risk Threshold: person.threshold_for_risk
    row: 13
    col: 16
    width: 8
    height: 5
  - title: Calls & Photos Near Terrorist Events
    name: Calls & Photos Near Terrorist Events
    model: military_surveillance
    explore: event_activity_connection
    type: looker_map
    fields:
    - event_activity_connection.location_activity
    - event_activity_connection.location_event
    - event_activity_connection.average_days_from_event
    filters:
      event_activity_connection.is_suspicious_activity: 'Yes'
    sorts:
    - event_activity_connection.average_days_from_event desc
    limit: 500
    map_plot_mode: lines
    heatmap_gridlines: false
    heatmap_gridlines_empty: false
    heatmap_opacity: 0.5
    show_region_field: true
    draw_map_labels_above_data: true
    map_tile_provider: light
    map_position: fit_data
    map_scale_indicator: 'off'
    map_pannable: true
    map_zoomable: true
    map_marker_type: circle
    map_marker_icon_name: default
    map_marker_radius_mode: proportional_value
    map_marker_units: meters
    map_marker_proportional_scale_type: linear
    map_marker_color_mode: fixed
    show_view_names: true
    show_legend: true
    quantize_map_value_colors: false
    reverse_map_value_colors: false
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    point_style: none
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
    series_types: {}
    listen:
      Person ID: person.id
      Miles from Event: event_activity_connection.miles_from_event
      Days from Event: event_activity_connection.days_from_event
    row: 8
    col: 0
    width: 6
    height: 5
  - title: Activities Near Terrorist Events
    name: Activities Near Terrorist Events
    model: military_surveillance
    explore: event_activity_connection
    type: table
    fields:
    - event_activity_connection.event_name
    - event_activity_connection.activity_type
    - event_activity_connection.average_days_from_event
    - event_activity_connection.average_distance_from_event
    filters:
      event_activity_connection.is_suspicious_activity: 'Yes'
    sorts:
    - event_activity_connection.average_days_from_event
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    truncate_column_names: false
    subtotals_at_bottom: false
    hide_totals: false
    hide_row_totals: false
    series_labels:
      event_activity_connection.average_days_from_event: Days from Event
      event_activity_connection.average_distance_from_event: Distance from Event
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: true
    conditional_formatting:
    - type: low to high
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
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Person ID: person.id
    row: 8
    col: 6
    width: 10
    height: 5
  - title: Risk Score 2
    name: Risk Score 2
    model: military_surveillance
    explore: person
    type: single_value
    fields:
    - risk.risk_score
    limit: 500
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    point_style: none
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
    series_types: {}
    listen:
      Person ID: person.id
      Risk Threshold: person.threshold_for_risk
    row: 2
    col: 0
    width: 5
    height: 2
  filters:
  - name: Person ID
    title: Person ID
    type: field_filter
    default_value: '116'
    allow_multiple_values: true
    required: false
    model: military_surveillance
    explore: person
    listens_to_filters: []
    field: person.id
  - name: Risk Threshold
    title: Risk Threshold
    type: field_filter
    default_value: '60'
    allow_multiple_values: true
    required: false
    model: military_surveillance
    explore: person
    listens_to_filters: []
    field: person.threshold_for_risk
  - name: Weight - Biometrics
    title: Weight - Biometrics
    type: field_filter
    default_value: '2'
    allow_multiple_values: true
    required: false
    model: military_surveillance
    explore: person
    listens_to_filters: []
    field: risk.weight_biometric_risk
  - name: Weight - Connection
    title: Weight - Connection
    type: field_filter
    default_value: '3'
    allow_multiple_values: true
    required: false
    model: military_surveillance
    explore: person
    listens_to_filters: []
    field: risk.weight_connection_risk
  - name: Weight - Activity
    title: Weight - Activity
    type: field_filter
    default_value: '1'
    allow_multiple_values: true
    required: false
    model: military_surveillance
    explore: person
    listens_to_filters: []
    field: risk.weight_activity_risk
  - name: Miles from Event
    title: Miles from Event
    type: field_filter
    default_value: '30'
    allow_multiple_values: true
    required: false
    model: military_surveillance
    explore: event_activity_connection
    listens_to_filters: []
    field: event_activity_connection.miles_from_event
  - name: Days from Event
    title: Days from Event
    type: field_filter
    default_value: '15'
    allow_multiple_values: true
    required: false
    model: military_surveillance
    explore: event_activity_connection
    listens_to_filters: []
    field: event_activity_connection.days_from_event
