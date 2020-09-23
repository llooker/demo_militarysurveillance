
# view: person {
#
#   extends: [person2]
#
#   derived_table:{
#     sql:
#       SELECT
#           cast(id as int64) as id
#         , cast(person_id as int64) as person_id
#         , cast(latitude as float64) as latitude
#         , cast(longitude as float64) as longitude
#         , cast(static_risk_score as float64)  as risk_score
#         , 'KHAN TAHERI' as full_name
#         , cast(height as float64) as height
#         , cast(weight as float64) as weight
#       FROM dataset_military.military_person
#       ;;
#   }
# }

view: person {
  derived_table: {
    datagroup_trigger: once_yearly
    sql:
      SELECT
          id
        , person_id
        , latitude
        , longitude
        , risk_score
        , full_name
        , height
        , weight
      FROM ${person_pre2.SQL_TABLE_NAME}
      -- UNION ALL
      --    SELECT
      --      cast(id as int64) as id
      --    , cast(person_id as int64) as person_id
      --    , cast(latitude as float64) as latitude
      --    , cast(longitude as float64) as longitude
      --    , cast(static_risk_score as float64)  as risk_score
      --    , 'KHAN TAHERI' as full_name
      --    , cast(case when height = '' then NULL else height end as float64) as height
      --    , cast(case when weight = '' then NULL else weight end as float64) as weight
      --  FROM ${person_pre3.SQL_TABLE_NAME}
    ;;
  }


  dimension: id {
    primary_key: yes
    value_format: "0"
    type: number
    link: {
      label: "Person Lookup"
      url: "https://demoexpo.looker.com/dashboards/52?Person%20ID={{ value }}"
      icon_url: "https://looker.com/favicon.ico"
    }
  }
  dimension: person_id {
    hidden: yes
    value_format: "0"
    type: number
  }
  dimension: full_name {
    link: {
      label: "FBI Lookup"
      url: "https://www.no-fly-list.com/details/{{ value }}"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.fbi.gov"
    }
    link: {
      label: "Google Search"
      url: "http://www.google.com/search?q={{ value }}"
      icon_url: "http://google.com/favicon.ico"
    }
    link: {
      label: "Google News Search"
      url: "https://news.google.com/search?q={{ value }}"
      icon_url: "http://google.com/favicon.ico"
    }
    link: {
      label: "Facebook Search"
      url: "https://www.facebook.com/search/people/?q={{ value }}"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.facebook.com"
    }
    action: {
      label: "Launch New Investigation"
      url: "https://desolate-refuge-53336.herokuapp.com/posts"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.fbi.gov"
      param: {
        name: "some_auth_code"
        value: "abc123456"
      }
      form_param: {
        name: "Subject"
        required: yes
        default: "Need for new investigation on {{value}}"
      }
      form_param: {
        name: "To Mailing List"
        required: yes
      }
      form_param: {
        name: "Body"
        type: textarea
        required: yes
        default:
        "Investigator -

        Given the risk score seen in {{ value }}, we strongly recommend beginning a new investigation.

        Best,
        "
      }
    }
    action: {
      label: "ASAP - Detain Suspect"
      url: "https://desolate-refuge-53336.herokuapp.com/posts"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.fbi.gov"
      param: {
        name: "some_auth_code"
        value: "abc123456"
      }
      form_param: {
        name: "Subject"
        required: yes
        default: "Detain {{value}}"
      }
      form_param: {
        name: "To Mailing List"
        required: yes
      }
      form_param: {
        name: "Body"
        type: textarea
        required: yes
        default:
        "Investigator -

        Detain {{ value }} immediately.

        "
      }
    }
    action: {
      label: "Change Risk Score"
      url: "https://desolate-refuge-53336.herokuapp.com/posts"
      icon_url: "http://www.google.com/s2/favicons?domain_url=http://www.fbi.gov"
      param: {
        name: "some_auth_code"
        value: "abc123456"
      }
      form_param: {
        name: "Subject"
        required: yes
        default: "Change Risk Score for {{value}}"
      }
#       form_param: {
#         name: "To Mailing List"
#         required: yes
#       }
      form_param: {
        name: "New Risk Score"
        type: string
        required: yes
        default: "60"
      }
      form_param: {
        name: "Explanation"
        type: string
        required: no
        default: "New information came in about the suspect - needs to be changed"
      }
    }
  }

  dimension: full_id {
    type: string
    sql: concat(cast(${id} as string),' - ',${full_name}) ;;
  }
  dimension: latitude {
    hidden: yes
    type: number
  }
  dimension: longitude {
    hidden: yes
    type: number
  }
  dimension: photo_suspect {
    type: number
    sql: ${id} ;;
    html:
    {% if value < 95 %}
    <img src="https://live.staticflickr.com/65535/48421990231_075f95f27d_m.jpg" width="150" />
    {% elsif value > 94 and value < 104 %}
    <img src="https://live.staticflickr.com/65535/48422141932_60e02d5233_m.jpg" width="150"/>
    {% elsif value > 103 and value < 117 %}
    <img src="https://live.staticflickr.com/65535/48422141952_375bf859e1_m.jpg" width="150"/>
    {% elsif value > 116 and value < 156 %}
    <img src="https://live.staticflickr.com/65535/48422141977_33bcd7c924_m.jpg" width="150"/>
    {% else %}
    <img src="https://live.staticflickr.com/65535/48422141982_273d0f7d61_m.jpg" width="150" />
    {% endif %}
    ;;
  }

  parameter: threshold_for_risk {
    type: unquoted
    default_value: "60"
  }

  dimension: is_risky_suspect {
    hidden: yes
    type: yesno
    sql: ${risk_score} > {% parameter threshold_for_risk %} ;;
  }

  dimension: risk_score {
    hidden: yes
    type: number
  }
  dimension: height {
    type: number
  }
  dimension: weight {
    type: number
  }
  measure: average_risk_score {
    view_label: "Risk"
    label: "Biometrics Risk Score"
    description: "Score provided by a 3rd party facility"
    type: average
    sql: ${risk_score} / 100.0 ;;
    value_format_name: percent_2
    drill_fields: [drill*]
  }
  measure: count_people {
    type: count
    drill_fields: [drill*]
  }

  set: drill {
    fields: [
      id,
      full_name,
      height,
      weight,
      average_risk_score
    ]
  }
}

