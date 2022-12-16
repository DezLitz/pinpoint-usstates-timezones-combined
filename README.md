# [pinpoint](https://github.com/deslittle/pinpoint)'s preprocessed combined US States and Timezone location data


## Update Data Steps

1. Run:

   ```bash
   # Install cli tools
   make install
   # Produce new data
   make gen
   # Remove intermediate files
   make clean
   # stage
   git add -A
   # commit
   git commit -m "bump to xxx"
   git push
   ```

## Refer

- Protocol Buffers define: <https://github.com/deslittle/pinpoint/blob/main/pb/locinfo.proto>
Usage:

- Go: <https://github.com/deslittle/pinpoint>
