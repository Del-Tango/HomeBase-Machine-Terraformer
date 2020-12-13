#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# ACTIONS

function action_terraform_machine () {
    echo; check_safety_on
    if [ $? -eq 0 ]; then
        warning_msg "${BLUE}$SCRIPT_NAME${RESET} safety is ${GREEN}ON${RESET}."\
            "${RED}`hostname`${RESET} machine is not beeing terraformed."
        return 1
    fi
    info_msg "You are about to terraform ${BLUE}`hostname`${RESET} machine"\
        "to specified state."
    fetch_ultimatum_from_user "Are you sure about this? ${YELLOW}Y/N${RESET}"
    echo; if [ $? -ne 0 ]; then
        info_msg "Aborting action."
        return 2
    fi
    FAILURE_COUNT=0
    SUCCESS_COUNT=0
    terraform_machine_system_users
    if [ $? -ne 0 ]; then
        FAILURE_COUNT=$((FAILURE_COUNT + 1))
    else
        SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
    fi
    terraform_machine_system_groups
    if [ $? -ne 0 ]; then
        FAILURE_COUNT=$((FAILURE_COUNT + 1))
    else
        SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
    fi
    terraform_machine_mapped_user_groups
    if [ $? -ne 0 ]; then
        FAILURE_COUNT=$((FAILURE_COUNT + 1))
    else
        SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
    fi
    terraform_machine_directory_structure
    if [ $? -ne 0 ]; then
        FAILURE_COUNT=$((FAILURE_COUNT + 1))
    else
        SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
    fi
    terraform_machine_file_structure
    if [ $? -ne 0 ]; then
        FAILURE_COUNT=$((FAILURE_COUNT + 1))
    else
        SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
    fi
    terraform_machine_symbolic_links
    if [ $? -ne 0 ]; then
        FAILURE_COUNT=$((FAILURE_COUNT + 1))
    else
        SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
    fi
    if [ $SUCCESS_COUNT -eq 0 ]; then
        nok_msg "${RED}`hostname`${RESET} machine terraforming failed."
        return 3
    elif [ $FAILURE_COUNT -ne 0 ]; then
        warning_msg "${RED}`hostname`${RESET} machine was terraformed"\
            "with (${RED}$FAILURE_COUNT${RESET}) failures."
    fi
    ok_msg "${GREEN}`hostname`${RESET} machine was terraformed successfully."\
        "(${GREEN}$SUCCESS_COUNT${RESET}) subroutine execution success count,"\
        "(${RED}$FAILURE_COUNT${RESET}) failures."
    return 0
}

function action_inspect_loaded_users () {
    debug_msg "Staged users: ${HB_TERRAFORM['users']}"
    echo; if [ -z "${HB_TERRAFORM['users']}" ]; then
        warning_msg "No loaded ${RED}system users${RESET} found."
        return 1
    fi
    COUNT=1
    info_msg "Staged system users...
    "
    for system_user in ${HB_TERRAFORM['users']}; do
        if [ -z "$system_user" ]; then
            continue
        fi
        echo "${WHITE}$COUNT${RESET}) ${YELLOW}$system_user${RESET}"
        COUNT=$((COUNT + 1))
    done
    if [ $COUNT -eq 1 ]; then
        warning_msg "No loaded ${RED}system users${RESET} found."
        return 1
    fi
    return 0
}

function action_inspect_loaded_groups () {
    debug_msg "Staged groups: ${HB_TERRAFORM['groups']}"
    echo; if [ -z "${HB_TERRAFORM['groups']}" ]; then
        warning_msg "No loaded ${RED}system groups${RESET} found."
        return 1
    fi
    COUNT=1
    info_msg "Staged system groups...
    "
    for system_group in ${HB_TERRAFORM['groups']}; do
        if [ -z "$system_group" ]; then
            continue
        fi
        echo "${WHITE}$COUNT${RESET}) ${YELLOW}$system_group${RESET}"
        COUNT=$((COUNT + 1))
    done
    if [ $COUNT -eq 1 ]; then
        warning_msg "No loaded ${RED}system groups${RESET} found."
        return 1
    fi
    return 0
}

