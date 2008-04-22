#!/bin/sh

log_output=""
log () {
  log_output="$log_output
$1"
}

append_path () {
  input="$1"
  value="$2"
  if ! echo $input | /usr/bin/egrep -q "(^|:)$value($|:)" ; then
     if [ "$3" = "after" ] ; then
        echo $input:$value
     else
        echo $value:$input
     fi
  else
    echo $input
  fi
}

append_plist_var() {
  name="$1"
  append_value="$2"
  default_value="$3"
  current_value="`defaults read ~/.MacOSX/environment ${name}`"
  [ ! "$current_value" ] && current_value="$default_value"
  new_value="`append_path "$current_value" "$append_value" after`"
  defaults write ~/.MacOSX/environment "$name" "$new_value"
  if [ "$current_value" == "$new_value" ]; then
    log "No change to $name in ~/.MacOSX/environment.plist"
  else
    log "Variable $name in ~/.MacOSX/environment.plist changed from '$current_value' to '$new_value'"
  fi
}

append_variable_setter_to_file_unless_exists() {
  target_file=$1
  variable=$2
  value=$3
  
  if [ ! "`cat $target_file | egrep "^export ${variable}" | grep "${value}"`" ]; then
    echo "
export ${variable}=${value}:\$${variable}" >> $target_file
    log "Added $value to $variable in $target_file"
  else
    log "$target_file already has $value in $variable... skipping"
  fi
}

append_plist_var PATH "/usr/local/git/bin" "/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/opt/local/bin"
append_plist_var MANPATH "/usr/local/git/man" "/usr/local/man:/usr/share/man:/usr/local/share/man:/usr/X11/man"

cd ~

[ ! -f .bash_profile ] && [ ! -f .profile ] && touch .bash_profile

for file in .bash_profile .profile; do
  if [ -f $file ]; then
    append_variable_setter_to_file_unless_exists $file PATH /usr/local/git/bin
    append_variable_setter_to_file_unless_exists $file MANPATH /usr/local/git/man;
  fi
done
osascript -e "tell application \"Finder\"" -e "activate" -e "display dialog \"$log_output\"" -e "end tell"