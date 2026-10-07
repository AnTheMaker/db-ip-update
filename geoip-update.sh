# IMPORTANT:
# When using the GeoIP data, please make sure to comply with the terms of db-ip.com (attribution, etc.):
# https://db-ip.com/db/download/ip-to-city-lite
#
# ABOUT THIS SCRIPT:
# This script gets the latest version of the free "IP-to-Country/City/ASN Lite" GeoIP database provided by db-ip.com
# and places it at /var/geoip-data/geoip.mmdb (can be changed below)
#
# It is recommended to create a cronjob to execute this script once a month to keep your GeoIP database up-to-date
# https://github.com/AnTheMaker/db-ip-update


# change these variables to your liking
geoip_dir="/var/geoip-data"
type="city" # can be "city", "country", or "asn"


download_file="dbip-$type-lite-$(date +'%Y')-$(date +'%m').mmdb"
download_url="https://download.db-ip.com/free/$download_file.gz"

# create destination folder (if it doesn't exist yet)
mkdir -p $geoip_dir

# download latest GeoIP database and unzip it
# (-f: don't save HTTP error pages, so a failed download can't replace a good database)
if curl -fsS "$download_url" -o "$geoip_dir/geoip_download.mmdb.gz" && gunzip -f "$geoip_dir/geoip_download.mmdb.gz"; then
  download_ok=true
else
  download_ok=false
  rm -f "$geoip_dir/geoip_download.mmdb.gz" "$geoip_dir/geoip_download.mmdb"
  echo "geoip-update: download failed, keeping existing database" >&2
fi

# move it to the correct destination
if [ "$download_ok" = true ] && [ -e $geoip_dir/geoip_download.mmdb ]; then
  if [ -e $geoip_dir/geoip.mmdb ]; then
    cp $geoip_dir/geoip.mmdb $geoip_dir/geoip.mmdb.old
  fi
  mv -f $geoip_dir/geoip_download.mmdb $geoip_dir/geoip.mmdb

  # uncomment the following line if you want to make the geoip.mmdb file readable by everyone
  #chmod 644 $geoip_dir/geoip.mmdb
fi

