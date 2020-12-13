#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# GENERAL

function add_system_user_to_groups () {
    local USER_NAME="$1"
    local USER_GROUPS_CSV="$2"
    FAILURE_COUNT=0
    SUCCESS_COUNT=0
    for system_group in `echo $USER_GROUPS_CSV | tr ',' ' '`; do
        add_system_user_to_group "$USER_NAME" "$system_group"
        if [ $? -ne 0 ]; then
            FAILURE_COUNT=$((FAILURE_COUNT + 1))
            warning_msg "Something went wrong."\
                "Could not add ${BLUE}`hostname`${RESET}"\
                "user ${RED}$USER_NAME${RESET}"\
                "to group ${RED}$system_group${RESET}."
        else
            SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
            ok_msg "Successfully added ${BLUE}`hostname`${RESET}"\
                "user ${GREEN}$USER_NAME${RESET}"\
                "to group ${GREEN}$system_group${RESET}."
        fi
    done
    if [ $SUCCESS_COUNT -eq 0 ]; then
        nok_msg "Something went wrong."\
            "Could not add ${BLUE}`hostname`${RESET}"\
            "user ${RED}$USER_NAME${RESET}"\
            "to groups ${RED}`echo $USER_GROUPS_CSV | sed 's/,/, /g'`${RESET}."
    elif [ $FAILURE_COUNT -ne 0 ]; then
        warning_msg "Added ${BLUE}`hostname`${RESET}"\
            "user ${GREEN}$USER_NAME${RESET}"\
            "to groups ${GREEN}`echo $USER_GROUPS_CSV | sed 's/,/, /g'`${RESET}"\
            "with (${RED}$FAILURE_COUNT${RESET}) failures."
    fi
    done_msg "Added ${BLUE}`hostname`${RESET} user ${GREEN}$USER_NAME${RESET}"\
        "to (${GREEN}$SUCCESS_COUNT${RESET}) groups,"\
        "(${RED}$FAILURE_COUNT${RESET}) failures."
    return 0
}

function add_system_user_to_group () {
    local USER_NAME="$1"
    local GROUP_NAME="$2"
    symbol_msg "${GREEN}+${RESET}" "Adding user ${YELLOW}$USER_NAME${RESET}"\
        "to group ${YELLOW}$GROUP_NAME${RESET}..."
    usermod -a -G $GROUP_NAME $USER_NAME
    return $?
}

function terraform_machine_system_users () {
    info_msg "Terraforming ${BLUE}`hostname`${RESET} system users..."
    action_inspect_loaded_users; echo
    FAILURE_COUNT=0
    SUCCESS_COUNT=0
    for system_user in ${HB_TERRAFORM['users']}; do
        create_system_user "$system_user"
        if [ $? -ne 0 ]; then
            FAILURE_COUNT=$((FAILURE_COUNT + 1))
            warning_msg "Something went wrong."\
                "Could not create ${BLUE}`hostname`${RESET}"\
                "system user ${RED}$system_user${RESET}."
        else
            SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
            ok_msg "Successfully created system user"\
                "${GREEN}$system_user${RESET}."
        fi
    done
    done_msg "(${GREEN}$SUCCESS_COUNT${RESET}) ${BLUE}`hostname`${RESET}"\
        "system users created, (${RED}$FAILURE_COUNT${RESET}) failures."
    return 0
}

function terraform_machine_system_groups () {
    info_msg "Terraforming ${BLUE}`hostname`${RESET} system groups..."
    action_inspect_loaded_groups; echo
    FAILURE_COUNT=0
    SUCCESS_COUNT=0
    for system_group in ${HB_TERRAFORM['groups']}; do
        create_system_group "$system_group"
        if [ $? -ne 0 ]; then
            FAILURE_COUNT=$((FAILURE_COUNT + 1))
            warning_msg "Something went wrong."\
                "Could not create ${BLUE}`hostname`${RESET}"\
                "system group ${RED}$system_group${RESET}."
        else
            SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
            ok_msg "Successfully created system group"\
                "${GREEN}$system_group${RESET}."
        fi
    done
    done_msg "(${GREEN}$SUCCESS_COUNT${RESET}) ${BLUE}`hostname`${RESET}"\
        "system users created, (${RED}$FAILURE_COUNT${RESET}) failures."
    return 0
}

