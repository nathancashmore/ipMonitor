#!/bin/bash

zoneID=$1
slackURL=$2

echo "AWS Zone ID : $zoneID"
echo "Slack URL : $slackURL"

validIPRegEx='^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$'
currentIP=`curl 'https://api.ipify.org'`
lastIP=`cat ip.data`
now=$(date +"%Y-%m-%d--%H-%M")
rsFilename=record-set-${now}.json

if [[ $currentIP =~ $validIPRegEx ]]; then
  echo "IP returned is valid"
else
  echo "IP returned is NOT valid ... exiting."
  exit 0;
fi

echo "IP currently set to $currentIP"
echo "Last know IP address was $lastIP"

if [[ $currentIP != $lastIP ]]; then
	echo "IP addresses do not match... requesting change to new IP address $currentIP"

	cat record-set.tmpl | sed "s/{{IP}}/$currentIP/g" > ${rsFilename}
	request=`aws route53 change-resource-record-sets --hosted-zone-id $zoneID --change-batch file://${rsFilename}`
	requestId=`echo $request|jq .ChangeInfo.Id`

	echo $request
	echo $currentIP > ip.data
	
	echo "Sending message to Slack"
	message="IP address changed from $lastIP to $currentIP"
	curl -X POST -H 'Content-type: application/json' --data "{'text':'$message'}" $slackURL

	echo "Check the status with:"
	echo "aws route53 get-change --id $requestId"
else 
	echo "IP addresses match, nothing to do."
fi

sleep 5s