connection: "lookerdata"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

datagroup: once_daily {
  max_cache_age: "24 hours"
  sql_trigger: SELECT current_date() ;;
}

datagroup: once_weekly {
  max_cache_age: "168 hours"
  sql_trigger: SELECT extract(week from current_date()) ;;
}

datagroup: once_monthly {
  max_cache_age: "720 hours"
  sql_trigger: SELECT extract(month from current_date()) ;;
}

datagroup: once_yearly {
  max_cache_age: "9000 hours"
  sql_trigger: SELECT extract(year from current_date()) ;;
}

explore: event_activity_connection {
  label: "Event"
  view_label: "Event"

  join: person {
    relationship: many_to_one
    sql_on: ${event_activity_connection.person_id} = ${person.id};;
  }

  join: max_suspicious_activities_max_max {
    fields: []
    relationship: one_to_one
    sql_on: 1 = 1 ;;
  }
}

explore: person {

  join: status {
    relationship: one_to_many
    sql_on: ${person.id} = ${status.person_id} ;;
  }

  join: call {
    relationship: one_to_many
    sql_on: ${person.id} = ${call.person_id} ;;
  }

  join: photo {
    relationship: one_to_many
    sql_on: ${person.id} = ${photo.person_id}  ;;
  }

  join: photo_members {
    relationship: one_to_many
    sql_on: ${photo.person_id} = ${photo_members.person_id}  ;;
  }

  join: person_to_person_activity {
    relationship: one_to_many
    sql_on: ${person.id} = ${person_to_person_activity.person_id} ;;
  }

  join: average_suspicious_score {
    relationship: one_to_many
    sql_on: ${person.id} = ${average_suspicious_score.person_id} ;;
  }

  join: evidence {
    relationship: one_to_one
    sql_on: ${person.id} = ${evidence.person_id}  ;;
  }

  join: social_media {
    relationship: one_to_one
    sql_on: 1 = 1 ;;
  }

  join: risk {
    relationship: one_to_one
    sql_on: ${person.id} = ${risk.id}  ;;
  }

}

#   join: event_person_cross {
#     relationship: one_to_many
#     sql_on: ${person.id} = ${event_person_cross.person_id} ;;
#   }
#
#   join: event {
#     relationship: many_to_one
#     sql_on: ${event_person_cross.event_id} = ${event.id} ;;
#   }

# join: location {
#   relationship: one_to_many
#   type: inner
#   sql_on:
#           ${event_person_cross.pk} = ${location.pk}
#       ;;
#       # OR  ${call.id} = ${location.call_id}
#   }


## Necessary for PDTs

explore: person_pre {hidden: yes }
explore: event {
  hidden: yes
  label: "Event Raw"
  view_label: "Event Raw"
}
explore: max_suspicious_activities { hidden: yes }
explore: max_suspicious_activities_max { hidden: yes }