function action_inspect_loaded_mapped_user_groups () {
    debug_msg "Staged user groups: ${HB_TERRAFORM['user-groups']}"
    echo; if [ -z "${HB_TERRAFORM['user-groups']}" ]; then
        warning_msg "No loaded ${RED}mapped user groups${RESET} found."
        return 1
    fi
    COUNT=1
    info_msg "Staged user groups...
    "
    for user_groups in ${HB_TERRAFORM['user-groups']}; do
        if [ -z "$user_groups" ]; then
            continue
        fi
        echo "${WHITE}$COUNT${RESET}) ${YELLOW}$user_groups${RESET}"
        COUNT=$((COUNT + 1))
    done
    if [ $COUNT -eq 1 ]; then
        warning_msg "No loaded ${RED}mapped user groups${RESET} found."
        return 1
    fi
    return 0
}

function action_inspect_loaded_symlinks () {
    debug_msg "Staged symbolic links: ${HB_TERRAFORM['symlink-paths']}"
    echo; if [ -z "${HB_TERRAFORM['symlink-paths']}" ]; then
        warning_msg "No loaded ${RED}symlink paths${RESET} found."
        return 1
    fi
    COUNT=1
    info_msg "Staged symbolic link paths...
    "
    for symlink_path in ${HB_TERRAFORM['symlink-paths']}; do
        if [ -z "$symlink_path" ]; then
            continue
        fi
        echo "${WHITE}$COUNT${RESET}) ${YELLOW}$symlink_path${RESET}"
        COUNT=$((COUNT + 1))
    done
    if [ $COUNT -eq 1 ]; then
        warning_msg "No loaded ${RED}symlink paths${RESET} found."
        return 1
    fi
    return 0
}

function action_inspect_loaded_directories () {
    debug_msg "Staged directories: ${HB_TERRAFORM['directory-paths']}"
    echo; if [ -z "${HB_TERRAFORM['directory-paths']}" ]; then
        warning_msg "No loaded ${RED}directory paths${RESET} found."
        return 1
    fi
    COUNT=1
    info_msg "Staged directory paths...
    "
    for directory_path in ${HB_TERRAFORM['directory-paths']}; do
        if [ -z "$directory_path" ]; then
            continue
        fi
        echo "${WHITE}$COUNT${RESET}) ${YELLOW}$directory_path${RESET}"
        COUNT=$((COUNT + 1))
    done
    if [ $COUNT -eq 1 ]; then
        warning_msg "No loaded ${RED}directory paths${RESET} found."
        return 1
    fi
    return 0
}

function action_inspect_loaded_files () {
    debug_msg "Staged files: ${HB_TERRAFORM['file-paths']}"
    echo; if [ -z "${HB_TERRAFORM['file-paths']}" ]; then
        warning_msg "No loaded ${RED}file paths${RESET} found."
        return 1
    fi
    COUNT=1
    info_msg "Staged file paths...
    "
    for file_path in ${HB_TERRAFORM['file-paths']}; do
        if [ -z "$file_path" ]; then
            continue
        fi
        echo "${WHITE}$COUNT${RESET}) ${YELLOW}$file_path${RESET}"
        COUNT=$((COUNT + 1))
    done
    if [ $COUNT -eq 1 ]; then
        warning_msg "No loaded ${RED}file paths${RESET} found."
        return 1
    fi
    return 0
}

