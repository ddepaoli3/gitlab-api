#!/bin/bash

TOKEN=${TOKEN:-''}

if [[ $TOKEN == '' ]]
then
echo "Call this script passing token in this way:"
echo "TOKEN=<your_token> $0"
exit -1
fi

list_subgroups()
{
group=$1
echo "Lista gruppi sotto xp-coast"
curl "https://gitlab.com/api/v4/groups/$group/subgroups?private_token=$TOKEN&per_page=999"|json_pp|jq '.[].web_url'
}

list_groups()
{
echo "Lista gruppi "
curl "https://gitlab.com/api/v4/groups?private_token=$TOKEN&per_page=999"|json_pp|jq '.[].web_url'
}

list_subgroups 1179730