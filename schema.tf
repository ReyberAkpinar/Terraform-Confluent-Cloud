data "confluent_schema_registry_region" "essentials" {
  cloud   = "AWS"
  region  = "eu-central-1"
  package = "ESSENTIALS"
}

resource "confluent_schema_registry_cluster" "essentials" {
  package = data.confluent_schema_registry_region.essentials.package

  environment {
    id = confluent_environment.staging.id
  }

  region {
    id = data.confluent_schema_registry_region.essentials.id
  }
}

resource "confluent_schema" "orders" {
  schema_registry_cluster {
    id = confluent_schema_registry_cluster.essentials.id
  }
  rest_endpoint = confluent_schema_registry_cluster.essentials.rest_endpoint
  # https://developer.confluent.io/learn-kafka/schema-registry/schema-subjects/#topicnamestrategy
  subject_name = "${confluent_kafka_topic.orders.topic_name}-value"
  format       = "AVRO"
  schema       = file("./schemas/avro/orders.avsc")
  credentials {
    key    = confluent_api_key.env-manager-schema-registry-api-key.id
    secret = confluent_api_key.env-manager-schema-registry-api-key.secret
  }
}