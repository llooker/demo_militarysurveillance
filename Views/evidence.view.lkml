view: evidence {
sql_table_name: looker-private-demo.military_surveillance.evidence ;;

  dimension: pk {
    hidden: yes
    primary_key: yes
    type: string
    sql: concat(cast(${id} as string),'-',cast(${person_id} as string)) ;;
  }
  dimension: person_id {
    type: number
    link: {
      label: "Person Lookup"
      url: "https://demoexpo.looker.com/dashboards/52?Person%20ID={{ value }}"
      icon_url: "https://looker.com/favicon.ico"
    }
  }
  dimension: id {
    type: number
  }
  dimension: evidence_type {
  }
  dimension: file_type {
  }
  dimension: file_name {
    link: {
      label: "Extract Evidence"
      url: "{{ value }}"
      icon_url: "https://www.google.com/s2/favicons?domain_url=http://www.fbi.gov"
    }
  }
  dimension: file_name_photo {
    sql: ${file_name} ;;
    html: <img src="{{ value }}" height="120" width="170" /> ;;
  }

  # derived_table: {
  #   datagroup_trigger: once_yearly
  #   sql:
  #     SELECT *
  #     FROM ${evidence_cross.SQL_TABLE_NAME} a
  #     WHERE id in (19,20,21)
  #     OR (person_id < 50 AND id in (1,3,4,7,11,12))
  #     OR (person_id BETWEEN 50 and 100 AND id in (2,4,6,7,13,15))
  #     OR (person_id BETWEEN 100 and 150 AND id in (5,8,9,14,16))
  #     OR (person_id > 150 AND id in (1,2,17,18))
  # ;;
  # }
}

# view: evidence_cross {

#   derived_table: {
#     datagroup_trigger: once_yearly
#     sql:
#       SELECT a.id as person_id, b.*
#       FROM ${person.SQL_TABLE_NAME} a
#       CROSS JOIN ${evidence_pre.SQL_TABLE_NAME} b
#   ;;
#   }
# }

# view: evidence_pre {

#   derived_table: {
#     datagroup_trigger: once_yearly
#     sql:
# SELECT 1 as id, 'Photo' as evidence_type, 'jpg' as file_type, 'https://www.airport-technology.com/wp-content/uploads/sites/14/2017/10/1-image-31.jpg' as file_name UNION ALL
# SELECT 2 as id, 'Photo' as evidence_type, 'jpg' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQALktjcNflIk_bmhDDiX_ajDAY6osqgkM1hE0rzJGBxyn-nj_Qg' as file_name UNION ALL
# SELECT 3 as id, 'Photo' as evidence_type, 'png' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBIdhuzaCaKq9UYIch5kSBNmexKKlVnuMcKhb5SM_94_jypXzliA' as file_name UNION ALL
# SELECT 4 as id, 'Photo' as evidence_type, 'jpg' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRK7kQuMiYOEAmzwCnBwDj8w3UsZJZoA5l1Ps1-EuJT1XqFaOr2' as file_name UNION ALL
# SELECT 5 as id, 'Photo' as evidence_type, 'jpg' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmwg3MUXxpnG_ZxRZyBXsKO3Q_bE2GVIwoB3_oL4CdU74VOCQR' as file_name UNION ALL
# SELECT 6 as id, 'Photo' as evidence_type, 'jpg' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3VItNoJ7bnfCBJbNuHrHX-5apIBoEkEq5XH5dzFssPhWOOS-sng' as file_name UNION ALL
# SELECT 7 as id, 'Photo' as evidence_type, 'jpg' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRb1YI541UTYLE5LSfqmO2VydG3NezVdczk9H3KkXI717rYDH6R' as file_name UNION ALL
# SELECT 8 as id, 'Photo' as evidence_type, 'jpg' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqUkfR4JBnl9QDgBCpx6JakjK03wc4zUe-jflMV4CLzFNeW8JGIA' as file_name UNION ALL
# SELECT 9 as id, 'Photo' as evidence_type, 'jpg' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaVMgs-e-NkMiUG0ZlWzazM0Qa6Lp8eP7LB3g0gUPPeJzGQh7U' as file_name UNION ALL
# SELECT 10 as id, 'Photo' as evidence_type, 'jpg' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPdyEtE6mxLMiVq6Ewt1QVpfcRVa7ZxFvkiFivzMo9zVdrI2aI' as file_name UNION ALL
# SELECT 11 as id, 'Photo' as evidence_type, 'jpg' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTN17FicQwcnHDr4veem1uMSUQmZ4hFjBleppUiNyDzNpyuQQHM' as file_name UNION ALL
# SELECT 12 as id, 'Photo' as evidence_type, 'jpg' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMBibMSMsnDQNe1rgtDnHfvUyYVnNhoptQApYrJhFirAgnwTeE5A' as file_name UNION ALL
# SELECT 13 as id, 'Photo' as evidence_type, 'jpg' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHROWJSkrywMgIVzB2Hit9bmJgv9bQdZfptckK5xcjcxxDRqL80Q' as file_name UNION ALL
# SELECT 14 as id, 'Photo' as evidence_type, 'jpg' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-6vZ_ygtdvb1tZrrTZdYzqJaKadF8YNZvHIjlEji2KphePLnQUw' as file_name UNION ALL
# SELECT 15 as id, 'Photo' as evidence_type, 'jpg' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMhE93hd-tMIiIU99dwA3kzjicetfCBDEBVsKmWGTmchRdhbMP' as file_name UNION ALL
# SELECT 16 as id, 'Photo' as evidence_type, 'jpg' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThmEIqI3xtwvj0MUovRLJMoSOwQ0WlWLXZdrBfCFVmyhK32kHgkA' as file_name UNION ALL
# SELECT 17 as id, 'Photo' as evidence_type, 'jpg' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvL0IXwjsB-hDy345CnZ2sNmbTKW1rt_kT9pFBQrohYmR_IAsC' as file_name UNION ALL
# SELECT 18 as id, 'Photo' as evidence_type, 'jpg' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRs4rl537KnR8mFt_34JV8fwTTfQq92fA0zxkptwSNWt8AM7GSEQ' as file_name UNION ALL
# SELECT 19 as id, 'Document' as evidence_type, 'xlsx' as file_type, 'https://docs.google.com/spreadsheets/d/1_aS47lIerpGNLYeowNFE6y1A1hGhrYlqrSBgVBybDVM/edit?usp=sharing' as file_name UNION ALL
# SELECT 20 as id, 'Weapon' as evidence_type, 'jpg' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmg8YPXklNj8jvjQiDSQZcfCHWrkrgVm2x1a7t-lO9eICZhWtVjQ' as file_name UNION ALL
# SELECT 21 as id, 'Weapon' as evidence_type, 'jpg' as file_type, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS6ZQups0qJyVK3r4D606K1sqO6ae8SC9CVqezQNaUoaGFCXTsm' as file_name
# ;;
#   }

# }