function action_clear_log_file () {
    check_file_exists "${MD_DEFAULT['log-file']}"
    echo; if [ $? -ne 0 ]; then
        warning_msg "Log file ${RED}${MD_DEFAULT['log-file']}${RESET}"\
            "not found."
        return 2
    fi
    fetch_ultimatum_from_user "Are you sure about this? ${YELLOW}Y/N${RESET}"
    if [ $? -ne 0 ]; then
        echo; info_msg "Aborting action."
        return 1
    fi
    check_safety_on
    if [ $? -eq 0 ]; then
        echo; warning_msg "Safety is ${GREEN}ON${RESET}."\
            "Log file ${RED}${MD_DEFAULT['log-file']}${RESET}"\
            "will not be cleared."
        return 3
    fi
    echo -n > "${MD_DEFAULT['log-file']}"
    check_file_empty "${MD_DEFAULT['log-file']}"
    if [ $? -ne 0 ]; then
        echo; error_msg "Something went wrong."\
            "Could not clear ${BLUE}$SCRIPT_NAME${RESET}"\
            "log file ${RED}${MD_DEFAULT['log-file']}${RESET}."
        return 4
    fi
    echo; ok_msg "Successfully cleared ${BLUE}$SCRIPT_NAME${RESET}"\
        "log file ${GREEN}${MD_DEFAULT['log-file']}${RESET}."
    return 0
}

function action_display_log_tail () {
    check_file_exists "${MD_DEFAULT['log-file']}"
    echo; if [ $? -ne 0 ]; then
        warning_msg "Log file ${RED}${MD_DEFAULT['log-file']}${RESET}"\
            "not found."
        return 1
    fi
    tail -n ${MD_DEFAULT['log-lines']} ${MD_DEFAULT['log-file']}
    return $?
}

function action_display_log_head () {
    check_file_exists "${MD_DEFAULT['log-file']}"
    echo; if [ $? -ne 0 ]; then
        warning_msg "Log file ${RED}${MD_DEFAULT['log-file']}${RESET}"\
            "not found."
        return 1
    fi
    head -n ${MD_DEFAULT['log-lines']} ${MD_DEFAULT['log-file']}
    return $?
}

function action_display_log_more () {
    check_file_exists "${MD_DEFAULT['log-file']}"
    echo; if [ $? -ne 0 ]; then
        warning_msg "Log file ${RED}${MD_DEFAULT['log-file']}${RESET}"\
            "not found."
        return 1
    fi
    more ${MD_DEFAULT['log-file']}
    return $?
}

function action_set_safety_on () {
    echo; qa_msg "Getting scared, are we?"
    fetch_ultimatum_from_user "${YELLOW}Y/N${RESET}"
    echo; if [ $? -ne 0 ]; then
        info_msg "Aborting action."
    fi
    set_safety 'on'
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set ${BLUE}$SCRIPT_NAME${RESET} safety"\
            "to ${GREEN}ON${RESET}."
    else
        ok_msg "Succesfully set ${BLUE}$SCRIPT_NAME${RESET} safety"\
            "to ${GREEN}ON${RESET}."
    fi
    return $EXIT_CODE
}

function action_set_safety_off () {
    echo; qa_msg "Taking off the training wheels. Are you sure about this?"
    fetch_ultimatum_from_user "${YELLOW}Y/N${RESET}"
    echo; if [ $? -ne 0 ]; then
        info_msg "Aborting action."
    fi
    set_safety 'off'
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set ${BLUE}$SCRIPT_NAME${RESET} safety"\
            "to ${RED}OFF${RESET}."
    else
        ok_msg "Succesfully set ${BLUE}$SCRIPT_NAME${RESET} safety"\
            "to ${RED}OFF${RESET}."
    fi
    return $EXIT_CODE
}

function action_set_log_file () {
    echo; info_msg "Type absolute file path or ${MAGENTA}.back${RESET}."
    while :
    do
        FILE_PATH=`fetch_data_from_user 'FilePath'`
        if [ $? -ne 0 ]; then
            info_msg "Aborting action."
            return 1
        fi
        check_file_exists "$FILE_PATH"
        if [ $? -ne 0 ]; then
            warning_msg "File ${RED}$FILE_PATH${RESET} does not exists."
            echo; continue
        fi; break
    done
    echo; set_log_file "$FILE_PATH"
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set ${RED}$FILE_PATH${RESET} as"\
            "${BLUE}$SCRIPT_NAME${RESET} log file."
    else
        ok_msg "Successfully set ${BLUE}$SCRIPT_NAME${RESET} log file"\
            "${GREEN}$FILE_PATH${RESET}."
    fi
    return $EXIT_CODE
}

