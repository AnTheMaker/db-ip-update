# db-ip-update
The `geoip-update.sh` bash script gets the latest version of the free "IP-to-City Lite" GeoIP database provided by db-ip.com and places it at `/usr/share/geoip-data/geoip.mmdb` (or any other location you define).

It is recommended to create a cronjob to execute this script once a month to keep your GeoIP database up-to-date

> **Note**
> When using the GeoIP data, please make sure to comply with the terms of db-ip.com (attribution, etc.): https://db-ip.com/db/download/ip-to-city-lite
