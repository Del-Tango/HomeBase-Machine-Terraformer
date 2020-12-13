#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# FETCHERS

function fetch_multiline_data_from_user () {
    if [ -z "${MD_DEFAULT['file-editor']}" ]; then
        error_msg "No ${RED}$SCRIPT_NAME${RESET} default file editor found."
        return 1
    fi
    ${MD_DEFAULT['file-editor']} ${MD_DEFAULT['tmp-file']}
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        warning_msg "Something went wrong."\
            "Could not fetch multiline data from user."
    fi
    check_file_empty "${MD_DEFAULT['tmp-file']}"
    if [ $? -eq 0 ]; then
        warning_msg "No data input from user."\
            "File ${RED}${MD_DEFAULT['tmp-file']}${RESET} is empty."
        return 2
    fi
#   cat ${MD_DEFAULT['tmp-file']}
    return $EXIT_CODE
}

function fetch_system_user_from_user_group_map () {
    # [ EXAMPLE ]: UserName:group1,group2,group3...
    local USER_GROUP_MAP="$1"
    SYSTEM_USER=`echo "$USER_GROUP_MAP" | cut -d ':' -f 1`
    if [ -z "$SYSTEM_USER" ]; then
        warning_msg "Could not fetch any system user from given map"\
            "${RED}$USER_GROUP_MAP${RESET}."
        return 1
    fi
    echo "$SYSTEM_USER"
    return 0
}

function fetch_user_groups_csv_from_user_group_map () {
    # [ EXAMPLE ]: UserName:group1,group2,group3...
    local USER_GROUP_MAP="$1"
    USER_GROUPS=`echo "$USER_GROUP_MAP" | cut -d ':' -f 2`
    if [ -z "$USER_GROUPS" ]; then
        warning_msg "Could not fetch any system user grous from given map"\
            "${RED}$USER_GROUP_MAP${RESET}."
        return 1
    fi
    echo "$USER_GROUPS"
    return 0
}

function fetch_symbolic_link_source_path_from_map () {
    # [ EXAMPLE ]: Source/Directory/Path:Destination/Directory/Path
    local SYMLINK_MAP="$1"
    SRC_PATH=`echo "$SYMLINK_MAP" | cut -d ':' -f 1`
    if [ -z "$SRC_PATH" ]; then
        warning_msg "Could not fetch source path from given symlink map"\
            "${RED}$SYMLINK_MAP${RESET}."
        return 1
    fi
    echo "$SRC_PATH"
    return 0
}

function fetch_symbolic_link_destination_path_from_map () {
    # [ EXAMPLE ]: Source/Directory/Path:Destination/Directory/Path
    local SYMLINK_MAP="$1"
    DST_PATH=`echo "$SYMLINK_MAP" | cut -d ':' -f 2`
    if [ -z "$DST_PATH" ]; then
        warning_msg "Could not fetch destination path from given symlink map"\
            "${RED}$SYMLINK_MAP${RESET}."
        return 1
    fi
    echo "$DST_PATH"
    return 0
}