function action_set_log_lines () {
    echo; info_msg "Type log line number to display or ${MAGENTA}.back${RESET}."
    while :
    do
        LOG_LINES=`fetch_data_from_user 'LogLines'`
        if [ $? -ne 0 ]; then
            info_msg "Aborting action."
            return 1
        fi
        check_value_is_number $LOG_LINES
        if [ $? -ne 0 ]; then
            warning_msg "LogViewer number of lines requiered,"\
                "not ${RED}$LOG_LINES${RESET}."
            echo; continue
        fi; break
    done
    echo; set_log_lines $LOG_LINES
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set ${BLUE}$SCRIPT_NAME${RESET} default"\
            "${RED}log lines${RESET} to (${RED}$LOG_LINES${RESET})."
    else
        ok_msg "Successfully set ${BLUE}$SCRIPT_NAME${RESET} default"\
            "${GREEN}log lines${RESET} to (${GREEN}$LOG_LINES${RESET})."
    fi
    return $EXIT_CODE
}

function action_add_users_manually () {
    echo; info_msg "Opening ${MAGENTA}${MD_DEFAULT['file-editor']}${RESET}"\
        "for data set input..."
    cat "${HB_EXAMPLES['import-users']}" > ${MD_DEFAULT['tmp-file']}
    fetch_multiline_data_from_user
    if [ $? -ne 0 ]; then
        info_msg "Aborting action."
        return 1
    fi
    MULTILINE_DATA=`cat ${MD_DEFAULT['tmp-file']}`
    echo -n > ${MD_DEFAULT['tmp-file']}
    if [ -z "$MULTILINE_DATA" ]; then
        nok_msg "No ${RED}system users${RESET} found to set."\
            "Aborting action."
        return 1
    fi
    set_terraform_data_set_system_users "$MULTILINE_DATA"
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not load ${RED}system users${RESET} data set"\
            "for machine terraforming."
    else
        HB_IMPORTS['system-users']=''
        ok_msg "Successfully loaded ${GREEN}system users${RESET} data set"\
            "for machine terraforming."
    fi
    return $EXIT_CODE
}

function action_add_groups_manually () {
    echo; info_msg "Opening ${MAGENTA}${MD_DEFAULT['file-editor']}${RESET}"\
        "for data set input..."
    cat "${HB_EXAMPLES['import-groups']}" > ${MD_DEFAULT['tmp-file']}
    fetch_multiline_data_from_user
    if [ $? -ne 0 ]; then
        info_msg "Aborting action."
        return 1
    fi
    MULTILINE_DATA=`cat ${MD_DEFAULT['tmp-file']}`
    echo -n > ${MD_DEFAULT['tmp-file']}
    if [ -z "$MULTILINE_DATA" ]; then
        nok_msg "No ${RED}system groups${RESET} found to set."\
            "Aborting action."
        return 1
    fi
    set_terraform_data_set_system_groups "$MULTILINE_DATA"
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not load ${RED}system groups${RESET} data set"\
            "for machine terraforming."
    else
        HB_IMPORTS['system-groups']=''
        ok_msg "Successfully loaded ${GREEN}system groups${RESET} data set"\
            "for machine terraforming."
    fi
    return $EXIT_CODE
}

function action_add_user_groups_manually () {
    echo; info_msg "Opening ${MAGENTA}${MD_DEFAULT['file-editor']}${RESET}"\
        "for data set input..."
    cat "${HB_EXAMPLES['import-user-groups']}" > ${MD_DEFAULT['tmp-file']}
    fetch_multiline_data_from_user
    if [ $? -ne 0 ]; then
        info_msg "Aborting action."
        return 1
    fi
    MULTILINE_DATA=`cat ${MD_DEFAULT['tmp-file']}`
    echo -n > ${MD_DEFAULT['tmp-file']}
    if [ -z "$MULTILINE_DATA" ]; then
        nok_msg "No ${RED}mapped user groups${RESET} found to set."\
            "Aborting action."
        return 1
    fi
    set_terraform_data_set_mapped_user_groups "$MULTILINE_DATA"
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not load ${RED}mapped user groups${RESET} data set"\
            "for machine terraforming."
    else
        HB_IMPORTS['user-groups']=''
        ok_msg "Successfully loaded ${GREEN}mapped user groups${RESET} data set"\
            "for machine terraforming."
    fi
    return $EXIT_CODE
}

