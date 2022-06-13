# Installed as crontab to run monthly
# 00 17 1 * *
# Open Dropbox
open -a "Dropbox"
# Wait 10 minutes to open and sync
sleep 600

months=(
"12-December"
"01-January"
"02-February"
"03-March"
"04-April"
"05-May"
"06-June"
"07-July"
"08-August"
"09-September"
"10-October"
"11-November"
)
month=$(date +%m)
year=$(date +%Y)
if ($month == 01) then
  year=$(($year-1))
fi
lastMonth=$(($month-1))
folder=${months[$lastMonth]}
cd "/Users/milesfrance/Dropbox/Camera Uploads"
# Create folder of the month
mkdir -p "$year/$folder"
# Move files into folder
mv *.jpg "$year/$folder"
mv *.mp4 "$year/$folder"
mv *.mpeg "$year/$folder"
rsync -azv "$year/$folder" chromebox:/home/protitude/elements/picts/CellPhotos/$year
