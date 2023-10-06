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