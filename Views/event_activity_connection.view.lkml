view: average_suspicious_score {
  derived_table: {
    explore_source: event_activity_connection {
      column: suspicious_activity_score {}
      column: person_id {}
    }
  }
  dimension: suspicious_activity_score {
    hidden: yes
    label: "Event Suspicious Activity Score"
    value_format: "#,##0.00%"
    type: number
  }
  dimension: person_id {
    hidden: yes
    primary_key: yes
    type: number
  }
  measure: average_suspicious_activity_score {
    view_label: "Risk"
    label: "Suspicious Activity Score"
    description: "% of nearby terrorist events in the area where person has been active nearby"
    type: average
    sql: ${suspicious_activity_score} ;;
    value_format_name: percent_2
    drill_fields: [
      person_id,
      suspicious_activity_score
    ]
  }
}


view: event_activity_connection {

  dimension: pk {
    primary_key: yes
    type: string
    sql: concat(cast(${event_id} as string),'-',${activity_type},'-',cast(${activity_id} as string),'-',cast(${person_id} as string)) ;;
  }
  dimension: event_id {
    type: number
  }
  dimension: event_name {
  }
  dimension_group: event {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      week,
      month,
      year
    ]
    sql: cast(${TABLE}.event_time as timestamp) ;;
  }
  dimension: event_latitude {
    hidden: yes
    type: number
  }
  dimension: event_longitude {
    hidden: yes
    type: number
  }
  dimension: location_event {
    type: location
    sql_latitude: ${event_latitude} ;;
    sql_longitude: ${event_longitude} ;;
  }
  dimension: activity_type {
  }
  dimension: activity_id {
    type: number
  }
  dimension: person_id {
    type: number
    link: {
      label: "Person Lookup"
      url: "https://demoexpo.looker.com/dashboards/52?Person%20ID={{ value }}"
      icon_url: "https://looker.com/favicon.ico"
    }
  }
  dimension_group: activity {
    type: time
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      week,
      month,
      year
    ]
    sql: cast(${TABLE}.activity_time as timestamp) ;;
  }
  dimension: activity_latitude {
    hidden: yes
    type: number
  }
  dimension: activity_longitude {
    hidden: yes
    type: number
  }
  dimension: location_activity {
    type: location
    sql_latitude: ${activity_latitude} ;;
    sql_longitude: ${activity_longitude} ;;
  }
  dimension: distance_from_event {
    type: distance
    start_location_field: location_event
    end_location_field: location_activity
    units: miles
  }
  measure: average_distance_from_event {
    type: average
    sql: ${distance_from_event} ;;
    value_format_name: decimal_1
    drill_fields: [drill*]
  }
  dimension: number_of_days_from_event {
    type: duration_day
    sql_start: ${event_raw} ;;
    sql_end: ${activity_raw};;
  }
  measure: average_days_from_event {
    type: average
    sql: abs(${number_of_days_from_event}) ;;
    value_format_name: decimal_0
    drill_fields: [drill*]
  }
  parameter: days_from_event {
    type: unquoted
    default_value: "15"
  }
  dimension: within_days_from_event {
    hidden: yes
    type: yesno
    sql: abs(${number_of_days_from_event}) <= {% parameter days_from_event %} ;;
  }
  parameter: miles_from_event {
    type: unquoted
    default_value: "30"
  }
  dimension: within_miles_from_event {
    hidden: yes
    type: yesno
    sql: ${distance_from_event} <= {% parameter miles_from_event %} ;;
  }
  dimension: is_suspicious_activity {
    type: yesno
    sql: ${within_days_from_event} AND ${within_miles_from_event} ;;
  }
  measure: number_suspicious_activities {
    type: count
    filters: {
      field: is_suspicious_activity
      value: "Yes"
    }
    drill_fields: [drill*]
  }
  measure: suspicious_activity_score {
    type: number
    sql: 1.0*${number_suspicious_activities} / nullif(${max_suspicious_activities_max_max.max_number_sum},0) ;;
    value_format_name: percent_2
    drill_fields: [drill*]
  }

  set: drill {
    fields: [
      event_name,
      activity_type,
      days_from_event,
      miles_from_event
    ]
  }

  derived_table: {
    datagroup_trigger: once_yearly
    sql:
    SELECT
      a.id as event_id,
      a.event_name,
      a.event_time,
      a.latitude as event_latitude,
      a.longitude as event_longitude,
      b.*
    FROM ${event_summary.SQL_TABLE_NAME} a
    CROSS JOIN ${combine_calls_photos.SQL_TABLE_NAME} b
  ;;
  }
}

