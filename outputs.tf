output "resource-ids" {
  value = <<-EOT
  Environment ID:   ${confluent_environment.staging.id}
  Kafka Cluster ID: ${confluent_kafka_cluster.standard.id}
  Kafka topic name: ${confluent_kafka_topic.orders.topic_name}

  ${confluent_service_account.app-manager.display_name}:                     ${confluent_service_account.app-manager.id}
  ${confluent_service_account.app-manager.display_name}'s Kafka API Key:     "${confluent_api_key.app-manager-kafka-api-key.id}"
  ${confluent_service_account.app-manager.display_name}'s Kafka API Secret:  "${confluent_api_key.app-manager-kafka-api-key.secret}"

  ${confluent_service_account.app-producer.display_name}:                    ${confluent_service_account.app-producer.id}
  ${confluent_service_account.app-producer.display_name}'s Kafka API Key:    "${confluent_api_key.app-producer-kafka-api-key.id}"
  ${confluent_service_account.app-producer.display_name}'s Kafka API Secret: "${confluent_api_key.app-producer-kafka-api-key.secret}"

  ${confluent_service_account.app-consumer.display_name}:                    ${confluent_service_account.app-consumer.id}
  ${confluent_service_account.app-consumer.display_name}'s Kafka API Key:    "${confluent_api_key.app-consumer-kafka-api-key.id}"
  ${confluent_service_account.app-consumer.display_name}'s Kafka API Secret: "${confluent_api_key.app-consumer-kafka-api-key.secret}"

  ### Schema
  ${confluent_schema_registry_cluster.essentials.display_name}: "${confluent_schema_registry_cluster.essentials.id}"
  ${confluent_schema_registry_cluster.essentials.display_name}'s Rest Endpoint: "${confluent_schema_registry_cluster.essentials.rest_endpoint}"
  
  ### Flink Cluster
  ${confluent_flink_compute_pool.main.display_name}: "${confluent_flink_compute_pool.main.id}"
  ${confluent_flink_compute_pool.main.display_name}'s Rest Endpoint: "${confluent_flink_compute_pool.main.rest_endpoint}"

  ### Gib diesen Befehl ein um mit der CLI in deinem Flink Cluster zu kommen

  $ confluent flink shell --compute-pool ${confluent_flink_compute_pool.main.id} --environment ${confluent_environment.staging.id}
  EOT

  sensitive = true
}
