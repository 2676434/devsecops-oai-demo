#!/bin/bash

#  Update token in secret
#oc delete secret oai-pipeline -n cicd
token=`oc -n oai-basic create token pipeline`
echo Token: $token
oc -n cicd create secret generic oai-pipeline --from-literal pipeline_token=$token --dry-run=client -o yaml | oc replace -f -
#oc -n cicd create secret generic oai-pipeline --from-literal pipeline_token=$token

#TODO update token in Openshift Internal Registry - ACS integration
#token_cicd=`oc -n cicd create token pipeline`
#echo Token-ACS integration--: $token_cicd

#Run Pipeline
echo "Pipeline Run"
oc create -f ./pipeline-oai-run.yaml
