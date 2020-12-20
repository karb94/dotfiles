#!/bin/bash
cwd=$(echo $(dirname $0))

scripts_folder="$HOME/.local/scripts"
scripts_file_name=miscellaneous.json
scripts_file_path=${scripts_folder}/${scripts_file_name}
# Use ~/.myrmidon-tasks.json as default, otherwise use incoming path
test [ -f "$scripts_file_path" ] ||
    ( echo "no $scripts_file_name found in $scripts_folder" 1>&2 && exit 1 )

config_file="${1:-"$HOME/.myrmidon-tasks.json"}"
tasks=$(cat $config_file)

# Pass tasks to rofi, and get the output as the selected option
selected=$(echo $tasks | jq -j 'map(.name) | join("\n")' | rofi -dmenu -matching fuzzy -i -p "Search tasks")
task=$(echo $tasks | jq ".[] | select(.name == \"$selected\")")

# Exit if no task was found
if [[ $task == "" ]]; then
    echo "No task defined as '$selected' within config file."
    exit 1
fi

task_command=$(echo $task | jq ".command")
confirm=$(echo $task | jq ".confirm")

# Check whether we need confirmation to run this task
if [[ $confirm == "true" ]]; then
    # Chain the confirm command before executing the selected command
    confirm_script="$cwd/confirm.sh 'Confirm $selected?'"
    eval "$confirm_script && \"$task_command\" > /dev/null &"
else
    eval "\"$task_command\" > /dev/null &"
fi
