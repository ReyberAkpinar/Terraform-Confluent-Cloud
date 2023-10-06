terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "1.54.0"
    }
  }
}

resource "confluent_environment" "staging" {
  display_name = "POC-Terraform-Confluent"
}

resource "confluent_kafka_cluster" "standard" {
  display_name = "Coding-Session"
  availability = "SINGLE_ZONE"
  cloud        = "AWS"
  region       = "eu-central-1"
  standard {}
  environment {
    id = confluent_environment.staging.id
  }
}


resource "confluent_kafka_topic" "orders" {
  kafka_cluster {
    id = confluent_kafka_cluster.standard.id
  }
  topic_name    = "orders"
  rest_endpoint = confluent_kafka_cluster.standard.rest_endpoint
  credentials {
    key    = confluent_api_key.app-manager-kafka-api-key.id
    secret = confluent_api_key.app-manager-kafka-api-key.secret
  }
}
