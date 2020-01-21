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

clone_recursive_all_repo()
{
group_folder=$1
group_id=$2
relative_path=${3:-'.'}
echo "mkdir -p $relative_path/$group_folder"
#list_project $group_id
}

generate_folder_tree_from_groups()
{
relative_path=${1:-'.'}
list_groups|while read line
do
folder=`echo $line|sed s+https://gitlab.com/groups/++`
clone_recursive_all_repo $folder $folder $relative_path
done
}

generate_folder_tree_from_groups
#list_subgroups 1179730
#.[] |  "\(.web_url) \(.id)"
#clone_recursive_all_repo xp-coast/il-sole-24-ore 6031671
