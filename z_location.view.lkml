#
# view: location {
#   derived_table: {
#     datagroup_trigger: once_yearly
#     explore_source: person {
#       column: pk { field: event_person_cross.pk }
#       column: call_id { field: call.id }
#       column: person_latitude { field: person.latitude }
#       column: person_longitude { field: person.longitude }
#       column: event_latitude { field: event_person_cross.latitude }
#       column: event_longitude { field: event_person_cross.longitude }
#       column: call_latitude { field: call.latitude }
#       column: call_longitude { field: call.longitude }
#       column: call_receiver_latitude { field: call.latitude_calling }
#       column: call_receiver_longitude { field: call.longitude_calling }
#     }
#   }
#   dimension: pk {
#     # primary_key: yes
#     # hidden: yes
#     type: number
#   }
#   dimension: call_id {
#     # primary_key: yes
#     # hidden: yes
#     type: number
#   }
#   dimension: pk2 {
#     primary_key: yes
#     # hidden: yes
#     type: string
#     sql: concat(cast(${pk} as string),'-',cast(${call_id} as string));;
#   }
#     # '-',cast(${location_call_receiver} as string)) ;;
#   dimension: person_latitude {
#     label: "Latitude"
#     view_label: "Person"
#     type: number
#   }
#   dimension: person_longitude {
#     label: "Longitude"
#     view_label: "Person"
#     type: number
#   }
#   dimension: location_person {
#     label: "Location"
#     view_label: "Person"
#     type: location
#     sql_latitude: ${person_latitude} ;;
#     sql_longitude: ${person_longitude} ;;
#   }
#   dimension: event_latitude {
#     label: "Latitude"
#     view_label: "Event"
#     type: number
#   }
#   dimension: event_longitude {
#     label: "Longitude"
#     view_label: "Event"
#     type: number
#   }
#   dimension: location_event {
#     label: "Location"
#     view_label: "Event"
#     type: location
#     sql_latitude: ${event_latitude} ;;
#     sql_longitude: ${event_longitude} ;;
#   }
#   dimension: distance_person_event {
#     type: distance
#     start_location_field: location_person
#     end_location_field: location_event
#     units: miles
#   }
#   measure: average_distance_person_event {
#     type: average
#     sql: ${distance_person_event} ;;
#     value_format_name: decimal_1
#   }
#   dimension: call_latitude {
#     label: "Latitude Call"
#     view_label: "Call"
#     type: number
#   }
#   dimension: call_longitude {
#     label: "Longitude Call"
#     view_label: "Call"
#     type: number
#   }
#   dimension: location_call {
#     label: "Location Call"
#     view_label: "Call"
#     type: location
#     sql_latitude: ${call_latitude} ;;
#     sql_longitude: ${call_longitude} ;;
#   }
#   dimension: distance_event_call {
#     type: distance
#     start_location_field: location_call
#     end_location_field: location_event
#     units: miles
#   }
#   measure: average_distance_event_call {
#     type: average
#     sql: ${distance_event_call} ;;
#     value_format_name: decimal_1
#   }
#   dimension: call_receiver_latitude {
#     label: "Latitude Call Receiver"
#     view_label: "Call"
#     type: number
#   }
#   dimension: call_receiver_longitude {
#     label: "Longitude Call Receiver"
#     view_label: "Call"
#     type: number
#   }
#   dimension: location_call_receiver {
#     label: "Location Call Receiver"
#     view_label: "Call"
#     type: location
#     sql_latitude: ${call_receiver_latitude} ;;
#     sql_longitude: ${call_receiver_longitude} ;;
#   }
#   dimension: distance_call {
#     view_label: "Call"
#     type: distance
#     start_location_field: location_call
#     end_location_field: location_call_receiver
#     units: miles
#   }
#   measure: average_distance_call {
#     view_label: "Call"
#     type: average
#     sql: ${distance_call} ;;
#     value_format_name: decimal_1
#   }
# }
