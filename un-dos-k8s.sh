#!/bin/bash

hit () {
    curl -X PUT 127.0.0.1:8001/apis/apps/v1/namespaces/default/deployments/un-dos-k8s/scale -H "Content-Type: application/json" -d @scaleup.json
    sleep 0.5
    curl -X PUT 127.0.0.1:8001/apis/apps/v1/namespaces/default/deployments/un-dos-k8s/scale -H "Content-Type: application/json" -d @scaledown.json
}

for i in {1..100}; do hit & done