#!C:\Program Files\Git\usr\bin bash

#Functions for the alias
subl() {
	if [ $# -eq 0 ]; then
		open -a 'Sublime Text'
	else
		str="$*"
		open -a 'Sublime Text' "$str"
	fi
}

emulator(){
/Users/riayzahmed/Library/Android/sdk/tools/emulator "$@"
}

get_first_value(){
	stringArray=($@)
	for index in "${!stringArray[@]}"
	do
		if (( index == 0 ))
		then
			firstValue=${stringArray[index]}
		fi
	done
	
	echo "${firstValue}" | sed -e 's/^[ \t]*//'
	#echo "$firstValue" #kinda like returning a value if it is captured by the calling function like this value=$(get_first_value "$@")
}

get_rest_value(){
	stringArray=($@)
	restString=""
	for index in "${!stringArray[@]}"
	do
		if (( index != 0 ))
		then
			restString="$restString ${stringArray[index]}"
		fi
	done

	echo "${restString}" | sed -e 's/^[ \t]*//'
}

checkin_from_project(){
	if [ -d "tasks" ]; then
	  projectName=$(<tasks/projectName.txt)
	  restString=$(get_rest_value "$@")

	  if [ "$restString" != "ignore" ]; then
	  	checkin "$projectName $restString"
	  fi
	fi
}

goto_project_directory () {
	if [ $# -eq 0 ]; then
		cd D:/Projects/WebProject
	else
	  directory=$(get_first_value "$@")
	  cd D:/Projects/WebProject/"$directory"* #star auto completes path
	  
	  checkin_from_project "$@"
	fi
}

goto_server_directory(){
	if [ $# -eq 0 ]; then
		cd /Applications/MAMP/htdocs
	else
	  directory=$(get_first_value "$@")
	  cd "/Applications/MAMP/htdocs/$directory"* #star auto completes path

	  checkin_from_project "$@"
	fi	
}

goto_game_directory(){
	if [ $# -eq 0 ]; then
		cd "D:\\unity project"
	else
	  directory=$(get_first_value "$@")
	  cd "D:\\unity project\\$directory"* #star auto completes path

	fi	
}


set_task(){
	if [ $# -eq 0 ]; then
		echo "Provide a Task Name"
	else
		if [ -d "tasks" ]; then # checks if the directory exists
			task="$*"
			echo "$task" > tasks/taskId.txt
		else
			mkdir tasks
			task="$*"
			echo "$task" > tasks/taskId.txt
		fi
	fi
}

set_project(){
	if [ $# -eq 0 ]; then
		echo "Provide a Project name"
	else
		  if [ -d "tasks" ]; then # checks if the directory exists
		  	echo "Tasks Folder already exists"
		  else
		  	mkdir tasks
			projectName="$*"
			echo "$projectName" > tasks/projectName.txt
			echo "" > tasks/commits.txt
			echo "Tasks $projectName created successfully"
		  fi
	fi	
}

shutdown_now(){
	input="$@"
  	stripedInput="$(echo -e "${input}" | tr -d '[:space:]')"

  	if [ "$stripedInput" != "ignore" ]; then
		checkout
	fi

	osascript -e 'tell application "loginwindow" to «event aevtrsdn»'
}

#-------------------------------------------------------Aliases -----------------------------------------------------

#non-Git related alias
alias cd-p="goto_project_directory $@"
alias cd-s="goto_server_directory $@"
alias cd-g="goto_game_directory $@"
alias edit-alias="code ~/.bash_aliases"
alias edit-git="code ~/.bash_git"
alias generate-apk="./gradlew assembleRelease"
alias rn-ios="react-native run-ios"
alias rn-android="react-native run-android"
alias rn-s="react-native start"
alias rn-s-c="react-native start --reset-cache"
alias clear-p="chmod -R 777 ."
alias adb-time="adb shell su root date $(date +%m%d%H%M%Y.%S)"
alias emulator="emulator $@"
alias emulator-start="emulator -avd $@"
alias emulator-list="emulator -list-avds"
# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
alias ..='cd ..'
alias subl="subl $@"
alias ls='ls -GFh'
# View the current working tree status using the short format
alias gs="git status -s" #git branch -v
alias adb-menu="adb shell input keyevent KEYCODE_MENU"
alias adb-reverse="adb reverse tcp:8081 tcp:8081"
alias webpack-watch="webpack --progress --color --watch"

#project tasks alias
alias set-task="set_task $@"
alias remove-task="rm -f tasks/taskId.txt"
alias set-project="set_project $@"
alias shutdown="shutdown_now"