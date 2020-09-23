view: person_to_person_activity {

  dimension: pk {
    type: string
    primary_key: yes
    hidden: yes
    sql: concat(cast(${person_id} as string),'-',cast(${connected_person} as string)) ;;
  }

  dimension: person_id {
    value_format: "0"
    type: number
    link: {
      label: "Person Lookup"
      url: "https://demoexpo.looker.com/dashboards/52?Person%20ID={{ value }}"
      icon_url: "https://looker.com/favicon.ico"
    }
  }
  dimension: connected_person {
    value_format: "0"
    type: number
    link: {
      label: "Person Lookup"
      url: "https://demoexpo.looker.com/dashboards/52?Person%20ID={{ value }}"
      icon_url: "https://looker.com/favicon.ico"
    }
  }
  dimension: connected_person_photo {
    type: number
    sql: ${connected_person} ;;
    html:
    {% if value < 95 %}
    <img src="https://live.staticflickr.com/65535/48421990231_075f95f27d_m.jpg" width="100" />
    {% elsif value > 94 and value < 104 %}
    <img src="https://live.staticflickr.com/65535/48422141932_60e02d5233_m.jpg" width="100"/>
    {% elsif value > 103 and value < 117 %}
    <img src="https://live.staticflickr.com/65535/48422141952_375bf859e1_m.jpg" width="100"/>
    {% elsif value > 116 and value < 156 %}
    <img src="https://live.staticflickr.com/65535/48422141977_33bcd7c924_m.jpg" width="100"/>
    {% else %}
    <img src="https://live.staticflickr.com/65535/48422141982_273d0f7d61_m.jpg" width="100" />
    {% endif %}
    ;;
  }
  dimension: person_latitude {
    hidden: yes
    label: "Latitude"
    # view_label: "Person"
    type: number
  }
  dimension: person_longitude {
    hidden: yes
    label: "Longitude"
    # view_label: "Person"
    type: number
  }
  dimension: location_person {
    label: "Location"
    # view_label: "Person"
    type: location
    sql_latitude: ${person_latitude} ;;
    sql_longitude: ${person_longitude} ;;
  }
  dimension: person_latitude_out {
    hidden: yes
    label: "Latitude (Conenction)"
    # view_label: "Person"
    type: number
  }
  dimension: person_longitude_out {
    hidden: yes
    label: "Longitude (Connection)"
    # view_label: "Person"
    type: number
  }
  dimension: location_person_out {
    label: "Location (Connection)"
    # view_label: "Person"
    type: location
    sql_latitude: ${person_latitude_out} ;;
    sql_longitude: ${person_longitude_out} ;;
  }
  dimension: distance_between_people {
    type: distance
    start_location_field: location_person
    end_location_field: location_person_out
    units: miles
  }
  measure: average_distance_between_people {
    type: average
    sql: ${distance_between_people} ;;
    value_format_name: decimal_1
    drill_fields: [drill*]
  }
  dimension: risk_score {
    hidden: yes
    type: number
  }
  dimension: risk_score_out {
    hidden: yes
    label: "Risk Score (Connection)"
    type: number
  }
  dimension: is_risky_suspect_out {
    label: "Is Risky Suspect"
    # hidden: yes
    type: yesno
    sql: ${risk_score_out} > {% parameter person.threshold_for_risk %} ;;
  }
  measure: avg_risk_score {
    label: "Average Risk Score"
    type: average
    sql: ${risk_score} ;;
    drill_fields: [drill*]
  }
  measure: avg_risk_score_out {
    label: "Average Risk Score (Connection)"
    type: average
    sql: ${risk_score_out} ;;
    drill_fields: [drill*]
  }

  dimension: average_call_length {
    type: number
  }
  dimension: count_calls {
    hidden: yes
    type: number
  }
  dimension: talk_time {
    hidden: yes
    sql: ${average_call_length} * ${count_calls} ;;
  }
  measure: total_talk_time {
    label: "Total Talk Time"
    description: "In Minutes"
    type: sum
    sql: ${talk_time} ;;
    value_format_name: decimal_1
    drill_fields: [drill*]
  }
  measure: total_talk_time_at_risk {
    type: sum
    sql: ${talk_time} ;;
    filters: {
      field: is_risky_suspect_out
      value: "Yes"
    }
    value_format_name: decimal_1
    drill_fields: [drill*]
  }
  measure: percentage_talk_time_at_risk {
    type: number
    sql: 1.0*${total_talk_time_at_risk} / nullif(${total_talk_time},0) ;;
    value_format_name: percent_2
    drill_fields: [drill*]
  }
  measure: total_calls {
    label: "Count Calls"
    type: sum
    sql: ${count_calls} ;;
    value_format_name: decimal_0
    drill_fields: [call.id, drill*]
  }
  measure: total_calls_at_risk {
    type: sum
    sql: ${count_calls} ;;
    filters: {
      field: is_risky_suspect_out
      value: "Yes"
    }
    value_format_name: decimal_1
    drill_fields: [call.id, drill*]
  }
  measure: percentage_calls_at_risk {
    type: number
    sql: 1.0*${total_calls_at_risk} / nullif(${total_calls},0) ;;
    value_format_name: percent_2
    drill_fields: [call.id, drill*]
  }
  measure: avg_call_length {
    label: "Avg Call Length"
    description: "In Minutes"
    type: number
    sql: 1.0*${total_talk_time} / nullif(${total_calls},0) ;;
    value_format_name: decimal_1
    drill_fields: [call.id, drill*]
  }
  dimension: count_photos {
    hidden: yes
    type: number
  }
  measure: total_photos {
    label: "Count Photos"
    type: sum
    sql: ${count_photos} ;;
    value_format_name: decimal_0
    drill_fields: [photo.id, drill*]
  }
  measure: total_photos_at_risk {
    label: "Count Photos at Risk"
    type: sum
    sql: ${count_photos} ;;
    filters: {
      field: is_risky_suspect_out
      value: "Yes"
    }
    value_format_name: decimal_1
    drill_fields: [photo.id, drill*]
  }
  measure: percentage_photos_at_risk {
    type: number
    sql: 1.0*${total_photos_at_risk} / nullif(${total_photos},0) ;;
    value_format_name: percent_2
    drill_fields: [photo.id, drill*]
  }
  measure: connection_score {
    type: number
    description: "Each hour talked is 1 credit; each photo together is 1 credit"
    sql: (${total_talk_time} / 60.0) + (${total_photos} * 1) ;;
    # (1/(case when ${average_distance_between_people} < 100 then 100 else ${average_distance_between_people} end) * 300)
    value_format_name: decimal_2
    drill_fields: [drill*]
  }
  measure: connection_score_at_risk {
    type: number
    description: "Each hour talked is 1 credit; each photo together is 1 credit"
    sql: (${total_talk_time_at_risk} / 60.0) + (${total_photos_at_risk} * 1) ;;
    value_format_name: decimal_2
    drill_fields: [drill*]
  }
  measure: connection_score_risk {
    view_label: "Risk"
    type: number
    description: "% of connection associated with risky suspects"
    sql: 1.0*${connection_score_at_risk} / nullif(${connection_score},0) ;;
    value_format_name: percent_2
    drill_fields: [drill*]
  }

  set: drill {
    fields: [
      person_id,
      connected_person,
      total_calls,
      total_photos,
      connection_score_risk
    ]
  }

  derived_table: {
    datagroup_trigger: once_yearly
    sql:
      SELECT
        coalesce(a.person_id,b.person_id) as person_id,
        coalesce(a.person_id_calling,b.person_id_out) as connected_person,
        --coalesce(a.call_time,b.photo_time) as activity_time,
        coalesce(a.person_latitude,b.person_latitude) as person_latitude,
        coalesce(a.person_longitude,b.person_longitude) as person_longitude,
        coalesce(a.latitude_out,b.latitude_out) as person_latitude_out,
        coalesce(a.longitude_out,b.longitude_out) as person_longitude_out,
        coalesce(a.risk_score,b.risk_score) as risk_score,
        coalesce(a.risk_score_out,b.risk_score_out) as risk_score_out,
        a.count_calls,
        a.average_call_length,
        b.count_photos
      FROM
      (
        SELECT a.*, b.latitude as latitude_out, b.longitude as longitude_out, b.risk_score as risk_score_out
        FROM ${person_to_person_calls.SQL_TABLE_NAME} a
        JOIN ${person.SQL_TABLE_NAME} b
          ON a.person_id_calling = b.id
        WHERE a.person_id <> a.person_id_calling
      ) a
      FULL OUTER JOIN
      (
        SELECT a.* , b.latitude as latitude_out, b.longitude as longitude_out, b.risk_score as risk_score_out
        FROM ${person_to_person_photos.SQL_TABLE_NAME} a
        JOIN ${person.SQL_TABLE_NAME} b
          ON a.person_id_out = b.id
        WHERE a.person_id <> a.person_id_out
      ) b
        ON a.person_id = b.person_id
        AND a.person_id_calling = b.person_id_out
    ;;
  }

}

