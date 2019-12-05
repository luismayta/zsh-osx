#!/usr/bin/env ksh

# this is an edited version of the script at https://gist.github.com/brandonb927/3195465

# Set the colours you can use
CLEAR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHT_GREEN='\033[1;32m'
YELLOW='\033[0;33m'

message_warning(){
    printf "${CLEAR}${YELLOW}Warning: %s ${CLEAR}\n" "$1";
}

message_success(){
    printf "${CLEAR}${GREEN}Success: %s ${CLEAR}\n" "$1";
}

message_info(){
    printf "${CLEAR}${LIGHT_GREEN}Info: %s ${CLEAR}\n" "$1";
}

message_error(){
    printf "${CLEAR}${RED}Error: %s ${CLEAR}\n" "$1" >&2; exit 1;
}