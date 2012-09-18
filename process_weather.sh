#!/bin/bash

pywws=/usr/local/pywws-11.10_r429
pywwsdata=/home/bagpuss/www/sites/glasgownet.com/weather

python /usr/local/pywws-11.10_r429/pywws/Process.py /home/bagpuss/www/sites/glasgownet.com/weather/data/
echo "Processing complete"
echo "Posting to weather underground"
python $pywws/pywws/ToUnderground.py -vv $pywwsdata/data/
echo "Generating 24 hour windrose"
python $pywws/pywws/WindRose.py $pywwsdata/data/ /tmp/weather/ $pywwsdata/graph_templates/rose_24hrs.png.xml $pywwsdata/windrose_24hrs.png
echo "Generating 7 day windrose"
python $pywws/pywws/WindRose.py $pywwsdata/data/ /tmp/weather/ $pywwsdata/graph_templates/rose_7days_nights.png.xml $pywwsdata/windrose_7days.png
echo "Generating 24 hour plot"
python $pywws/pywws/Plot.py $pywwsdata/data/ /tmp/weather/ $pywwsdata/graph_templates/24hrs.png.xml $pywwsdata/24hrs.png
echo "Generating 24 hour full feature plot"
python $pywws/pywws/Plot.py $pywwsdata/data/ /tmp/weather/ $pywwsdata/graph_templates/24hrs_full_features.png.xml $pywwsdata/24hrs_full.png
echo "Generating 7 days plot"
python $pywws/pywws/Plot.py $pywwsdata/data/ /tmp/weather/ $pywwsdata/graph_templates/7days.png.xml $pywwsdata/7days.png
echo "Generating 28 day plot"
python $pywws/pywws/Plot.py $pywwsdata/data/ /tmp/weather/ $pywwsdata/graph_templates/28days.png.xml $pywwsdata/28days.png

echo "Updating yearly rainfall chart"
python $pywws/pywws/Plot.py $pywwsdata/data/ /tmp/weather/ $pywwsdata/graph_templates/`date +%G`.png.xml $pywwsdata/`date +%G`.png
echo "Creating forecast"
python $pywws/pywws/Forecast.py $pywwsdata/data/ > $pywwsdata/forecast.txt
echo "Done"