function action_add_directory_paths_manually () {
    echo; info_msg "Opening ${MAGENTA}${MD_DEFAULT['file-editor']}${RESET}"\
        "for data set input..."
    cat "${HB_EXAMPLES['import-directories']}" > ${MD_DEFAULT['tmp-file']}
    fetch_multiline_data_from_user
    if [ $? -ne 0 ]; then
        info_msg "Aborting action."
        return 1
    fi
    MULTILINE_DATA=`cat ${MD_DEFAULT['tmp-file']}`
    echo -n > ${MD_DEFAULT['tmp-file']}
    if [ -z "$MULTILINE_DATA" ]; then
        nok_msg "No ${RED}directory paths${RESET} found to set."\
            "Aborting action."
        return 1
    fi
    set_terraform_data_set_directory_paths "$MULTILINE_DATA"
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not load ${RED}directory${RESET} data set"\
            "for machine terraforming."
    else
        HB_IMPORTS['dir-paths']=''
        ok_msg "Successfully loaded ${GREEN}directory${RESET} data set"\
            "for machine terraforming."
    fi
    return $EXIT_CODE
}

function action_add_file_paths_manually () {
    echo; info_msg "Opening ${MAGENTA}${MD_DEFAULT['file-editor']}${RESET}"\
        "for data set input..."
    cat "${HB_EXAMPLES['import-files']}" > ${MD_DEFAULT['tmp-file']}
    fetch_multiline_data_from_user
    if [ $? -ne 0 ]; then
        info_msg "Aborting action."
        return 1
    fi
    MULTILINE_DATA=`cat ${MD_DEFAULT['tmp-file']}`
    echo -n > ${MD_DEFAULT['tmp-file']}
    if [ -z "$MULTILINE_DATA" ]; then
        nok_msg "No ${RED}file paths${RESET} found to set."\
            "Aborting action."
        return 1
    fi
    set_terraform_data_set_file_paths "$MULTILINE_DATA"
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not load ${RED}file${RESET} data set"\
            "for machine terraforming."
    else
        HB_IMPORTS['file-paths']=''
        ok_msg "Successfully loaded ${GREEN}file${RESET} data set"\
            "for machine terraforming."
    fi
    return $EXIT_CODE
}

function action_add_symbolic_links_manually () {
    echo; info_msg "Opening ${MAGENTA}${MD_DEFAULT['file-editor']}${RESET}"\
        "for data set input..."
    cat "${HB_EXAMPLES['import-symlinks']}" > ${MD_DEFAULT['tmp-file']}
    fetch_multiline_data_from_user
    if [ $? -ne 0 ]; then
        info_msg "Aborting action."
        return 1
    fi
    MULTILINE_DATA=`cat ${MD_DEFAULT['tmp-file']}`
    echo -n > ${MD_DEFAULT['tmp-file']}
    if [ -z "$MULTILINE_DATA" ]; then
        nok_msg "No ${RED}symbolic links${RESET} found to set."\
            "Aborting action."
        return 1
    fi
    set_terraform_data_set_symlink_paths "$MULTILINE_DATA"
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not load ${RED}symlink${RESET} data set"\
            "for machine terraforming."
    else
        HB_IMPORTS['symlink-paths']=''
        ok_msg "Successfully loaded ${GREEN}symlink${RESET} data set"\
            "for machine terraforming."
    fi
    return $EXIT_CODE
}

