#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# HOME BASE

function load_home_base_logging_levels () {
    if [ ${#HB_LOGGING_LEVELS[@]} -eq 0 ]; then
        warning_msg "No ${BLUE}$SCRIPT_NAME${RESET} logging levels found."
        return 1
    fi
    MD_LOGGING_LEVELS=( ${HB_LOGGING_LEVELS[@]} )
    ok_msg "Successfully loaded ${BLUE}$SCRIPT_NAME${RESET} logging levels."
    return 0
}

function load_settings_home_base_default () {
    if [ ${#HB_DEFAULT[@]} -eq 0 ]; then
        warning_msg "No ${BLUE}$SCRIPT_NAME${RESET} defaults found."
        return 1
    fi
    for hb_setting in ${!HB_DEFAULT[@]}; do
        MD_DEFAULT[$hb_setting]=${HB_DEFAULT[$hb_setting]}
        ok_msg "Successfully loaded ${BLUE}$SCRIPT_NAME${RESET}"\
            "default setting"\
            "(${GREEN}$hb_setting - ${HB_DEFAULT[$hb_setting]}${RESET})."
    done
    done_msg "Successfully loaded ${BLUE}$SCRIPT_NAME${RESET} default settings."
    return 0
}

function load_home_base_safety_default () {
    if [ -z "$HB_SAFETY" ]; then
        warning_msg "No ${BLUE}$SCRIPT_NAME${RESET} default safety value"\
            "found. Defaulting to $MD_SAFETY."
        return 1
    fi
    set_safety "$HB_SAFETY"
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not load ${BLUE}$SCRIPT_NAME${RESET} default safety"\
            "value ${RED}$HB_SAFETY${RESET}."
    else
        ok_msg "Successfully loaded ${BLUE}$SCRIPT_NAME${RESET}"\
            "default safety value ${GREEN}$HB_SAFETY${RESET}."
    fi
    return $EXIT_CODE
}

function load_home_base_script_name () {
    if [ -z "$HB_SCRIPT_NAME" ]; then
        warning_msg "No default script name found. Defaulting to $SRIPT_NAME."
        return 1
    fi
    set_project_name "$HB_SCRIPT_NAME"
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not load script name ${RED}$HB_SCRIPT_NAME${RESET}."
    else
        ok_msg "Successfully loaded"\
            "script name ${GREEN}$HB_SCRIPT_NAME${RESET}"
    fi
    return $EXIT_CODE
}

function load_home_base_prompt_string () {
    if [ -z "$HB_PS3" ]; then
        warning_msg "No default prompt string found. Defaulting to $MD_PS3."
        return 1
    fi
    set_project_prompt "$HB_PS3"
    EXIT_CODE=$?
    if [ $EXIT_CODE -ne 0 ]; then
        nok_msg "Something went wrong."\
            "Could not load prompt string ${RED}$HB_PS3${RESET}."
    else
        ok_msg "Successfully loaded"\
            "prompt string ${GREEN}$HB_PS3${RESET}"
    fi
    return $EXIT_CODE
}

function load_home_base_config () {
    load_home_base_script_name
    load_home_base_prompt_string
    load_settings_home_base_default
    load_home_base_safety_default
    load_home_base_logging_levels
}

function home_base_project_setup () {
    lock_and_load
    load_home_base_config
    create_home_base_menu_controllers
    setup_home_base_menu_controllers
}