view: person_pre3 {
  sql_table_name: dataset_military.new_enrollment  ;;
}

view: person_pre2 {
  derived_table: {
    datagroup_trigger: once_yearly
    explore_source: person_pre {
      column: id {}
      column: person_id {}
      column: full_name {}
      column: latitude {}
      column: longitude {}
      column: risk_score {}
      column: height {}
      column: weight {}
    }
  }
}


view: person_pre {

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    value_format_name: id
  }

  dimension: person_id {
    type: number
    sql: ${TABLE}.person_id ;;
    value_format_name: id
  }

  dimension: first_name {
    type: string
    sql:
      CASE
        WHEN substr(cast(person_id as string),5,1) in ('1') then 'MOHAMMAD'
        WHEN substr(cast(person_id as string),5,1) in ('2') then 'ABDUL'
        WHEN substr(cast(person_id as string),5,1) in ('3') then 'AHMAD'
        WHEN substr(cast(person_id as string),5,1) in ('4') then 'FAHIM'
        WHEN substr(cast(person_id as string),5,1) in ('5') then 'RAMIN'
        WHEN substr(cast(person_id as string),5,1) in ('6') then 'YAQUB'
        WHEN substr(cast(person_id as string),5,1) in ('7') then 'KHAN'
        WHEN substr(cast(person_id as string),5,1) in ('8') then 'KHALED'
        WHEN substr(cast(person_id as string),5,1) in ('9') then 'KHALIL'
        WHEN substr(cast(person_id as string),5,1) in ('0') then 'MUHAMMAD'
        ELSE 'MOHAMMAD'
      END
        ;;
  }

  dimension: last_name {
    type: string
    sql:
      CASE
        WHEN substr(cast(person_id as string),0,1) in ('1') then 'HABIBI'
        WHEN substr(cast(person_id as string),0,1) in ('2') then 'HOSSEINI'
        WHEN substr(cast(person_id as string),0,1) in ('3') then 'FARID SHIRZAD'
        WHEN substr(cast(person_id as string),0,1) in ('4') then 'TAHERI'
        WHEN substr(cast(person_id as string),0,1) in ('5') then 'NAWEE MOHAMMADY'
        WHEN substr(cast(person_id as string),0,1) in ('6') then 'KABIR RAHIMI'
        WHEN substr(cast(person_id as string),0,1) in ('7') then 'HUSSAINI'
        WHEN substr(cast(person_id as string),0,1) in ('8') then 'NAIM'
        WHEN substr(cast(person_id as string),0,1) in ('9') then 'SAFI'
        WHEN substr(cast(person_id as string),0,1) in ('0') then 'HASSAN'
        ELSE 'HASSANZADA'
      END
        ;;
  }

  dimension: full_name {
    type: string
    sql: concat(${first_name},' ',${last_name}) ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: risk_score {
    type: number
    sql: ${TABLE}.static_risk_score ;;
  }

  dimension: height {
    type: number
    sql: ${TABLE}.height ;;
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;
  }

  # Note: this data was generated in Mockaroo under Aaron Lutkowitz's account, schema #: https://www.mockaroo.com/schemas/140748

  derived_table: {
    datagroup_trigger: once_yearly
      sql:
SELECT 1 as id, 16218 as person_id, 34.3323735 as latitude, 68.0713107 as longitude, 63.53 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 2 as id, 65276 as person_id, 35.0535352 as latitude, 68.655125 as longitude, 40.21 as static_risk_score, 66.46 as height, 184.99 as weight UNION ALL
SELECT 3 as id, 60562 as person_id, 35.5023786 as latitude, 70.1021889 as longitude, 59.68 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 4 as id, 55847 as person_id, 34.4611251 as latitude, 69.3355051 as longitude, 56.91 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 5 as id, 13090 as person_id, 34.7700386 as latitude, 68.2799844 as longitude, 98.13 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 6 as id, 83537 as person_id, 35.1182888 as latitude, 67.9960599 as longitude, 63.89 as static_risk_score, 62.54 as height, 142.4 as weight UNION ALL
SELECT 7 as id, 63889 as person_id, 35.8891038 as latitude, 68.9959437 as longitude, 0.57 as static_risk_score, 65.61 as height, 200.89 as weight UNION ALL
SELECT 8 as id, 47672 as person_id, 34.8115637 as latitude, 69.2461642 as longitude, 50.69 as static_risk_score, 66.28 as height, 183.28 as weight UNION ALL
SELECT 9 as id, 87262 as person_id, 33.3877668 as latitude, 70.4801537 as longitude, 80.53 as static_risk_score, 68.81 as height, 178.25 as weight UNION ALL
SELECT 10 as id, 31534 as person_id, 33.8247512 as latitude, 67.7740171 as longitude, 25.45 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 11 as id, 62004 as person_id, 35.1396034 as latitude, 69.5712566 as longitude, 60.31 as static_risk_score, 75.49 as height, 169.19 as weight UNION ALL
SELECT 12 as id, 14588 as person_id, 34.7273216 as latitude, 67.7219911 as longitude, 17.45 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 13 as id, 76042 as person_id, 33.1529396 as latitude, 70.6324486 as longitude, 7.91 as static_risk_score, 65.65 as height, 197.24 as weight UNION ALL
SELECT 14 as id, 17483 as person_id, 33.7167402 as latitude, 69.5395272 as longitude, 53.26 as static_risk_score, 76.17 as height, 139.89 as weight UNION ALL
SELECT 15 as id, 88227 as person_id, 35.7257758 as latitude, 68.6625457 as longitude, 56.92 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 16 as id, 26892 as person_id, 34.624811 as latitude, 70.09424 as longitude, 37.47 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 17 as id, 91634 as person_id, 34.9255468 as latitude, 70.2951657 as longitude, 34 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 18 as id, 31812 as person_id, 35.8662873 as latitude, 68.5726825 as longitude, 18.97 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 19 as id, 10000 as person_id, 35.4399732 as latitude, 70.0289181 as longitude, 50.45 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 20 as id, 24863 as person_id, 34.4165102 as latitude, 68.2608995 as longitude, 95.37 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 21 as id, 46558 as person_id, 35.9802326 as latitude, 67.9169408 as longitude, 47.25 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 22 as id, 30877 as person_id, 33.9063691 as latitude, 68.0009495 as longitude, 90.95 as static_risk_score, 66.41 as height, 152.76 as weight UNION ALL
SELECT 23 as id, 12556 as person_id, 36.0101114 as latitude, 68.3659116 as longitude, 36.42 as static_risk_score, 60.95 as height, 201.82 as weight UNION ALL
SELECT 24 as id, 72402 as person_id, 34.7642031 as latitude, 68.3321005 as longitude, 65.67 as static_risk_score, 64.77 as height, 188.84 as weight UNION ALL
SELECT 25 as id, 55599 as person_id, 35.9077849 as latitude, 69.4015048 as longitude, 5.21 as static_risk_score, 62.39 as height, 155.48 as weight UNION ALL
SELECT 26 as id, 85108 as person_id, 34.0071721 as latitude, 67.5440648 as longitude, 1.72 as static_risk_score, 62.49 as height, 169.19 as weight UNION ALL
SELECT 27 as id, 24083 as person_id, 33.6875073 as latitude, 70.6129469 as longitude, 94.75 as static_risk_score, 60.2 as height, 184.28 as weight UNION ALL
SELECT 28 as id, 65763 as person_id, 34.1197971 as latitude, 68.3349792 as longitude, 93.51 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 29 as id, 60139 as person_id, 33.9471864 as latitude, 70.3565821 as longitude, 56.54 as static_risk_score, 62.18 as height, 142.69 as weight UNION ALL
SELECT 30 as id, 14548 as person_id, 34.3766925 as latitude, 70.5235646 as longitude, 85.35 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 31 as id, 19504 as person_id, 33.5643613 as latitude, 67.8190043 as longitude, 74.07 as static_risk_score, 69.2 as height, 193.7 as weight UNION ALL
SELECT 32 as id, 91743 as person_id, 35.459828 as latitude, 67.7982556 as longitude, 43.42 as static_risk_score, 66.12 as height, 169.73 as weight UNION ALL
SELECT 33 as id, 60755 as person_id, 34.8635825 as latitude, 69.877966 as longitude, 81.68 as static_risk_score, 58.3 as height, 174.9 as weight UNION ALL
SELECT 34 as id, 95290 as person_id, 33.8684549 as latitude, 68.9788781 as longitude, 15.04 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 35 as id, 37158 as person_id, 33.7578281 as latitude, 69.5084306 as longitude, 19.77 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 36 as id, 31493 as person_id, 33.7651915 as latitude, 67.6547137 as longitude, 46.27 as static_risk_score, 60.58 as height, 180.27 as weight UNION ALL
SELECT 37 as id, 31869 as person_id, 35.5892211 as latitude, 68.7623291 as longitude, 99.97 as static_risk_score, 67.79 as height, 160.22 as weight UNION ALL
SELECT 38 as id, 89648 as person_id, 34.1422634 as latitude, 69.3785136 as longitude, 2.46 as static_risk_score, 70.66 as height, 188.64 as weight UNION ALL
SELECT 39 as id, 94329 as person_id, 34.7587543 as latitude, 70.7218206 as longitude, 9.42 as static_risk_score, 70.88 as height, 176.02 as weight UNION ALL
SELECT 40 as id, 22920 as person_id, 35.9368865 as latitude, 70.1416751 as longitude, 29.05 as static_risk_score, 73.25 as height, 167.7 as weight UNION ALL
SELECT 41 as id, 49011 as person_id, 35.3523349 as latitude, 69.9044463 as longitude, 89.37 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 42 as id, 89879 as person_id, 33.7427957 as latitude, 69.1053023 as longitude, 50.42 as static_risk_score, 70.86 as height, 184.92 as weight UNION ALL
SELECT 43 as id, 21610 as person_id, 34.7568034 as latitude, 68.5459399 as longitude, 9.61 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 44 as id, 56898 as person_id, 34.4952033 as latitude, 69.1403918 as longitude, 45.14 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 45 as id, 47209 as person_id, 33.4266089 as latitude, 69.802012 as longitude, 7.28 as static_risk_score, 70.47 as height, 147.62 as weight UNION ALL
SELECT 46 as id, 59649 as person_id, 33.4094419 as latitude, 68.2257051 as longitude, 16.02 as static_risk_score, 70.93 as height, 133.23 as weight UNION ALL
SELECT 47 as id, 22528 as person_id, 35.722109 as latitude, 67.7275726 as longitude, 73.78 as static_risk_score, 54.26 as height, 171.25 as weight UNION ALL
SELECT 48 as id, 70976 as person_id, 34.9667213 as latitude, 67.9414608 as longitude, 72.35 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 49 as id, 56715 as person_id, 34.7968168 as latitude, 70.2462726 as longitude, 75.38 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 50 as id, 99478 as person_id, 34.5286141 as latitude, 69.4413605 as longitude, 84.41 as static_risk_score, 66.78 as height, 181.05 as weight UNION ALL
SELECT 51 as id, 94889 as person_id, 35.3772609 as latitude, 68.6446751 as longitude, 9.68 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 52 as id, 93393 as person_id, 33.8621349 as latitude, 69.7601026 as longitude, 3.71 as static_risk_score, 71.1 as height, 187.98 as weight UNION ALL
SELECT 53 as id, 13692 as person_id, 34.0268439 as latitude, 70.4944901 as longitude, 51.09 as static_risk_score, 55.33 as height, 189.42 as weight UNION ALL
SELECT 54 as id, 23872 as person_id, 33.2059761 as latitude, 70.2716987 as longitude, 95.07 as static_risk_score, 60.91 as height, 178.05 as weight UNION ALL
SELECT 55 as id, 94888 as person_id, 34.2277732 as latitude, 68.8884112 as longitude, 59.63 as static_risk_score, 60.33 as height, 191.08 as weight UNION ALL
SELECT 56 as id, 53569 as person_id, 33.621311 as latitude, 68.0522363 as longitude, 99.07 as static_risk_score, 58.87 as height, 161.66 as weight UNION ALL
SELECT 57 as id, 64984 as person_id, 35.4473315 as latitude, 69.7007128 as longitude, 9.03 as static_risk_score, 67.15 as height, 178.78 as weight UNION ALL
SELECT 58 as id, 49337 as person_id, 35.2753357 as latitude, 68.9074866 as longitude, 45.24 as static_risk_score, 72.23 as height, 159.09 as weight UNION ALL
SELECT 59 as id, 56689 as person_id, 33.2441535 as latitude, 69.9201988 as longitude, 32.01 as static_risk_score, 76.73 as height, 190.58 as weight UNION ALL
SELECT 60 as id, 90888 as person_id, 33.7661025 as latitude, 68.6387927 as longitude, 2.16 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 61 as id, 98709 as person_id, 34.2886939 as latitude, 68.0147241 as longitude, 99.27 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 62 as id, 64133 as person_id, 34.7372011 as latitude, 69.3460228 as longitude, 36 as static_risk_score, 67.08 as height, 180.67 as weight UNION ALL
SELECT 63 as id, 38603 as person_id, 35.3856482 as latitude, 70.3613357 as longitude, 35.41 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 64 as id, 17464 as person_id, 34.6548292 as latitude, 68.904586 as longitude, 2.75 as static_risk_score, 69.03 as height, 202.39 as weight UNION ALL
SELECT 65 as id, 37775 as person_id, 33.5934606 as latitude, 70.5367019 as longitude, 57.44 as static_risk_score, 73.69 as height, 161.55 as weight UNION ALL
SELECT 66 as id, 65830 as person_id, 34.4864253 as latitude, 70.0312573 as longitude, 79.7 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 67 as id, 28159 as person_id, 34.207565 as latitude, 70.1402249 as longitude, 60.41 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 68 as id, 76852 as person_id, 34.8927337 as latitude, 68.5114473 as longitude, 55.08 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 69 as id, 53026 as person_id, 34.9052695 as latitude, 69.6852754 as longitude, 27.47 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 70 as id, 74599 as person_id, 34.6827834 as latitude, 67.8487336 as longitude, 87.96 as static_risk_score, 72.19 as height, 160.03 as weight UNION ALL
SELECT 71 as id, 26855 as person_id, 35.7500917 as latitude, 67.5116482 as longitude, 47.68 as static_risk_score, 72.16 as height, 129.73 as weight UNION ALL
SELECT 72 as id, 36209 as person_id, 35.3850675 as latitude, 67.9755651 as longitude, 85.15 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 73 as id, 93416 as person_id, 33.6416579 as latitude, 68.3399554 as longitude, 71.56 as static_risk_score, 73.18 as height, 206.78 as weight UNION ALL
SELECT 74 as id, 19955 as person_id, 33.2710656 as latitude, 68.5483222 as longitude, 55.65 as static_risk_score, 70.33 as height, 162.24 as weight UNION ALL
SELECT 75 as id, 16403 as person_id, 34.4185738 as latitude, 69.8721417 as longitude, 4.43 as static_risk_score, 62.71 as height, 145.45 as weight UNION ALL
SELECT 76 as id, 67164 as person_id, 35.3308714 as latitude, 69.5571702 as longitude, 89.08 as static_risk_score, 64.31 as height, 162.67 as weight UNION ALL
SELECT 77 as id, 72734 as person_id, 35.9636002 as latitude, 67.5687111 as longitude, 72.52 as static_risk_score, 64.98 as height, 152.95 as weight UNION ALL
SELECT 78 as id, 23181 as person_id, 35.3973793 as latitude, 70.1504779 as longitude, 75.14 as static_risk_score, 72.55 as height, 191.66 as weight UNION ALL
SELECT 79 as id, 80992 as person_id, 34.2935118 as latitude, 68.3964459 as longitude, 6.96 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 80 as id, 55890 as person_id, 33.8110462 as latitude, 70.1326898 as longitude, 15.89 as static_risk_score, 67.2 as height, 183.5 as weight UNION ALL
SELECT 81 as id, 47950 as person_id, 35.4104026 as latitude, 69.3440845 as longitude, 69.06 as static_risk_score, 64.92 as height, 164.85 as weight UNION ALL
SELECT 82 as id, 72895 as person_id, 35.2016667 as latitude, 69.976583 as longitude, 40.82 as static_risk_score, 62.53 as height, 149.41 as weight UNION ALL
SELECT 83 as id, 77863 as person_id, 35.6580327 as latitude, 68.5260179 as longitude, 77.05 as static_risk_score, 64.95 as height, 131.03 as weight UNION ALL
SELECT 84 as id, 48869 as person_id, 35.5854653 as latitude, 67.9160931 as longitude, 71.6 as static_risk_score, 74.33 as height, 178.28 as weight UNION ALL
SELECT 85 as id, 72258 as person_id, 34.0302286 as latitude, 69.4642577 as longitude, 77.83 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 86 as id, 41814 as person_id, 35.0648245 as latitude, 69.1704817 as longitude, 38.1 as static_risk_score, 64.88 as height, 158.07 as weight UNION ALL
SELECT 87 as id, 28079 as person_id, 34.6523779 as latitude, 70.743872 as longitude, 73.45 as static_risk_score, 69.36 as height, 183.22 as weight UNION ALL
SELECT 88 as id, 17768 as person_id, 34.246526 as latitude, 69.1032305 as longitude, 83.36 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 89 as id, 89845 as person_id, 33.4867608 as latitude, 69.3699736 as longitude, 25.47 as static_risk_score, 63.05 as height, 157.68 as weight UNION ALL
SELECT 90 as id, 11514 as person_id, 33.6780618 as latitude, 69.044319 as longitude, 1.1 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 91 as id, 13857 as person_id, 34.6357904 as latitude, 69.2595844 as longitude, 27.13 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 92 as id, 79650 as person_id, 34.4750581 as latitude, 68.3645444 as longitude, 17.99 as static_risk_score, 66.51 as height, 208.32 as weight UNION ALL
SELECT 93 as id, 22429 as person_id, 34.1599751 as latitude, 69.482459 as longitude, 52.52 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 94 as id, 79422 as person_id, 35.2215952 as latitude, 70.7608105 as longitude, 7.59 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 95 as id, 79439 as person_id, 34.5570476 as latitude, 67.4485877 as longitude, 33.44 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 96 as id, 47937 as person_id, 34.5262987 as latitude, 68.8203957 as longitude, 68.88 as static_risk_score, 57.16 as height, 206.36 as weight UNION ALL
SELECT 97 as id, 60343 as person_id, 33.274696 as latitude, 68.3568914 as longitude, 29.31 as static_risk_score, 65.19 as height, 166.67 as weight UNION ALL
SELECT 98 as id, 77741 as person_id, 33.9099059 as latitude, 68.4011305 as longitude, 21.44 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 99 as id, 61320 as person_id, 34.3776591 as latitude, 67.545128 as longitude, 20.93 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 100 as id, 81286 as person_id, 34.8210084 as latitude, 68.6667027 as longitude, 11.04 as static_risk_score, 72.56 as height, 192.18 as weight UNION ALL
SELECT 101 as id, 24160 as person_id, 34.2562095 as latitude, 67.4847135 as longitude, 71.19 as static_risk_score, 64.39 as height, 162.12 as weight UNION ALL
SELECT 102 as id, 12133 as person_id, 35.8638411 as latitude, 70.2435861 as longitude, 0.19 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 103 as id, 31832 as person_id, 35.3660782 as latitude, 68.4987887 as longitude, 32.74 as static_risk_score, 67.98 as height, 171.72 as weight UNION ALL
SELECT 104 as id, 31253 as person_id, 34.5579639 as latitude, 68.078503 as longitude, 34.81 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 105 as id, 15405 as person_id, 33.8998484 as latitude, 70.7029045 as longitude, 59.44 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 106 as id, 14398 as person_id, 35.4309008 as latitude, 68.3655708 as longitude, 62.19 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 107 as id, 80217 as person_id, 33.861924 as latitude, 67.9367082 as longitude, 56.91 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 108 as id, 13538 as person_id, 35.4212908 as latitude, 68.5385416 as longitude, 23.3 as static_risk_score, 70.87 as height, 171.29 as weight UNION ALL
SELECT 109 as id, 15308 as person_id, 35.2580295 as latitude, 68.8548628 as longitude, 92.05 as static_risk_score, 70.55 as height, 149.6 as weight UNION ALL
SELECT 110 as id, 55926 as person_id, 33.9686006 as latitude, 70.598424 as longitude, 3.36 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 111 as id, 95523 as person_id, 34.340564 as latitude, 69.4583868 as longitude, 43.81 as static_risk_score, 65.8 as height, 166.35 as weight UNION ALL
SELECT 112 as id, 74520 as person_id, 34.9164623 as latitude, 69.8945036 as longitude, 54.36 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 113 as id, 87601 as person_id, 33.3195497 as latitude, 69.3188965 as longitude, 53.49 as static_risk_score, 73.86 as height, 170.8 as weight UNION ALL
SELECT 114 as id, 70356 as person_id, 34.8951894 as latitude, 67.4465725 as longitude, 4.34 as static_risk_score, 66.52 as height, 149.71 as weight UNION ALL
SELECT 115 as id, 30894 as person_id, 35.8133582 as latitude, 68.7811467 as longitude, 65.35 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 116 as id, 91641 as person_id, 33.62035 as latitude, 68.8349301 as longitude, 99.99 as static_risk_score, 65.51 as height, 181.54 as weight UNION ALL
SELECT 117 as id, 28076 as person_id, 33.5200233 as latitude, 67.5907543 as longitude, 80.21 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 118 as id, 43105 as person_id, 34.3348757 as latitude, 69.4208906 as longitude, 8.12 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 119 as id, 62390 as person_id, 35.9114745 as latitude, 68.1771359 as longitude, 44.98 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 120 as id, 36031 as person_id, 34.4103386 as latitude, 68.7573639 as longitude, 31.11 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 121 as id, 60469 as person_id, 35.7067772 as latitude, 69.5335635 as longitude, 22.19 as static_risk_score, 63.85 as height, 155.49 as weight UNION ALL
SELECT 122 as id, 35005 as person_id, 34.6681987 as latitude, 68.0177973 as longitude, 7.7 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 123 as id, 33881 as person_id, 34.6227039 as latitude, 68.2886046 as longitude, 87.14 as static_risk_score, 68.19 as height, 200.78 as weight UNION ALL
SELECT 124 as id, 49847 as person_id, 33.1977119 as latitude, 68.7618087 as longitude, 85.48 as static_risk_score, 66.69 as height, 114.89 as weight UNION ALL
SELECT 125 as id, 55126 as person_id, 35.6286911 as latitude, 69.777666 as longitude, 73.52 as static_risk_score, 56.4 as height, 194.59 as weight UNION ALL
SELECT 126 as id, 71215 as person_id, 35.1365478 as latitude, 69.9190588 as longitude, 93.33 as static_risk_score, 67.39 as height, 144.98 as weight UNION ALL
SELECT 127 as id, 29492 as person_id, 33.3682421 as latitude, 67.7377539 as longitude, 42.28 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 128 as id, 78376 as person_id, 33.8178841 as latitude, 69.002809 as longitude, 68.41 as static_risk_score, 68.88 as height, 157.04 as weight UNION ALL
SELECT 129 as id, 73234 as person_id, 35.6482216 as latitude, 68.2073166 as longitude, 99.75 as static_risk_score, 60.81 as height, 179.17 as weight UNION ALL
SELECT 130 as id, 99523 as person_id, 33.6077331 as latitude, 70.2761472 as longitude, 98.48 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 131 as id, 64586 as person_id, 34.3244919 as latitude, 69.6048305 as longitude, 94.3 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 132 as id, 64423 as person_id, 34.1122664 as latitude, 67.5476958 as longitude, 24.39 as static_risk_score, 71.45 as height, 180.01 as weight UNION ALL
SELECT 133 as id, 29515 as person_id, 35.3287223 as latitude, 69.7685018 as longitude, 27.71 as static_risk_score, 65.55 as height, 163.71 as weight UNION ALL
SELECT 134 as id, 58598 as person_id, 34.7281125 as latitude, 67.7267588 as longitude, 62.85 as static_risk_score, 75.04 as height, 207.81 as weight UNION ALL
SELECT 135 as id, 97064 as person_id, 35.2769993 as latitude, 69.5934458 as longitude, 93.4 as static_risk_score, 65.77 as height, 145.02 as weight UNION ALL
SELECT 136 as id, 33732 as person_id, 34.8186098 as latitude, 68.1718856 as longitude, 73.85 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 137 as id, 24251 as person_id, 34.3409828 as latitude, 69.7045795 as longitude, 56.62 as static_risk_score, 77.59 as height, 167.95 as weight UNION ALL
SELECT 138 as id, 13763 as person_id, 35.695174 as latitude, 67.8933073 as longitude, 8.14 as static_risk_score, 62.97 as height, 149.57 as weight UNION ALL
SELECT 139 as id, 10584 as person_id, 35.4607151 as latitude, 67.923288 as longitude, 66.48 as static_risk_score, 64.17 as height, 152.81 as weight UNION ALL
SELECT 140 as id, 78989 as person_id, 34.5954838 as latitude, 68.4695149 as longitude, 72.15 as static_risk_score, 68.53 as height, 189.95 as weight UNION ALL
SELECT 141 as id, 42487 as person_id, 34.4170965 as latitude, 70.5638997 as longitude, 67.31 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 142 as id, 33225 as person_id, 33.2724499 as latitude, 68.9423432 as longitude, 39.44 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 143 as id, 87513 as person_id, 35.3763785 as latitude, 70.2338791 as longitude, 75.98 as static_risk_score, 67.62 as height, 137.08 as weight UNION ALL
SELECT 144 as id, 95489 as person_id, 35.2004432 as latitude, 68.9572824 as longitude, 75.27 as static_risk_score, 71.84 as height, 179.18 as weight UNION ALL
SELECT 145 as id, 14699 as person_id, 35.6040205 as latitude, 67.8885682 as longitude, 55.3 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 146 as id, 18261 as person_id, 34.1354985 as latitude, 69.9638759 as longitude, 29.67 as static_risk_score, 55.34 as height, 163.26 as weight UNION ALL
SELECT 147 as id, 22899 as person_id, 34.1231551 as latitude, 67.7998486 as longitude, 33.52 as static_risk_score, 69.8 as height, 172.56 as weight UNION ALL
SELECT 148 as id, 59948 as person_id, 34.0498985 as latitude, 70.495027 as longitude, 44.01 as static_risk_score, 63.2 as height, 113.59 as weight UNION ALL
SELECT 149 as id, 91580 as person_id, 33.5141901 as latitude, 70.3052977 as longitude, 60.39 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 150 as id, 65238 as person_id, 35.6892667 as latitude, 67.7787736 as longitude, 68.23 as static_risk_score, 73.48 as height, 116.22 as weight UNION ALL
SELECT 151 as id, 56704 as person_id, 33.286628 as latitude, 69.4108407 as longitude, 51.94 as static_risk_score, 73.29 as height, 134.96 as weight UNION ALL
SELECT 152 as id, 29848 as person_id, 35.738979 as latitude, 69.4784591 as longitude, 57.14 as static_risk_score, 65.7 as height, 158.73 as weight UNION ALL
SELECT 153 as id, 74297 as person_id, 35.1804313 as latitude, 70.2192934 as longitude, 44.53 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 154 as id, 66059 as person_id, 33.6182398 as latitude, 69.4350301 as longitude, 42.96 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 155 as id, 67418 as person_id, 35.6197294 as latitude, 68.5555836 as longitude, 95.65 as static_risk_score, 58.96 as height, 154.5 as weight UNION ALL
SELECT 156 as id, 56094 as person_id, 33.9571492 as latitude, 68.33619 as longitude, 90.3 as static_risk_score, 70.86 as height, 157.19 as weight UNION ALL
SELECT 157 as id, 82955 as person_id, 35.3817645 as latitude, 70.3487691 as longitude, 45.85 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 158 as id, 91043 as person_id, 34.0190634 as latitude, 67.4850127 as longitude, 73.14 as static_risk_score, 67.6 as height, 138.11 as weight UNION ALL
SELECT 159 as id, 59407 as person_id, 33.7301976 as latitude, 70.5717526 as longitude, 97.73 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 160 as id, 91707 as person_id, 33.3768454 as latitude, 68.9703685 as longitude, 3.62 as static_risk_score, 72.52 as height, 172.9 as weight UNION ALL
SELECT 161 as id, 81289 as person_id, 34.5022274 as latitude, 67.8769649 as longitude, 41.55 as static_risk_score, 63.81 as height, 151.4 as weight UNION ALL
SELECT 162 as id, 22546 as person_id, 35.7582038 as latitude, 70.7806455 as longitude, 76.7 as static_risk_score, 73.95 as height, 134.02 as weight UNION ALL
SELECT 163 as id, 29904 as person_id, 34.2265481 as latitude, 68.4446064 as longitude, 28.09 as static_risk_score, 67.75 as height, 177.44 as weight UNION ALL
SELECT 164 as id, 77336 as person_id, 34.4670815 as latitude, 69.3591631 as longitude, 32.62 as static_risk_score, 56.35 as height, 161.74 as weight UNION ALL
SELECT 165 as id, 57643 as person_id, 34.3737037 as latitude, 68.6155788 as longitude, 8.64 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 166 as id, 34375 as person_id, 34.7041337 as latitude, 68.0672577 as longitude, 76.55 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 167 as id, 94371 as person_id, 35.6812725 as latitude, 68.9019047 as longitude, 67.34 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 168 as id, 92480 as person_id, 33.4853791 as latitude, 69.4729199 as longitude, 76.29 as static_risk_score, 65.66 as height, 161.86 as weight UNION ALL
SELECT 169 as id, 70268 as person_id, 35.5592785 as latitude, 68.0534224 as longitude, 71.08 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 170 as id, 66521 as person_id, 35.4297597 as latitude, 68.2125756 as longitude, 20.65 as static_risk_score, 68.98 as height, 140 as weight UNION ALL
SELECT 171 as id, 41109 as person_id, 35.5070038 as latitude, 68.2662401 as longitude, 62.56 as static_risk_score, 72.43 as height, 159.51 as weight UNION ALL
SELECT 172 as id, 81601 as person_id, 35.0776617 as latitude, 70.5035552 as longitude, 38.85 as static_risk_score, 72.03 as height, 190.76 as weight UNION ALL
SELECT 173 as id, 16523 as person_id, 33.1781461 as latitude, 68.0731449 as longitude, 85.74 as static_risk_score, 68.29 as height, 203.07 as weight UNION ALL
SELECT 174 as id, 52254 as person_id, 33.4947286 as latitude, 68.5963865 as longitude, 67.62 as static_risk_score, 67.75 as height, 141.34 as weight UNION ALL
SELECT 175 as id, 72500 as person_id, 35.1095527 as latitude, 67.7620563 as longitude, 91.52 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 176 as id, 31298 as person_id, 33.5349804 as latitude, 67.8428176 as longitude, 83.28 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 177 as id, 59044 as person_id, 34.4093918 as latitude, 67.8667492 as longitude, 23.38 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 178 as id, 67680 as person_id, 34.211042 as latitude, 67.8316589 as longitude, 84.81 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 179 as id, 33095 as person_id, 34.9761718 as latitude, 67.8349716 as longitude, 52.61 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 180 as id, 95410 as person_id, 34.9038784 as latitude, 68.7709733 as longitude, 11.47 as static_risk_score, 64.71 as height, 171.46 as weight UNION ALL
SELECT 181 as id, 55563 as person_id, 34.7408553 as latitude, 68.3252604 as longitude, 97.88 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 182 as id, 18317 as person_id, 35.2065194 as latitude, 70.6716124 as longitude, 42.61 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 183 as id, 65509 as person_id, 33.280882 as latitude, 68.4278239 as longitude, 24 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 184 as id, 16180 as person_id, 35.0678554 as latitude, 67.8134971 as longitude, 23.05 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 185 as id, 58399 as person_id, 33.1557005 as latitude, 70.6968724 as longitude, 65.05 as static_risk_score, 69.98 as height, 168.55 as weight UNION ALL
SELECT 186 as id, 79259 as person_id, 35.5998765 as latitude, 68.2299865 as longitude, 15.34 as static_risk_score, 69.58 as height, 160.45 as weight UNION ALL
SELECT 187 as id, 17173 as person_id, 35.8752575 as latitude, 68.7359773 as longitude, 77.91 as static_risk_score, 66.78 as height, 156.14 as weight UNION ALL
SELECT 188 as id, 55663 as person_id, 33.942629 as latitude, 69.3836149 as longitude, 73.16 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 189 as id, 68718 as person_id, 33.2725841 as latitude, 67.4723817 as longitude, 9.95 as static_risk_score, 66.3 as height, 147.7 as weight UNION ALL
SELECT 190 as id, 20318 as person_id, 35.4666809 as latitude, 70.0261672 as longitude, 55.23 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 191 as id, 13791 as person_id, 34.9676894 as latitude, 69.2045251 as longitude, 95.62 as static_risk_score, 54.59 as height, 161.86 as weight UNION ALL
SELECT 192 as id, 59130 as person_id, 34.0615161 as latitude, 68.8222838 as longitude, 53.5 as static_risk_score, 77.41 as height, 146.1 as weight UNION ALL
SELECT 193 as id, 71656 as person_id, 34.6434303 as latitude, 70.3008788 as longitude, 79.87 as static_risk_score, 61.64 as height, 160.92 as weight UNION ALL
SELECT 194 as id, 64596 as person_id, 34.5719606 as latitude, 70.0879515 as longitude, 30.45 as static_risk_score, 71.11 as height, 157.16 as weight UNION ALL
SELECT 195 as id, 29751 as person_id, 33.3773458 as latitude, 70.6567289 as longitude, 44.8 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 196 as id, 91019 as person_id, 34.5839585 as latitude, 69.9950936 as longitude, 91.92 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 197 as id, 57265 as person_id, 33.7943193 as latitude, 67.4047944 as longitude, 64.76 as static_risk_score, 54.02 as height, 147.28 as weight UNION ALL
SELECT 198 as id, 40727 as person_id, 36.0011442 as latitude, 68.279027 as longitude, 51.85 as static_risk_score, 63.02 as height, 167.91 as weight UNION ALL
SELECT 199 as id, 89592 as person_id, 34.7041844 as latitude, 70.2711787 as longitude, 95.69 as static_risk_score, NULL as height, NULL as weight UNION ALL
SELECT 200 as id, 63967 as person_id, 34.5467714 as latitude, 68.1885392 as longitude, 37.75 as static_risk_score, 61.74 as height, 149.2 as weight
      ;;
  }
}