function action_set_file_editor () {
    echo; info_msg "Type file editor name or ${MAGENTA}.back${RESET}."
    while :
    do
        FILE_EDITOR=`fetch_data_from_user 'Editor'`
        echo; if [ $? -ne 0 ]; then
            info_msg "Aborting action."
            return 1
        fi
        check_util_installed "$FILE_EDITOR"
        if [ $? -ne 0 ]; then
            warning_msg "File editor ${RED}$FILE_EDITOR${RESET} is not installed."
            echo; continue
        fi; break
    done
    set_file_editor "$FILE_EDITOR"
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set ${RED}$FILE_EDITOR${RESET} as"\
            "${BLUE}$SCRIPT_NAME${RESET} default file editor."
    else
        ok_msg "Successfully set default file editor"\
            "${GREEN}$FILE_EDITOR${RESET}."
    fi
    return $EXIT_CODE
}

function action_import_user_file () {
    echo; info_msg "Type absolute file path or ${MAGENTA}.back${RESET}."
    while :
    do
        FILE_PATH=`fetch_data_from_user 'FilePath'`
        echo; if [ $? -ne 0 ]; then
            info_msg "Aborting action."
            return 1
        fi
        check_file_exists "$FILE_PATH"
        if [ $? -ne 0 ]; then
            warning_msg "File ${RED}$FILE_PATH${RESET} does not exists."
            echo; continue
        fi; break
    done
    set_imported_file_path_system_users "$FILE_PATH"
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set ${RED}$FILE_PATH${RESET} as"\
            "${BLUE}$SCRIPT_NAME${RESET} imported system users file."
    else
        set_terraform_data_set_system_users \
            "`cat $FILE_PATH | sed -e '/^$/d' -e '/^#/d'`"
        ok_msg "Successfully set imported system users file"\
            "${GREEN}$FILE_PATH${RESET}."
    fi
    return $EXIT_CODE
}

function action_import_groups_file () {
    echo; info_msg "Type absolute file path or ${MAGENTA}.back${RESET}."
    while :
    do
        FILE_PATH=`fetch_data_from_user 'FilePath'`
        echo; if [ $? -ne 0 ]; then
            info_msg "Aborting action."
            return 1
        fi
        check_file_exists "$FILE_PATH"
        if [ $? -ne 0 ]; then
            warning_msg "File ${RED}$FILE_PATH${RESET} does not exists."
            echo; continue
        fi; break
    done
    set_imported_file_path_system_groups "$FILE_PATH"
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set ${RED}$FILE_PATH${RESET} as"\
            "${BLUE}$SCRIPT_NAME${RESET} imported system groups file."
    else
        set_terraform_data_set_system_groups \
            "`cat $FILE_PATH | sed -e '/^$/d' -e '/^#/d'`"
        ok_msg "Successfully set imported system groups file"\
            "${GREEN}$FILE_PATH${RESET}."
    fi
    return $EXIT_CODE
}

function action_import_user_groups_file () {
    echo; info_msg "Type absolute file path or ${MAGENTA}.back${RESET}."
    while :
    do
        FILE_PATH=`fetch_data_from_user 'FilePath'`
        echo; if [ $? -ne 0 ]; then
            info_msg "Aborting action."
            return 1
        fi
        check_file_exists "$FILE_PATH"
        if [ $? -ne 0 ]; then
            warning_msg "File ${RED}$FILE_PATH${RESET} does not exists."
            echo; continue
        fi; break
    done
    set_imported_file_path_mapped_user_groups "$FILE_PATH"
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set ${RED}$FILE_PATH${RESET} as"\
            "${BLUE}$SCRIPT_NAME${RESET} imported mapped user groups file."
    else
        set_terraform_data_set_mapped_user_groups \
            "`cat $FILE_PATH | sed -e '/^$/d' -e '/^#/d'`"
        ok_msg "Successfully set imported mapped user groups file"\
            "${GREEN}$FILE_PATH${RESET}."
    fi
    return $EXIT_CODE
}

