export DEBEZIUM_VERSION=1.8
docker-compose -f docker-compose-sqlserver.yaml up

cat debezium-sqlserver-init/inventory.sql   | docker-compose -f docker-compose-sqlserver.yaml exec -T sqlserver   bash -c '/opt/mssql-tools/bin/sqlcmd -U sa -P $SA_PASSWORD'
cat debezium-sqlserver-init/destination.sql | docker-compose -f docker-compose-sqlserver.yaml exec -T destination bash -c '/opt/mssql-tools/bin/sqlcmd -U sa -P $SA_PASSWORD'

curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @register-sqlserver.json
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @register-sqlserver-sink.json

docker-compose -f docker-compose-sqlserver.yaml exec sqlserver bash -c '/opt/mssql-tools/bin/sqlcmd -U sa -P $SA_PASSWORD -d testDB'

#docker-compose -f docker-compose-sqlserver.yaml exec kafka bin/kafka-topicsh --list --bootstrap-server kafka:9092