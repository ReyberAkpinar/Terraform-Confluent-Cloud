resource "confluent_flink_compute_pool" "main" {
  display_name = "Flink-Coding-Session"
  cloud        = "AWS"
  region       = "eu-central-1"
  max_cfu      = 5
  environment {
    id = confluent_environment.staging.id
  }
}