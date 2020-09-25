#!/bin/bash

project=$1
tag=$2

if [ "${project}" == "${tag}" ]; then
    exit 0    
else
    exit 1
fi