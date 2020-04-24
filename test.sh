#!/bin/bash

aws s3 sync ci s3://mypublicfiles1/qs-workshop/ci/ --delete --acl public-read
aws s3 sync submodules s3://mypublicfiles1/qs-workshop/submodules/ --delete --acl public-read
aws s3 sync templates s3://mypublicfiles1/qs-workshop/templates/ --delete --acl public-read

aws cloudformation create-stack --stack-name test \
    --capabilities CAPABILITY_IAM \
    --template-url https://s3.amazonaws.com/mypublicfiles1/qs-workshop/templates/master.template.yaml \
    --parameters ParameterKey=KeyPairName,ParameterValue=qsworkshop \
                 ParameterKey=RemoteAccessCIDR,ParameterValue=0.0.0.0/0 \
                 ParameterKey=WebserverCIDR,ParameterValue=0.0.0.0/0 \
                 ParameterKey=EmailAddress,ParameterValue=egarcia@progress.com \
		 "ParameterKey=AvailabilityZones,ParameterValue='us-west-2a,us-west-2b'" 

