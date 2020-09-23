view: event {

  dimension: id {
    # hidden: yes
    type: number
    primary_key: yes
    sql: ${TABLE}.id ;;
  }

#   dimension: event_id {
#     type: number
#     sql: ${TABLE}.id ;;
#   }

  dimension: event_name {
    type: string
    sql: concat(${TABLE}.name, '-', cast(${event_date} as string), ' (', cast(${event.people_killed} as string), ' Killed)') ;;
  }

  dimension_group: event {
    type: time
    datatype: timestamp
    timeframes: [
      raw,
      time,
      hour_of_day,
      date,
      week,
      month,
      year
    ]
    sql: cast(${TABLE}.date as timestamp) ;;
  }

  dimension: latitude {
    # hidden: yes
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    # hidden: yes
    type: number
    sql: ${TABLE}.longitude ;;
  }

  measure: count_events {
    type: count
    # sql: ${event_id} ;;
  }

  dimension: people_killed {
    hidden: yes
    type: number
    sql: ${TABLE}.people_killed ;;
  }

  measure: total_people_killed {
    type: sum
    sql: ${people_killed} ;;
    value_format_name: decimal_0
  }


  # Note: this data was generated in Mockaroo under Aaron Lutkowitz's account, schema #: https://www.mockaroo.com/schemas/141185

  derived_table: {
    datagroup_trigger: once_yearly
    sql:
SELECT 1 as id, '2018-04-30 05:15:17' as date, 'Roadside Bomb' as name, 34.7921967 as latitude, 69.2844746 as longitude, 10 as people_killed UNION ALL
SELECT 2 as id, '2018-05-12 04:25:11' as date, 'Kabul Roadside IED' as name, 34.5788821 as latitude, 69.457949 as longitude, 6 as people_killed UNION ALL
SELECT 3 as id, '2017-06-30 23:21:27' as date, 'Hospital Explosion' as name, 35.8372004 as latitude, 70.4365212 as longitude, 0 as people_killed UNION ALL
SELECT 4 as id, '2017-04-28 18:42:00' as date, 'Roadside Bomb' as name, 34.1597205 as latitude, 70.6006535 as longitude, 16 as people_killed UNION ALL
SELECT 5 as id, '2018-02-16 13:46:36' as date, 'School Bombing' as name, 35.1632238 as latitude, 68.8610623 as longitude, 11 as people_killed UNION ALL
SELECT 6 as id, '2018-06-24 17:18:58' as date, 'Kabul Airport Bombing' as name, 34.566561 as latitude, 69.209877 as longitude, 39 as people_killed UNION ALL
SELECT 7 as id, '2017-11-23 18:33:03' as date, 'School Bombing' as name, 35.7208338 as latitude, 68.5295022 as longitude, 12 as people_killed UNION ALL
SELECT 8 as id, '2018-01-28 13:56:26' as date, 'Roadside Bomb' as name, 35.4675259 as latitude, 69.93349 as longitude, 16 as people_killed UNION ALL
SELECT 9 as id, '2018-02-21 08:16:16' as date, 'Kabul Roadside IED' as name, 33.9454583 as latitude, 67.6382077 as longitude, 0 as people_killed UNION ALL
SELECT 10 as id, '2017-08-19 15:07:11' as date, 'Roadside Bomb' as name, 35.5292656 as latitude, 70.663991 as longitude, 22 as people_killed UNION ALL
SELECT 11 as id, '2017-10-11 08:58:14' as date, 'Kabul Roadside IED' as name, 35.3600105 as latitude, 69.50869 as longitude, 5 as people_killed UNION ALL
SELECT 12 as id, '2017-02-22 22:17:18' as date, 'Bus Bomb' as name, 33.9674092 as latitude, 69.8309157 as longitude, 1 as people_killed UNION ALL
SELECT 13 as id, '2018-06-01 08:00:07' as date, 'Dowlat Shah IED' as name, 34.9095421 as latitude, 70.4865461 as longitude, 19 as people_killed UNION ALL
SELECT 14 as id, '2017-02-21 12:28:28' as date, 'School Bombing' as name, 34.0896772 as latitude, 67.6880061 as longitude, 6 as people_killed UNION ALL
SELECT 15 as id, '2018-08-08 10:57:17' as date, 'Bus Bomb' as name, 34.4640164 as latitude, 69.3373268 as longitude, 1 as people_killed UNION ALL
SELECT 16 as id, '2017-08-01 17:48:04' as date, 'Roadside Bomb' as name, 34.2097937 as latitude, 67.7832563 as longitude, 16 as people_killed UNION ALL
SELECT 17 as id, '2017-03-11 12:08:01' as date, 'Kabul Roadside IED' as name, 34.9214833 as latitude, 69.8163022 as longitude, 18 as people_killed UNION ALL
SELECT 18 as id, '2017-09-13 12:23:42' as date, 'Bus Bomb' as name, 34.5655667 as latitude, 70.4029469 as longitude, 8 as people_killed UNION ALL
SELECT 19 as id, '2018-07-27 14:13:53' as date, 'Roadside Bomb' as name, 35.8459246 as latitude, 69.1181632 as longitude, 2 as people_killed UNION ALL
SELECT 20 as id, '2018-01-30 07:53:05' as date, 'Kabul Roadside IED' as name, 34.9990869 as latitude, 70.3038012 as longitude, 4 as people_killed UNION ALL
SELECT 21 as id, '2017-08-13 01:58:39' as date, 'Roadside IED' as name, 34.7849756 as latitude, 70.0990696 as longitude, 12 as people_killed UNION ALL
SELECT 22 as id, '2018-02-14 21:03:50' as date, 'Roadside Bomb' as name, 34.4291797 as latitude, 68.4176561 as longitude, 13 as people_killed UNION ALL
SELECT 23 as id, '2018-07-08 12:00:35' as date, 'School Bombing' as name, 33.1823219 as latitude, 67.6448834 as longitude, 9 as people_killed UNION ALL
SELECT 24 as id, '2018-02-04 11:19:17' as date, 'School Bombing' as name, 34.5803181 as latitude, 68.2065895 as longitude, 6 as people_killed UNION ALL
SELECT 25 as id, '2017-07-19 00:55:42' as date, 'Roadside Bomb' as name, 35.8184665 as latitude, 68.2742774 as longitude, 24 as people_killed UNION ALL
SELECT 26 as id, '2018-04-07 17:40:29' as date, 'Roadside IED' as name, 35.7652998 as latitude, 68.7888125 as longitude, 11 as people_killed UNION ALL
SELECT 27 as id, '2017-09-08 08:56:58' as date, 'Bus Bomb' as name, 35.1965931 as latitude, 69.351795 as longitude, 3 as people_killed UNION ALL
SELECT 28 as id, '2017-06-20 17:39:53' as date, 'Roadside Bomb' as name, 35.1333262 as latitude, 70.518273 as longitude, 3 as people_killed UNION ALL
SELECT 29 as id, '2018-04-23 06:26:57' as date, 'Kabul Roadside IED' as name, 34.6329903 as latitude, 67.9051038 as longitude, 19 as people_killed UNION ALL
SELECT 30 as id, '2017-03-12 11:43:23' as date, 'Roadside IED' as name, 34.1663442 as latitude, 69.5183314 as longitude, 2 as people_killed UNION ALL
SELECT 31 as id, '2018-09-20 00:36:10' as date, 'School Bombing' as name, 33.3281969 as latitude, 67.4683406 as longitude, 2 as people_killed UNION ALL
SELECT 32 as id, '2017-03-19 19:16:34' as date, 'Roadside Bomb' as name, 33.3798949 as latitude, 67.8372427 as longitude, 12 as people_killed UNION ALL
SELECT 33 as id, '2017-01-28 04:29:39' as date, 'Roadside IED' as name, 34.9007467 as latitude, 68.3760126 as longitude, 31 as people_killed UNION ALL
SELECT 34 as id, '2017-12-05 18:59:31' as date, 'FATA Border Explosion' as name, 34.0233903 as latitude, 70.6902374 as longitude, 19 as people_killed UNION ALL
SELECT 35 as id, '2018-08-31 19:59:36' as date, 'Border Attack' as name, 35.5862905 as latitude, 69.9782736 as longitude, 9 as people_killed UNION ALL
SELECT 36 as id, '2017-02-27 17:47:06' as date, 'Border Attack' as name, 33.1935302 as latitude, 69.6375029 as longitude, 12 as people_killed UNION ALL
SELECT 37 as id, '2018-05-24 06:32:47' as date, 'Roadside Bomb' as name, 35.3136292 as latitude, 70.1575917 as longitude, 1 as people_killed UNION ALL
SELECT 38 as id, '2017-02-28 07:17:09' as date, 'School Bombing' as name, 35.2341286 as latitude, 67.6998001 as longitude, 3 as people_killed UNION ALL
SELECT 39 as id, '2017-01-07 04:22:27' as date, 'Roadside Bomb' as name, 33.3998381 as latitude, 69.5126656 as longitude, 3 as people_killed UNION ALL
SELECT 40 as id, '2017-07-11 00:10:35' as date, 'Border Attack' as name, 33.2004222 as latitude, 69.1524594 as longitude, 6 as people_killed UNION ALL
SELECT 41 as id, '2018-08-22 07:21:20' as date, 'Border Attack' as name, 34.0915913 as latitude, 68.4469833 as longitude, 17 as people_killed UNION ALL
SELECT 42 as id, '2017-06-14 04:16:59' as date, 'Roadside Bomb' as name, 35.024852 as latitude, 70.7004752 as longitude, 16 as people_killed UNION ALL
SELECT 43 as id, '2018-07-11 16:54:15' as date, 'Gunfire' as name, 33.3601588 as latitude, 68.688445 as longitude, 6 as people_killed UNION ALL
SELECT 44 as id, '2018-03-03 05:29:15' as date, 'Pakistan Border Gunfire' as name, 33.4312989 as latitude, 70.381889 as longitude, 25 as people_killed UNION ALL
SELECT 45 as id, '2017-10-23 21:06:12' as date, 'Gunfire' as name, 34.2756218 as latitude, 69.8566915 as longitude, 0 as people_killed UNION ALL
SELECT 46 as id, '2017-08-16 09:59:24' as date, 'Border Attack' as name, 33.8838242 as latitude, 70.7128491 as longitude, 10 as people_killed UNION ALL
SELECT 47 as id, '2018-07-14 16:55:21' as date, 'Roadside Bomb' as name, 35.0915053 as latitude, 70.6681101 as longitude, 13 as people_killed UNION ALL
SELECT 48 as id, '2017-06-11 01:21:33' as date, 'Gunfire' as name, 34.7473197 as latitude, 68.8039971 as longitude, 7 as people_killed UNION ALL
SELECT 49 as id, '2017-10-11 15:45:18' as date, 'Roadside Bomb' as name, 33.9519317 as latitude, 69.1586339 as longitude, 5 as people_killed UNION ALL
SELECT 50 as id, '2017-06-05 04:17:10' as date, 'Gunfire' as name, 34.6764018 as latitude, 68.4024984 as longitude, 20 as people_killed
    ;;
  }

}

# view: event_person_cross {
#
#   view_label: "Event"
#
#   derived_table: {
#     datagroup_trigger: once_yearly
#     sql:
#       SELECT
#         a.id as person_id,
#         -- a.call_id,
#         b.*
#       FROM ${person.SQL_TABLE_NAME} a
# --      (
# --        SELECT
# --            a.id as person_id,
# --            b.id as call_id
# --        FROM ${person.SQL_TABLE_NAME} a
# --        LEFT JOIN ${call.SQL_TABLE_NAME} b
# --          ON a.id = b.person_id
# --      ) a
#       CROSS JOIN ${event.SQL_TABLE_NAME} b
#       ;;
#   }

#   dimension: pk {
#     primary_key: yes
#     # hidden: yes
#     type: string
#     sql: concat(cast(${person_id} as string),'-',
#         cast(${event_id} as string))  ;;
#   }

#   dimension: person_id {
#     hidden: yes
#     type: number
#     sql: ${TABLE}.person_id ;;
#   }

# }
