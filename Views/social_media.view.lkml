view: social_media {
  sql_table_name: looker-private-demo.military_surveillance.social_media ;;

  dimension: id {
    primary_key: yes
    type: number
  }
  dimension: post {
  }
  dimension: score {
    type: number
  }
  measure: total_score {
    type: sum
    sql: ${score} ;;
    drill_fields: [id, post, total_score]
  }

#   derived_table: {
#     datagroup_trigger: once_yearly
#     sql:
# SELECT 1 as id, 'Welcome, brothers! ' as post, 0 as score UNION ALL
# SELECT 2 as id, 'Death to America! ' as post, -1 as score UNION ALL
# SELECT 3 as id, 'The weather is nice today. ' as post, 0 as score UNION ALL
# SELECT 4 as id, 'My flight was delayed 2 hours.' as post, 0 as score UNION ALL
# SELECT 5 as id, 'The border patrol are out on the mountain - stay safe' as post, -1 as score UNION ALL
# SELECT 6 as id, 'I hope the war ends soon' as post, 1 as score UNION ALL
# SELECT 7 as id, 'Did you hit the target ok last night?' as post, -1 as score
#         ;;
#   }

}
