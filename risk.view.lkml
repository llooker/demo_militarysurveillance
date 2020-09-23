view: risk {
  derived_table: {
    explore_source: person {
      column: average_risk_score {}
      column: connection_score_risk { field: person_to_person_activity.connection_score_risk }
      column: average_suspicious_activity_score { field: average_suspicious_score.average_suspicious_activity_score }
      column: id {}
    }
  }
  dimension: average_risk_score {
    hidden: yes
    value_format: "#,##0.00%"
    type: number
  }
  dimension: connection_score_risk {
    hidden: yes
    description: "% of connection associated with risky suspects"
    value_format: "#,##0.00%"
    type: number
  }
  dimension: average_suspicious_activity_score {
    hidden: yes
    value_format: "#,##0.00%"
    type: number
  }
  measure: avg_risk_score {
    hidden: yes
    type: average
    sql: ${average_risk_score} ;;
  }
  measure: avg_connection_score {
    hidden: yes
    type: average
    sql: ${connection_score_risk} ;;
  }
  measure: avg_suspicious_score {
    hidden: yes
    type: average
    sql: ${average_suspicious_activity_score} ;;
  }
  dimension: id {
    hidden: yes
    primary_key: yes
    value_format: "0"
    type: number
  }
  parameter: weight_biometric_risk {
    type:  unquoted
    default_value: "2"
  }

  parameter: weight_connection_risk {
    type:  unquoted
    default_value: "3"
  }

  parameter: weight_activity_risk {
    type:  unquoted
    default_value: "1"
  }

  dimension: weight_percent_biometric_risk {
    type: number
    sql: {% parameter weight_biometric_risk %} ;;
    hidden:  yes
  }

  dimension: weight_percent_connection_risk {

    type: number
    sql: {% parameter weight_connection_risk %} ;;
    hidden:  yes
  }

  dimension: weight_percent_activity_risk {
    type: number
    sql: {% parameter weight_activity_risk %} ;;
    hidden:  yes
  }

  dimension: sum_weights_dimension {
    type: number
    hidden: yes
    sql:    ${weight_percent_biometric_risk} +
            ${weight_percent_connection_risk} +
            ${weight_percent_activity_risk}
            ;;
  }

  measure: sum_weights {
    type: number
    hidden: yes
    sql:    ${weight_percent_biometric_risk} +
            ${weight_percent_connection_risk} +
            ${weight_percent_activity_risk}
            ;;
  }


  measure: risk_score {
    # group_label: "Risk Score"
    label: "Overall Risk Score"
    description: "Weighted Avg of Biometrics, Connections, and Suspicious Activity"
    type: number
    hidden:  no
    sql:
    (
        ${avg_risk_score} * ${weight_percent_biometric_risk}
        +   ${avg_connection_score} * ${weight_percent_connection_risk}
        +   ${avg_suspicious_score} * ${weight_percent_activity_risk}
        ) /   nullif(${sum_weights_dimension},0)
        ;;
    value_format_name: percent_2
    drill_fields: [
      id,
      avg_risk_score,
      avg_connection_score,
      avg_suspicious_score
    ]
  }

}
