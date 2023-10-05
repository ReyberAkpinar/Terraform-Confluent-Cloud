### Notes

#Vorbereitung: 
#Gib diese Befehle in deinem Terminal ein. 

#Den ersten command nur eingeben, wenn du kein Confluent CLI hast

$ brew install confluentinc/tap/cli

$ confluent login
$ confluent api-key create --resource cloud

### Beide werde werden nun benötigt

$ export CONFLUENT_CLOUD_API_KEY="<API Key>"
$ export CONFLUENT_CLOUD_API_SECRET="<API Secret>"

$ terraform init
$ terraform apply

### Falls du einen Rest Endpoint oder eine ID suchst, dann führ den folgenden Befehl aus:

$ terraform output resource-ids

### Am ende noch

$ terraform destroy