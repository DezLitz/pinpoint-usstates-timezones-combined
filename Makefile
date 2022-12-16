download:
	wget https://www2.census.gov/geo/tiger/TIGER2017//STATE/tl_2017_us_state.zip
	wget https://github.com/evansiroky/timezone-boundary-builder/releases/latest/download/timezones-with-oceans.shapefile.zip
	unzip tl_2017_us_state.zip
	unzip timezones-with-oceans.shapefile.zip

install:
	npm install -g --silent geobuf
	go install github.com/deslittle/pinpoint/cmd/geojson2locpb@v0.3.1
	go install github.com/deslittle/pinpoint/cmd/reducelocpb@v0.3.1
	go install github.com/deslittle/pinpoint/cmd/compresslocpb@v0.3.1
	go install github.com/deslittle/pinpoint/cmd/preindexlocpb@v0.3.1
	go install github.com/deslittle/pinpoint/cmd/namegeojson@v0.3.1
	go install github.com/deslittle/pinpoint/cmd/combinegeojson@v0.3.1
	go install github.com/deslittle/pinpoint/cmd/filtergeojson@v0.3.1

gen: clean install download
	shp2geobuf tl_2017_us_state.shp > us-states.pbf
	shp2geobuf combined-shapefile-with-oceans.shp > timezones.pbf
	geobuf2json timezones.pbf > timezones-allprops.json
	geobuf2json us-states.pbf > us-states-allprops.json
	namegeojson timezones-allprops.json timezones.json tzid
	namegeojson us-states-allprops.json us-states.json STATEFP
	filtergeojson timezones.json timezones-filtered.json "America/New_York" "America/Chicago" "America/Denver" "America/Los_Angeles" "America/Anchorage" "America/Adak" "Pacific/Honolulu"
	filtergeojson us-states.json us-states-filtered.json "34" "42" "18"
	combinegeojson us-states-timezones.json us-states-filtered.json timezones-filtered.json
	geojson2locpb us-states-timezones.json
	reducelocpb us-states-timezones.pb
	compresslocpb us-states-timezones.reduce.pb
	preindexlocpb us-states-timezones.reduce.pb

clean:
	rm -f *.zip tl_2017*.*  *-with-oceans*.* *.json *.pbf