function terraform_machine_mapped_user_groups () {
    info_msg "Terraforming ${BLUE}`hostname`${RESET} user groups map..."
    action_inspect_loaded_mapped_user_groups; echo
    FAILURE_COUNT=0
    SUCCESS_COUNT=0
    debug_msg "Mapped user groups: ${HB_TERRAFORM['user-groups']}"
    for user_group_map in ${HB_TERRAFORM['user-groups']}; do
        local SYSTEM_USER=`fetch_system_user_from_user_group_map "$user_group_map"`
        local USER_GROUPS=`fetch_user_groups_csv_from_user_group_map "$user_group_map"`
        debug_msg "Adding system user $SYSTEM_USER to groups $USER_GROUPS."
        add_system_user_to_groups "$SYSTEM_USER" "$USER_GROUPS"
        if [ $? -ne 0 ]; then
            FAILURE_COUNT=$((FAILURE_COUNT + 1))
            warning_msg "Something went wrong."\
                "Could not add ${BLUE}`hostname`${RESET} system user"\
                "${RED}$SYSTEM_USER${RESET} to groups"\
                "${RED}$USER_GROUPS${RESET}."
        else
            SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
            ok_msg "Successfully added system user"\
                "${GREEN}$SYSTEM_USER${RESET} to groups"\
                "${GREEN}$USER_GROUPS${RESET}."
        fi
    done
    done_msg "(${GREEN}$SUCCESS_COUNT${RESET}) ${BLUE}`hostname`${RESET}"\
        "system users mapped to groups,"\
        "(${RED}$FAILURE_COUNT${RESET}) failures."
    return 0
}

function terraform_machine_directory_structure () {
    info_msg "Terraforming ${BLUE}`hostname`${RESET} directory structure..."
    action_inspect_loaded_directories; echo
    FAILURE_COUNT=0
    SUCCESS_COUNT=0
    for directory_path in ${HB_TERRAFORM['directory-paths']}; do
        create_directory "$directory_path"
        if [ $? -ne 0 ]; then
            FAILURE_COUNT=$((FAILURE_COUNT + 1))
            warning_msg "Something went wrong."\
                "Could not create ${BLUE}`hostname`${RESET} directory"\
                "${RED}$directory_path${RESET}."
        else
            SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
            ok_msg "Successfully created ${BLUE}`hostname`${RESET} directory"\
                "${GREEN}$directory_path${RESET}."
        fi
    done
    done_msg "(${GREEN}$SUCCESS_COUNT${RESET}) ${BLUE}`hostname`${RESET}"\
        "directories created,"\
        "(${RED}$FAILURE_COUNT${RESET}) failures."
    return 0
}

function terraform_machine_file_structure () {
    info_msg "Terraforming ${BLUE}`hostname`${RESET} file structure..."
    action_inspect_loaded_files; echo
    FAILURE_COUNT=0
    SUCCESS_COUNT=0
    for file_path in ${HB_TERRAFORM['file-paths']}; do
        create_file "$file_path"
        if [ $? -ne 0 ]; then
            FAILURE_COUNT=$((FAILURE_COUNT + 1))
            warning_msg "Something went wrong."\
                "Could not create ${BLUE}`hostname`${RESET} file"\
                "${RED}$file_path{RESET}."
        else
            SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
            ok_msg "Successfully created ${BLUE}`hostname`${RESET} file"\
                "${GREEN}$file_path${RESET}."
        fi
    done
    done_msg "(${GREEN}$SUCCESS_COUNT${RESET}) ${BLUE}`hostname`${RESET}"\
        "files created,"\
        "(${RED}$FAILURE_COUNT${RESET}) failures."
    return 0
}

function terraform_machine_symbolic_links () {
    info_msg "Terraforming ${BLUE}`hostname`${RESET} symbolic link structure..."
    action_inspect_loaded_symlinks; echo
    FAILURE_COUNT=0
    SUCCESS_COUNT=0
    for symbolic_link in ${HB_TERRAFORM['symlink-paths']}; do
        SRC_PATH=`fetch_symbolic_link_source_path_from_map "$symbolic_link"`
        DST_PATH=`fetch_symbolic_link_destination_path_from_map "$symbolic_link"`
        create_symbolic_link "$SRC_PATH" "$DST_PATH"
        if [ $? -ne 0 ]; then
            FAILURE_COUNT=$((FAILURE_COUNT + 1))
            warning_msg "Something went wrong. Could not create symbolic link"\
                "between ${RED}$SRC_PATH${RESET} and ${RED}$DST_PATH${RESET}."
        else
            SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
            ok_msg "Successfully created symbolic link between"\
                "${GREEN}$SRC_PATH${RESET} and ${GREEN}$DST_PATH${RESET}."
        fi
    done
    done_msg "(${GREEN}$SUCCESS_COUNT${RESET}) ${BLUE}`hostname`${RESET}"\
        "symbolic links created,"\
        "(${RED}$FAILURE_COUNT${RESET}) failures."
    return 0
}

function three_second_delay () {
    for item in `seq 3`; do echo -n '.'; sleep 1; done
    return 0
}

