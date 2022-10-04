# IMPORTANT:
# When using the GeoIP data, please make sure to comply with the terms of db-ip.com (attribution, etc.):
# https://db-ip.com/db/download/ip-to-city-lite
#
# ABOUT THIS SCRIPT:
# This script gets the latest version of the free "IP-to-City Lite" GeoIP database provided by db-ip.com
# and places it at /var/geoip-data/geoip.mmdb (can be changed below)
#
# It is recommended to create a cronjob to execute this script once a month to keep your GeoIP database up-to-date


geoip_dir="/var/geoip-data"
download_file="dbip-city-lite-$(date +'%Y')-$(date +'%m').mmdb"
download_url="https://download.db-ip.com/free/$download_file.gz"

# create destination folder (if it doesn't exist yet)
mkdir -p $geoip_dir

# download latest GeoIP database and unzip it
curl -s $download_url -o $geoip_dir/geoip_download.mmdb.gz
gunzip -f $geoip_dir/geoip_download.mmdb.gz

# move it to the correct destination
if [ -e $geoip_dir/geoip_download.mmdb ]; then
  if [ -e $geoip_dir/geoip.mmdb ]; then
    cp $geoip_dir/geoip.mmdb $geoip_dir/geoip.mmdb.old
  fi
  mv -f $geoip_dir/geoip_download.mmdb $geoip_dir/geoip.mmdb
fi

