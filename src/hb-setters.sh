#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# SETTERS

function set_owner () {
    local FILE_PATH="$1"
    local USER_NAME="$2"
    chown -R $USER_NAME $FILE_PATH
    return $?
}

function set_permission () {
    local FILE_PATH="$1"
    local PERMISSIONS=$2
    chmod -R $PERMISSIONS $FILE_PATH
    return $?
}

function set_log_file () {
    local FILE_PATH="$1"
    check_file_exists "$FILE_PATH"
    if [ $? -ne 0 ]; then
        error_msg "File ${RED}$FILE_PATH${RESET} does not exist."
        return 1
    fi
    MD_DEFAULT['log-file']="$FILE_PATH"
    return 0
}

function set_log_lines () {
    local LOG_LINES=$1
    if [ -z "$LOG_LINES" ]; then
        error_msg "Log line value ${RED}$LOG_LINES${RESET} is not a number."
        return 1
    fi
    MD_DEFAULT['log-lines']=$LOG_LINES
    return 0
}

function set_terraform_data_set_system_users () {
    local DATA_SET="$1"
    if [ -z "$DATA_SET" ]; then
        error_msg "Empty ${RED}system users${RESET} data set"\
            "for machine terraforming."
        return 1
    fi
    SANITIZED_DATA_SET=`echo "$DATA_SET" | sed -e '/^$/d' -e '/^#/d'`
    debug_msg "Data set sanitized to: $SANITIZED_DATA_SET."
    HB_TERRAFORM['users']="$SANITIZED_DATA_SET"
    return 0
}

function set_terraform_data_set_system_groups () {
    local DATA_SET="$1"
    if [ -z "$DATA_SET" ]; then
        error_msg "Empty ${RED}system groups${RESET} data set"\
            "for machine terraforming."
        return 1
    fi
    SANITIZED_DATA_SET=`echo "$DATA_SET" | sed -e '/^$/d' -e '/^#/d'`
    debug_msg "Data set sanitized to: $SANITIZED_DATA_SET."
    HB_TERRAFORM['groups']="$SANITIZED_DATA_SET"
    return 0
}

function set_terraform_data_set_mapped_user_groups () {
    local DATA_SET="$1"
    if [ -z "$DATA_SET" ]; then
        error_msg "Empty ${RED}mapped user groups${RESET} data set"\
            "for machine terraforming."
        return 1
    fi
    SANITIZED_DATA_SET=`echo "$DATA_SET" | sed -e '/^$/d' -e '/^#/d'`
    debug_msg "Data set sanitized to: $SANITIZED_DATA_SET."
    HB_TERRAFORM['user-groups']="$SANITIZED_DATA_SET"
    return 0
}

function set_terraform_data_set_directory_paths () {
    local DATA_SET="$1"
    if [ -z "$DATA_SET" ]; then
        error_msg "Empty ${RED}directory paths${RESET} data set"\
            "for machine terraforming."
        return 1
    fi
    SANITIZED_DATA_SET=`echo "$DATA_SET" | sed -e '/^$/d' -e '/^#/d'`
    debug_msg "Data set sanitized to: $SANITIZED_DATA_SET."
    HB_TERRAFORM['directory-paths']="$SANITIZED_DATA_SET"
    return 0
}

function set_terraform_data_set_file_paths () {
    local DATA_SET="$1"
    if [ -z "$DATA_SET" ]; then
        error_msg "Empty ${RED}file paths${RESET} data set"\
            "for machine terraforming."
        return 1
    fi
    SANITIZED_DATA_SET=`echo "$DATA_SET" | sed -e '/^$/d' -e '/^#/d'`
    debug_msg "Data set sanitized to: $SANITIZED_DATA_SET."
    HB_TERRAFORM['file-paths']="$SANITIZED_DATA_SET"
    return 0
}

function set_terraform_data_set_symlink_paths () {
    local DATA_SET="$1"
    if [ -z "$DATA_SET" ]; then
        error_msg "Empty ${RED}symlink paths${RESET} data set"\
            "for machine terraforming."
        return 1
    fi
    SANITIZED_DATA_SET=`echo "$DATA_SET" | sed -e '/^$/d' -e '/^#/d'`
    debug_msg "Data set sanitized to: $SANITIZED_DATA_SET."
    HB_TERRAFORM['symlink-paths']="$SANITIZED_DATA_SET"
    return 0
}

function set_imported_file_path_system_users () {
    local FILE_PATH="$1"
    check_file_exists "$FILE_PATH"
    if [ $? -ne 0 ]; then
        error_msg "File ${RED}$FILE_PATH${RESET} does not exist."
        return 1
    fi
    HB_IMPORTS['system-users']="$FILE_PATH"
    return 0
}

function set_imported_file_path_system_groups () {
    local FILE_PATH="$1"
    check_file_exists "$FILE_PATH"
    if [ $? -ne 0 ]; then
        error_msg "File ${RED}$FILE_PATH${RESET} does not exist."
        return 1
    fi
    HB_IMPORTS['system-groups']="$FILE_PATH"
    return 0
}

function set_imported_file_path_mapped_user_groups () {
    local FILE_PATH="$1"
    check_file_exists "$FILE_PATH"
    if [ $? -ne 0 ]; then
        error_msg "File ${RED}$FILE_PATH${RESET} does not exist."
        return 1
    fi
    HB_IMPORTS['user-groups']="$FILE_PATH"
    return 0
}

function set_imported_file_path_directories () {
    local FILE_PATH="$1"
    check_file_exists "$FILE_PATH"
    if [ $? -ne 0 ]; then
        error_msg "File ${RED}$FILE_PATH${RESET} does not exist."
        return 1
    fi
    HB_IMPORTS['dir-paths']="$FILE_PATH"
    return 0
}

function set_imported_file_path_files () {
    local FILE_PATH="$1"
    check_file_exists "$FILE_PATH"
    if [ $? -ne 0 ]; then
        error_msg "File ${RED}$FILE_PATH${RESET} does not exist."
        return 1
    fi
    HB_IMPORTS['file-paths']="$FILE_PATH"
    return 0
}

function set_imported_file_path_symlinks () {
    local FILE_PATH="$1"
    check_file_exists "$FILE_PATH"
    if [ $? -ne 0 ]; then
        error_msg "File ${RED}$FILE_PATH${RESET} does not exist."
        return 1
    fi
    HB_IMPORTS['symlink-paths']="$FILE_PATH"
    return 0
}
