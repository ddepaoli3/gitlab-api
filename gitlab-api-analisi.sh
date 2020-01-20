#!/bin/bash

TOKEN=''

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