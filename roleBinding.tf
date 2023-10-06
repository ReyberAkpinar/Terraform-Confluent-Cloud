
resource "confluent_service_account" "app-manager" {
  display_name = "app-manager"
  description  = "Service account to manage 'standard' Kafka cluster"
}

resource "confluent_role_binding" "app-manager-kafka-cluster-admin" {
  principal   = "User:${confluent_service_account.app-manager.id}"
  role_name   = "CloudClusterAdmin"
  crn_pattern = confluent_kafka_cluster.standard.rbac_crn
}

resource "confluent_api_key" "app-manager-kafka-api-key" {
  display_name = "app-manager-kafka-api-key"
  description  = "Kafka API Key that is owned by 'app-manager' service account"
  owner {
    id          = confluent_service_account.app-manager.id
    api_version = confluent_service_account.app-manager.api_version
    kind        = confluent_service_account.app-manager.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.standard.id
    api_version = confluent_kafka_cluster.standard.api_version
    kind        = confluent_kafka_cluster.standard.kind

    environment {
      id = confluent_environment.staging.id
    }
  }

  depends_on = [
    confluent_role_binding.app-manager-kafka-cluster-admin
  ]
}


resource "confluent_service_account" "app-consumer" {
  display_name = "app-consumer"
  description  = "Service account to consume from 'orders' topic of 'Coding-Session' Kafka cluster"
}

resource "confluent_api_key" "app-consumer-kafka-api-key" {
  display_name = "app-consumer-kafka-api-key"
  description  = "Kafka API Key that is owned by 'app-consumer' service account"
  owner {
    id          = confluent_service_account.app-consumer.id
    api_version = confluent_service_account.app-consumer.api_version
    kind        = confluent_service_account.app-consumer.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.standard.id
    api_version = confluent_kafka_cluster.standard.api_version
    kind        = confluent_kafka_cluster.standard.kind

    environment {
      id = confluent_environment.staging.id
    }
  }
}

resource "confluent_role_binding" "app-producer-developer-write" {
  principal   = "User:${confluent_service_account.app-producer.id}"
  role_name   = "DeveloperWrite"
  crn_pattern = "${confluent_kafka_cluster.standard.rbac_crn}/kafka=${confluent_kafka_cluster.standard.id}/topic=${confluent_kafka_topic.orders.topic_name}"
}

resource "confluent_service_account" "app-producer" {
  display_name = "app-producer"
  description  = "Service account to produce to 'orders' topic of 'Coding-Session' Kafka cluster"
}

resource "confluent_api_key" "app-producer-kafka-api-key" {
  display_name = "app-producer-kafka-api-key"
  description  = "Kafka API Key that is owned by 'app-producer' service account"
  owner {
    id          = confluent_service_account.app-producer.id
    api_version = confluent_service_account.app-producer.api_version
    kind        = confluent_service_account.app-producer.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.standard.id
    api_version = confluent_kafka_cluster.standard.api_version
    kind        = confluent_kafka_cluster.standard.kind

    environment {
      id = confluent_environment.staging.id
    }
  }
}

resource "confluent_role_binding" "app-consumer-developer-read-from-topic" {
  principal   = "User:${confluent_service_account.app-consumer.id}"
  role_name   = "DeveloperRead"
  crn_pattern = "${confluent_kafka_cluster.standard.rbac_crn}/kafka=${confluent_kafka_cluster.standard.id}/topic=${confluent_kafka_topic.orders.topic_name}"
}

resource "confluent_role_binding" "app-consumer-developer-read-from-group" {
  principal   = "User:${confluent_service_account.app-consumer.id}"
  role_name   = "DeveloperRead"
  crn_pattern = "${confluent_kafka_cluster.standard.rbac_crn}/kafka=${confluent_kafka_cluster.standard.id}/group=confluent_cli_consumer_*"
}

resource "confluent_service_account" "env-manager" {
  display_name = "env-manager"
  description  = "Service account to manage 'Staging' environment"
}

resource "confluent_role_binding" "env-manager-data-steward" {
  principal   = "User:${confluent_service_account.env-manager.id}"
  role_name   = "DataSteward"
  crn_pattern = confluent_environment.staging.resource_name
}

resource "confluent_api_key" "env-manager-schema-registry-api-key" {
  display_name = "env-manager-schema-registry-api-key"
  description  = "Schema Registry API Key that is owned by 'env-manager' service account"
  owner {
    id          = confluent_service_account.env-manager.id
    api_version = confluent_service_account.env-manager.api_version
    kind        = confluent_service_account.env-manager.kind
  }

  managed_resource {
    id          = confluent_schema_registry_cluster.essentials.id
    api_version = confluent_schema_registry_cluster.essentials.api_version
    kind        = confluent_schema_registry_cluster.essentials.kind

    environment {
      id = confluent_environment.staging.id
    }
  }
  depends_on = [
    confluent_role_binding.env-manager-data-steward
  ]
}