function action_import_directory_paths_file () {
    echo; info_msg "Type absolute file path or ${MAGENTA}.back${RESET}."
    while :
    do
        FILE_PATH=`fetch_data_from_user 'FilePath'`
        echo; if [ $? -ne 0 ]; then
            info_msg "Aborting action."
            return 1
        fi
        check_file_exists "$FILE_PATH"
        if [ $? -ne 0 ]; then
            warning_msg "File ${RED}$FILE_PATH${RESET} does not exists."
            echo; continue
        fi; break
    done
    set_imported_file_path_directories "$FILE_PATH"
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set ${RED}$FILE_PATH${RESET} as"\
            "${BLUE}$SCRIPT_NAME${RESET} imported directory paths file."
    else
        set_terraform_data_set_directory_paths \
            "`cat $FILE_PATH | sed -e '/^$/d' -e '/^#/d'`"
        ok_msg "Successfully set imported directory paths file"\
            "${GREEN}$FILE_PATH${RESET}."
    fi
    return $EXIT_CODE
}

function action_import_file_paths_file () {
    echo; info_msg "Type absolute file path or ${MAGENTA}.back${RESET}."
    while :
    do
        FILE_PATH=`fetch_data_from_user 'FilePath'`
        echo; if [ $? -ne 0 ]; then
            info_msg "Aborting action."
            return 1
        fi
        check_file_exists "$FILE_PATH"
        if [ $? -ne 0 ]; then
            warning_msg "File ${RED}$FILE_PATH${RESET} does not exists."
            echo; continue
        fi; break
    done
    set_imported_file_path_files "$FILE_PATH"
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set ${RED}$FILE_PATH${RESET} as"\
            "${BLUE}$SCRIPT_NAME${RESET} imported file paths file."
    else
        set_terraform_data_set_file_paths \
            "`cat $FILE_PATH | sed -e '/^$/d' -e '/^#/d'`"
        ok_msg "Successfully set imported file paths file"\
            "${GREEN}$FILE_PATH${RESET}."
    fi
    return $EXIT_CODE
}

function action_import_symbolic_links_file () {
    echo; info_msg "Type absolute file path or ${MAGENTA}.back${RESET}."
    while :
    do
        FILE_PATH=`fetch_data_from_user 'FilePath'`
        echo; if [ $? -ne 0 ]; then
            info_msg "Aborting action."
            return 1
        fi
        check_file_exists "$FILE_PATH"
        if [ $? -ne 0 ]; then
            warning_msg "File ${RED}$FILE_PATH${RESET} does not exists."
            echo; continue
        fi; break
    done
    set_imported_file_path_symlinks "$FILE_PATH"
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set ${RED}$FILE_PATH${RESET} as"\
            "${BLUE}$SCRIPT_NAME${RESET} imported symbolic links file."
    else
        set_terraform_data_set_symlink_paths \
            "`cat $FILE_PATH | sed -e '/^$/d' -e '/^#/d'`"
        ok_msg "Successfully set imported symbolic links file"\
            "${GREEN}$FILE_PATH${RESET}."
    fi
    return $EXIT_CODE
}

function action_install_dependencies () {
    fetch_ultimatum_from_user "Are you sure about this? ${YELLOW}Y/N${RESET}"
    if [ $? -ne 0 ]; then
        info_msg "Aborting action."
        return 1
    fi
    apt_install_dependencies
    return $?
}

function action_set_temporary_file () {
    echo; info_msg "Type absolute file path or ${MAGENTA}.back${RESET}."
    while :
    do
        FILE_PATH=`fetch_data_from_user 'FilePath'`
        echo; if [ $? -ne 0 ]; then
            info_msg "Aborting action."
            return 1
        fi
        check_file_exists "$FILE_PATH"
        if [ $? -ne 0 ]; then
            warning_msg "File ${RED}$FILE_PATH${RESET} does not exists."
            echo; continue
        fi; break
    done
    set_temporary_file "$FILE_PATH"
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not set ${RED}$FILE_PATH${RESET} as"\
            "${BLUE}$SCRIPT_NAME${RESET} temporary file."
    else
        ok_msg "Successfully set temporary file ${GREEN}$FILE_PATH${RESET}."
    fi
    return $EXIT_CODE
}


