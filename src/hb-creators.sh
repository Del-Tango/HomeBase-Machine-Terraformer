#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# CREATORS

function create_file () {
    local FILE_PATH="$1"
    symbol_msg "${GREEN}+${RESET}" "Creating file ${YELLOW}$FILE_PATH${RESET}..."
    touch $FILE_PATH
    return $?
}

function create_system_group() {
    local GROUP_NAME="$1"
    symbol_msg "${GREEN}+${RESET}" "Creating system group ${YELLOW}$GROUP_NAME${RESET}..."
    addgroup --force-badname $GROUP_NAME
    return $?
}

function create_system_user() {
    local USER_NAME="$1"
    symbol_msg "${GREEN}+${RESET}" "Creating system user ${YELLOW}$USER_NAME${RESET}..."
    adduser --force-badname $USER_NAME
    return $?
}

function create_directory() {
    local DIRECTORY_PATH="$1"
    symbol_msg "${GREEN}+${RESET}" "Creating directory ${YELLOW}$DIRECTORY_PATH${RESET}..."
    mkdir $DIRECTORY_PATH
    return $?
}

function create_symbolic_link() {
    local SRC_DIR_PATH="$1"
    local DST_DIR_PATH="$2"
    symbol_msg "${GREEN}+${RESET}" "Creating symbolic link between ${YELLOW}$SRC_DIR_PATH${RESET} and ${YELLOW}$DST_DIR_PATH${RESET}..."
    if [ $TERRAFORM_SAFETY == "off" ]; then
        ln -s $SRC_DIR_PATH $DST_DIR_PATH
    else
        warning_msg "CrawlSpace5 Terraform safety is ON!"
    fi
    return $?
}

function create_home_base_menu_controllers () {

    create_main_menu_controller
    create_home_base_menu_controller
    create_log_viewer_menu_cotroller
    create_settings_menu_controller
    done_msg "${BLUE}$SCRIPT_NAME${RESET} controller construction complete."

    return 0
}

function create_main_menu_controller () {

    info_msg "Creating menu controller"\
        "${YELLOW}$MAIN_CONTROLLER_LABEL${RESET}..."
    add_menu_controller "$MAIN_CONTROLLER_LABEL" \
        "$MAIN_CONTROLLER_DESCRIPTION"

    info_msg "Setting ${CYAN}$MAIN_CONTROLLER_LABEL${RESET} options..."
    set_menu_controller_options "$MAIN_CONTROLLER_LABEL" \
        "$MAIN_CONTROLLER_OPTIONS"

    return 0
}

function create_home_base_menu_controller () {

    info_msg "Creating menu controller"\
        "${YELLOW}$HOMEBASE_CONTROLLER_LABEL${RESET}..."
    add_menu_controller "$HOMEBASE_CONTROLLER_LABEL" \
        "$HOMEBASE_CONTROLLER_DESCRIPTION"

    info_msg "Setting ${CYAN}$HOMEBASE_CONTROLLER_LABEL${RESET} options..."
    set_menu_controller_options "$HOMEBASE_CONTROLLER_LABEL" \
        "$HOMEBASE_CONTROLLER_OPTIONS"

    return 0
}

function create_log_viewer_menu_cotroller () {

    info_msg "Creating menu controller"\
        "${YELLOW}$LOGVIEWER_CONTROLLER_LABEL${RESET}..."
    add_menu_controller "$LOGVIEWER_CONTROLLER_LABEL" \
        "$LOGVIEWER_CONTROLLER_DESCRIPTION"

    info_msg "Setting ${CYAN}$LOGVIEWER_CONTROLLER_LABEL${RESET} options..."
    set_menu_controller_options "$LOGVIEWER_CONTROLLER_LABEL" \
        "$LOGVIEWER_CONTROLLER_OPTIONS"

    return 0
}

function create_settings_menu_controller () {

    info_msg "Creating menu controller"\
        "${YELLOW}$SETTINGS_CONTROLLER_LABEL${RESET}..."
    add_menu_controller "$SETTINGS_CONTROLLER_LABEL" \
        "$SETTINGS_CONTROLLER_DESCRIPTION"

    info_msg "Setting ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} options..."
    set_menu_controller_options "$SETTINGS_CONTROLLER_LABEL" \
        "$SETTINGS_CONTROLLER_OPTIONS"

    info_msg "Setting ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} extented"\
        "banner function ${MAGENTA}display_home_base_settings${RESET}..."
    set_menu_controller_extended_banner "$SETTINGS_CONTROLLER_LABEL" \
        'display_home_base_settings'

    return 0
}

