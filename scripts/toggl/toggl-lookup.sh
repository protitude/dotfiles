#!/bin/bash

if [ ! -f ~/Documents/dotfiles/scripts/toggl/projects.json ]; then
  echo "Fetching projects..."
  curl -u $TOGGL_API:api_token \
    -H "Content-Type: application/json" \
    -X GET https://api.track.toggl.com/api/v9/workspaces/$TOGGL_WORKSPACE/projects > ~/Documents/dotfiles/scripts/toggl/projects.json
fi

project_name=$1
project_id=$(jq -r ".[] | select(.name == \"$project_name\") | .id" ~/Documents/dotfiles/scripts/toggl/projects.json)

day=$2
if [ -z "$day" ]; then
  day=$(date "+%d")
fi

month=$3
if [ -z "$month" ]; then
  month=$(date "+%m")
fi

year=$4
if [ -z "$year" ]; then
  year=$(date "+%Y")
fi

next_day=$(($day + 1))

# Add leading zero if needed
if [ $next_day -lt 10 ]; then
  next_day="0$next_day"
fi

if [ -z "$project_id" ]; then
  echo "Project not found"
  exit 1
fi

tasks=$(curl -u $TOGGL_API:api_token \
  -H "Content-Type: application/json" \
  -X GET "https://api.track.toggl.com/api/v9/me/time_entries?start_date=$year-$month-$day&end_date=$year-$month-$next_day" | jq -r "map(select(.project_id == $project_id) | .description) | unique | join(\", \")")

if [ -z "$tasks" ]; then
  echo "No tasks found for $project_name on $year-$month-$day"
  exit 1
fi

echo "$tasks" | pbcopy

echo "📋 Tasks copied to clipboard 📋"
