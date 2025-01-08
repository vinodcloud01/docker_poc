## Readme

**Commands**  
clear
docker stop influxdb
docker rm influxdb
docker volume rm influxdb_data_volume
docker volume rm influxdb_config_volume

**Deploy one particular service**
docker-compose -f docker-compose_secrets.yml up -d --build influxdb
docker logs influxdb >logfile.txt 2>&1

**Example Token**
INFLUXDB_ADMIN_TOKEN="-5Xgb6CuEDTtEpsL4Twkazdd3MzbFNYVwusdNMxYyqcybIfbOY0AXcqFmPQM_KD8DIhHWafyr5RAfvF0eDblZw=="

**Backup full Volumes directly Commands through conatiner**
docker run --rm -v influxdb1_data_volume:/from -v influxdb1_data_volume-copy:/to alpine ash -c "cd /from && cp -a . /to"
docker run --rm -v influxdb1_config_volume:/from -v influxdb1_config_volume-copy:/to alpine ash -c "cd /from && cp -a . /to"

**Backup using influx commands**
docker exec -it influxdb1 influxd backup  /backupdb1
docker exec -it influxdb1 ls -lart  /backupdb1
docker cp influxdb1:/backupdb1 ./backupdb1
docker cp ./backupdb1 influxdb:/backupdb1
docker exec -it influxdb influxd restore /backupdb1


**Encrypt Secrets file**
openssl enc -aes-256-cbc -salt -pbkdf2 -iter 100000 -in secrets.env -out secrets.env.enc
**Decrypt Secrets file**
openssl enc -aes-256-cbc -salt -d -pbkdf2 -iter 100000 -in secrets.env.enc -out secrets.env