view: combine_calls_photos {
  derived_table: {
    datagroup_trigger: once_yearly
    sql:
    SELECT
      'Call' as activity_type,
      id as activity_id,
      person_id,
      call_time as activity_time,
      latitude as activity_latitude,
      longitude as activity_longitude
    FROM ${calls_summary.SQL_TABLE_NAME}
    UNION ALL
    SELECT
      'Photo' as activity_type,
      id as activity_id,
      person_id,
      photo_time as activity_time,
      latitude as activity_latitude,
      longitude as activity_longitude
    FROM ${photo_summary.SQL_TABLE_NAME}
  ;;
  }
}

view: event_summary {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: event {
      column: id {}
      column: event_name {}
      column: event_time {}
      column: latitude {}
      column: longitude {}
      column: total_people_killed {}
    }
  }
  dimension: id {
    type: number
  }
  dimension: event_name {
    type: number
  }
  dimension: event_time {
    type: date_time
  }
  dimension: latitude {
    type: number
  }
  dimension: longitude {
    type: number
  }
  dimension: total_people_killed {
    type: number
  }
}

view: calls_summary {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: person {
      column: id { field: call.id }
      column: person_id { field: call.person_id }
      column: call_time { field: call.call_time }
      column: latitude { field: call.latitude }
      column: longitude { field: call.longitude }
    }
  }
  dimension: id {
    value_format: "0"
    type: number
  }
  dimension: person_id {
    value_format: "0"
    type: number
  }
  dimension: call_time {
    type: date_time
  }
  dimension: latitude {
    type: number
  }
  dimension: longitude {
    type: number
  }
}

view: photo_summary {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: person {
      column: id { field: photo.id }
      column: person_id { field: photo.person_id }
      column: photo_time { field: photo.photo_time }
      column: latitude { field: photo.latitude }
      column: longitude { field: photo.longitude }
    }
  }
  dimension: id {
    value_format: "0"
    type: number
  }
  dimension: person_id {
    value_format: "0"
    type: number
  }
  dimension: photo_time {
    type: date_time
  }
  dimension: latitude {
    type: number
  }
  dimension: longitude {
    type: number
  }
}

view: max_suspicious_activities {
  derived_table: {
    explore_source: event_activity_connection {
      column: person_id {}
      column: number_suspicious_activities {}
    }
  }
  dimension: person_id {
    primary_key: yes
    # hidden: yes
    label: "Event Person ID"
    type: number
  }
  dimension: number_suspicious_activities {
    # hidden: yes
    label: "Event Number Suspicious Activities"
    type: number
  }
  measure: count_suspcious_activities {
    type: sum
    sql: ${number_suspicious_activities} ;;
  }
}

view: max_suspicious_activities_max {
  derived_table: {
    explore_source: max_suspicious_activities {
      column: number_suspicious_activities {}
    }
  }
  dimension: number_suspicious_activities {
    # hidden: yes
    label: "Event Number Suspicious Activities"
    type: number
  }
  measure: max_number {
    type: max
    sql: ${number_suspicious_activities} ;;
  }
  measure: count {
    type: count
  }
}

view: max_suspicious_activities_max_max {
  derived_table: {
    explore_source: max_suspicious_activities_max {
      column: max_number {}
      column: count {}
    }
  }
  dimension: max_number {
    # hidden: yes
    type: number
  }
  measure: max_number_sum {
    # hidden: yes
    type: max
    sql: ${max_number} ;;
  }
}
