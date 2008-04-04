#!/bin/sh
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
  defaults write ~/.MacOSX/environment "$name" "`append_path "$current_value" "$append_value" after`"
}

append_variable_setter_to_file_unless_exists() {
  target_file=$1
  variable=$2
  value=$3
  
  if [ ! "`cat $target_file | egrep "^export ${variable}" | grep "${value}"`" ]; then
    echo "
export ${variable}=${value}:\$${variable}" >> $target_file
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
