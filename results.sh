#!/bin/bash

NAME=$1
CODE=$2
DOB=$3


echo "${NAME}"; 

while [ 0 ];
do 
  OUTPUT=$(curl -s 'https://securelink.labmed.uw.edu/result' \
  -H 'authority: securelink.labmed.uw.edu'   -H 'pragma: no-cache'   \
  -H 'cache-control: no-cache'   -H 'upgrade-insecure-requests: 1'   \
  -H 'origin: https://securelink.labmed.uw.edu'   \
  -H 'content-type: application/x-www-form-urlencoded'   \
  -H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36'   \
  -H 'accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9'   \
  -H 'sec-fetch-site: same-origin'   -H 'sec-fetch-mode: navigate'   \
  -H 'sec-fetch-user: ?1'   -H 'sec-fetch-dest: document'   \
  -H 'referer: https://securelink.labmed.uw.edu/?code=2WMSTX3XVT4U4FPA'   \
  -H 'accept-language: en-US,en;q=0.9'   \
  -H 'cookie: __cfduid=df3d0164f416357e6ed42f515eb50e0f01599365020; _ga=GA1.2.838419185.1599365021; _fbp=fb.1.1599365021110.138763706; _gid=GA1.2.293463928.1600743098; _gat=1'   \
  -H 'dnt: 1'   \
  --data-raw "barcode=${CODE}&dob=${DOB}" --compressed )

  echo $OUTPUT > ${NAME}_result.html

  if [ $(echo $OUTPUT | grep -o "Awaiting result" | wc -l) -ne 2 ] && [ $(echo $OUTPUT | grep -c "Redirecting") -ne 1 ] && \
    [ $(echo $OUTPUT | grep -ic "processing") -ne 1 ] ; then  
    echo -ne "\n\007Change found for ${NAME}: https://securelink.labmed.uw.edu/?code=${CODE}&dob=${DOB}\n"; 
  else echo -ne '.'; 
    fi; 
    sleep 600; 
done
