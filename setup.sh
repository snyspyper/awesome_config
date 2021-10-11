#! /bin/bash
VERSION="V0.3.1"
FOLDER="/home/$USER/.config/awesome"
CFG="$(pwd)/awesome"

while [ -n "$1" ]
do
    case $1 in
        "help"|"--help")
            echo -ne "\
This script manages config files of Awesome wm.\n\
./setup.sh [OPTION]\n\

install \t \t copy all configs into home directory\n\
update  \t \t copy all configs from home directory to this folder\n\
info    \t \t watch information about config\n\
"
        ;;

        "install")
            mkdir -p $FOLDER 2> /dev/null
            cp -rv awesome/* -t $FOLDER
            echo $(pwd) > curr_dir
        ;;

        "update")
            cp -urv $FOLDER/*.lua $CFG/
        ;;

        "info")
            echo -ne "\
My Awesome config $VERSION\n\
Contains main cfg rc.lua, theme default\n\
"
        ;;

    esac

    shift
done
