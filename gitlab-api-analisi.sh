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
echo "Groups under group $group"
curl "https://gitlab.com/api/v4/groups/$group/subgroups?private_token=$TOKEN&per_page=999"|json_pp|jq '.[].web_url'
}

list_groups()
{
echo "Group list"
curl "https://gitlab.com/api/v4/groups?private_token=$TOKEN&per_page=999"|json_pp| jq -r '.[] | "\(.web_url) \(.id)"'
}

list_project()
{
group_id=$1
curl "https://gitlab.com/api/v4/groups/$group_id/projects?private_token=$TOKEN&per_page=999"|json_pp|jq '.[].web_url'
}

generate_folder_tree_from_groups()
{
relative_path=${1:-'.'}
list_groups|while read line
do
folder=`echo $line|sed s+https://gitlab.com/groups/++ | awk {'print $1'}`
group_id=`echo $line | awk {'print $2'}`
echo mkdir -p $relative_path/$folder
done
}

generate_folder_tree_from_groups ~/workspace-gitlab-clone
#list_subgroups 1179730
#.[] |  "\(.web_url) \(.id)"