view: person_to_person_calls {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: person {
      column: person_id { field: call.person_id }
      column: person_id_calling { field: call.person_id_calling }
      column: person_latitude { field: person.latitude }
      column: person_longitude { field: person.longitude }
      column: risk_score { field: person.risk_score }
      # column: call_time { field: call.call_time }
      column: average_call_length { field: call.average_call_length }
      column: count_calls { field: call.count_calls }
    }
  }
  dimension: person_id {
    value_format: "0"
    type: number
  }
  dimension: person_id_calling {
    value_format: "0"
    type: number
  }
#   dimension: call_time {
#     type: date_time
#   }
  dimension: average_call_length {
    type: number
  }
  dimension: count_calls {
    type: number
  }
}

view: person_to_person_photos {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: person {
      column: person_id { field: photo.person_id }
      column: person_id_out { field: photo_members.person_id_out }
      column: person_latitude { field: person.latitude }
      column: person_longitude { field: person.longitude }
      column: risk_score { field: person.risk_score }
      # column: photo_time { field: photo.photo_time }
      column: count_photos { field: photo_members.count_photos }
    }
  }
  dimension: person_id {
    value_format: "0"
    type: number
  }
  dimension: person_id_out {
    label: "Photo Person also in Photo"
    value_format: "0"
    type: number
  }
#   dimension: photo_time {
#     type: date_time
#   }
  dimension: count_photos {
    type: number
  }
}
