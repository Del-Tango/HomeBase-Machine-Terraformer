#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# SETUP

function setup_home_base_dependencies () {

    setup_home_base_apt_dependencies

    return 0
}

function setup_settings_menu_controller () {

    setup_settings_menu_option_set_safety_on
    setup_settings_menu_option_set_safety_off
    setup_settings_menu_option_set_temporary_file
    setup_settings_menu_option_set_log_file
    setup_settings_menu_option_set_log_lines
    setup_settings_menu_option_set_file_editor
    setup_settings_menu_option_add_users_manually
    setup_settings_menu_option_add_groups_manually
    setup_settings_menu_option_add_user_groups
    setup_settings_menu_option_add_directories_manually
    setup_settings_menu_option_add_files_manually
    setup_settings_menu_option_add_symlinks_manually
    setup_settings_menu_option_import_users_file
    setup_settings_menu_option_import_groups_file
    setup_settings_menu_option_import_user_groups
    setup_settings_menu_option_import_directory_paths
    setup_settings_menu_option_import_file_paths
    setup_settings_menu_option_import_symlinks_file
    setup_settings_menu_option_install_dependencies
    setup_settings_menu_option_back
    done_msg "${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} controller option"\
        "binding complete."

    return 0
}

function setup_home_base_menu_controller () {

    setup_home_base_menu_option_terraform_machine
    setup_home_base_menu_option_inspect_loaded_users
    setup_home_base_menu_option_inspect_loaded_groups
    setup_home_base_menu_option_inspect_loaded_mapped_user_groups
    setup_home_base_menu_option_inspect_loaded_symlinks
    setup_home_base_menu_option_inspect_loaded_directories
    setup_home_base_menu_option_inspect_loaded_files
    setup_home_base_menu_option_back
    done_msg "${CYAN}$HOMEBASE_CONTROLLER_LABEL${RESET} controller option"\
        "binding complete."

    return 0
}

function setup_log_viewer_menu_controller () {

    setup_log_viewer_menu_option_display_tail
    setup_log_viewer_menu_option_display_head
    setup_log_viewer_menu_option_display_more
    setup_log_viewer_menu_option_clear_log_file
    setup_log_viewer_menu_option_back
    done_msg "${CYAN}$LOGVIEWER_CONTROLLER_LABEL${RESET} controller option"\
        "binding complete."

    return 0
}

function setup_main_menu_controller () {

    setup_main_menu_option_home_base
    setup_main_menu_option_log_viewer
    setup_main_menu_option_control_panel
    setup_main_menu_option_back
    done_msg "${CYAN}$MAIN_CONTROLLER_LABEL${RESET} controller option"\
        "binding complete."

    return 0
}

function setup_home_base_menu_controllers () {

    setup_home_base_dependencies
    setup_main_menu_controller
    setup_home_base_menu_controller
    setup_log_viewer_menu_controller
    setup_settings_menu_controller
    done_msg "${BLUE}$SCRIPT_NAME${RESET} controller setup complete."

    return 0
}

# HOME BASE MENU SETUP

function setup_home_base_menu_option_inspect_loaded_mapped_user_groups () {

    info_msg "Binding ${CYAN}$HOMEBASE_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Inspect-Mapped-User-Groups${RESET}"\
        "to function ${MAGENTA}action_inspect_loaded_mapped_user_groups${RESET}..."
    bind_controller_option \
        'to_action' "$HOMEBASE_CONTROLLER_LABEL" \
        'Inspect-Mapped-User-Groups' "action_inspect_loaded_mapped_user_groups"

    return 0
}

function setup_home_base_apt_dependencies () {
    if [ ${#HB_APT_DEPENDENCIES[@]} -eq 0 ]; then
        warning_msg "No ${RED}$SCRIPT_NAME${RESET} dependencies found."
        return 1
    fi
    FAILURE_COUNT=0
    SUCCESS_COUNT=0
    for util in ${HB_APT_DEPENDENCIES[@]}; do
        add_apt_dependency "$util"
        if [ $? -ne 0 ]; then
            FAILURE_COUNT=$((FAILURE_COUNT + 1))
        else
            SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
        fi
    done
    done_msg "(${GREEN}$SUCCESS_COUNT${RESET}) ${BLUE}$SCRIPT_NAME${RESET}"\
        "dependencies staged for installation using the APT package manager."\
        "(${RED}$FAILURE_COUNT${RESET}) failures."
    return 0
}

function setup_home_base_menu_option_terraform_machine () {

    info_msg "Binding ${CYAN}$HOMEBASE_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Terraform-Machine${RESET}"\
        "to function ${MAGENTA}action_terraform_machine${RESET}..."
    bind_controller_option \
        'to_action' "$HOMEBASE_CONTROLLER_LABEL" \
        'Terraform-Machine' "action_terraform_machine"

    return 0
}

function setup_home_base_menu_option_inspect_loaded_users () {

    info_msg "Binding ${CYAN}$HOMEBASE_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Inspect-Loaded-Users${RESET}"\
        "to function ${MAGENTA}action_inspect_loaded_users${RESET}..."
    bind_controller_option \
        'to_action' "$HOMEBASE_CONTROLLER_LABEL" \
        'Inspect-Loaded-Users' "action_inspect_loaded_users"

    return 0
}

function setup_home_base_menu_option_inspect_loaded_groups () {

    info_msg "Binding ${CYAN}$HOMEBASE_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Inspect-Loaded-Groups${RESET}"\
        "to function ${MAGENTA}action_inspect_loaded_groups${RESET}..."
    bind_controller_option \
        'to_action' "$HOMEBASE_CONTROLLER_LABEL" \
        'Inspect-Loaded-Groups' "action_inspect_loaded_groups"

    return 0
}

function setup_home_base_menu_option_inspect_loaded_symlinks () {

    info_msg "Binding ${CYAN}$HOMEBASE_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Inspect-Loaded-Symlinks${RESET}"\
        "to function ${MAGENTA}action_inspect_loaded_symlinks${RESET}..."
    bind_controller_option \
        'to_action' "$HOMEBASE_CONTROLLER_LABEL" \
        'Inspect-Loaded-Symlinks' "action_inspect_loaded_symlinks"

    return 0
}

function setup_home_base_menu_option_inspect_loaded_directories () {

    info_msg "Binding ${CYAN}$HOMEBASE_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Inspect-Loaded-Directories${RESET}"\
        "to function ${MAGENTA}action_inspect_loaded_directories${RESET}..."
    bind_controller_option \
        'to_action' "$HOMEBASE_CONTROLLER_LABEL" \
        'Inspect-Loaded-Directories' "action_inspect_loaded_directories"

    return 0
}

function setup_home_base_menu_option_inspect_loaded_files () {

    info_msg "Binding ${CYAN}$HOMEBASE_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Inspect-Loaded-Files${RESET}"\
        "to function ${MAGENTA}action_inspect_loaded_files${RESET}..."
    bind_controller_option \
        'to_action' "$HOMEBASE_CONTROLLER_LABEL" \
        'Inspect-Loaded-Files' "action_inspect_loaded_files"

    return 0
}

function setup_home_base_menu_option_back () {

    info_msg "Binding ${CYAN}$HOMEBASE_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Back${RESET}"\
        "to function ${MAGENTA}action_back${RESET}..."
    bind_controller_option \
        'to_action' "$HOMEBASE_CONTROLLER_LABEL" 'Back' "action_back"

    return 0
}

# LOG VIEWER MENU SETUP

function setup_log_viewer_menu_option_clear_log_file () {

    info_msg "Binding ${CYAN}$LOGVIEWER_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Clear-Log${RESET}"\
        "to function ${MAGENTA}action_clear_log_file${RESET}..."
    bind_controller_option \
        'to_action' "$LOGVIEWER_CONTROLLER_LABEL" \
        'Clear-Log' "action_clear_log_file"

    return 0
}

function setup_log_viewer_menu_option_display_tail () {

    info_msg "Binding ${CYAN}$LOGVIEWER_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Display-Tail${RESET}"\
        "to function ${MAGENTA}action_display_log_tail${RESET}..."
    bind_controller_option \
        'to_action' "$LOGVIEWER_CONTROLLER_LABEL" \
        'Display-Tail' "action_display_log_tail"

    return 0
}

function setup_log_viewer_menu_option_display_head () {

    info_msg "Binding ${CYAN}$LOGVIEWER_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Display-Head${RESET}"\
        "to function ${MAGENTA}action_display_log_head${RESET}..."
    bind_controller_option \
        'to_action' "$LOGVIEWER_CONTROLLER_LABEL" \
        'Display-Head' "action_display_log_head"

    return 0
}

function setup_log_viewer_menu_option_display_more () {

    info_msg "Binding ${CYAN}$LOGVIEWER_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Display-More${RESET}"\
        "to function ${MAGENTA}action_display_log_more${RESET}..."
    bind_controller_option \
        'to_action' "$LOGVIEWER_CONTROLLER_LABEL" \
        'Display-More' "action_display_log_more"

    return 0
}

function setup_log_viewer_menu_option_back () {

    info_msg "Binding ${CYAN}$LOGVIEWER_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Back${RESET}"\
        "to function ${MAGENTA}action_back${RESET}..."
    bind_controller_option \
        'to_action' "$LOGVIEWER_CONTROLLER_LABEL" 'Back' "action_back"

    return 0
}

# MAIN MENU SETUP

function setup_main_menu_option_home_base () {

    info_msg "Binding ${CYAN}$MAIN_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Home-Base${RESET}"\
        "to controller ${CYAN}$HOMEBASE_CONTROLLER_LABEL${RESET}..."
    bind_controller_option \
        'to_menu' "$MAIN_CONTROLLER_LABEL" \
        'Home-Base' "$HOMEBASE_CONTROLLER_LABEL"

    return $?
}

function setup_main_menu_option_log_viewer () {

    info_msg "Binding ${CYAN}$MAIN_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Log-Viewer${RESET}"\
        "to controller ${CYAN}$LOGVIEWER_CONTROLLER_LABEL${RESET}..."
    bind_controller_option \
        'to_menu' "$MAIN_CONTROLLER_LABEL" \
        'Log-Viewer' "$LOGVIEWER_CONTROLLER_LABEL"

    return $?
}

function setup_main_menu_option_control_panel () {

    info_msg "Binding ${CYAN}$MAIN_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Control-Panel${RESET}"\
        "to controller ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET}..."
    bind_controller_option \
        'to_menu' "$MAIN_CONTROLLER_LABEL" \
        'Control-Panel' "$SETTINGS_CONTROLLER_LABEL"

    return $?
}

function setup_main_menu_option_back () {

    info_msg "Binding ${CYAN}$MAIN_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Back${RESET}"\
        "to function ${MAGENTA}action_back${RESET}..."
    bind_controller_option \
        'to_action' "$MAIN_CONTROLLER_LABEL" 'Back' "action_back"

    return $?
}

# SETTINGS MENU SETUP

function setup_settings_menu_option_set_file_editor () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Set-File-Editor${RESET}"\
        "to function ${MAGENTA}action_set_file_editor${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Set-File-Editor" 'action_set_file_editor'

    return $?
}

function setup_settings_menu_option_set_safety_on () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Set-Safety-ON${RESET}"\
        "to function ${MAGENTA}action_set_safety_on${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Set-Safety-ON" 'action_set_safety_on'

    return $?
}

function setup_settings_menu_option_set_safety_off () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Set-Safety-OFF${RESET}"\
        "to function ${MAGENTA}action_set_safety_off${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Set-Safety-OFF" 'action_set_safety_off'

    return $?
}

function setup_settings_menu_option_set_temporary_file () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Set-Temporary-File${RESET}"\
        "to function ${MAGENTA}action_set_temporary_file${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Set-Temporary-File" 'action_set_temporary_file'

    return $?
}

function setup_settings_menu_option_set_log_file () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Set-Log-File${RESET}"\
        "to function ${MAGENTA}action_set_log_file${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Set-Log-File" 'action_set_log_file'

    return $?
}

function setup_settings_menu_option_set_log_lines () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Set-Log-Lines${RESET}"\
        "to function ${MAGENTA}action_set_log_lines${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Set-Log-Lines" 'action_set_log_lines'

    return $?
}

function setup_settings_menu_option_add_users_manually () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Add-Users-Manually${RESET}"\
        "to function ${MAGENTA}action_add_users_manually${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Add-Users-Manually" 'action_add_users_manually'

    return $?
}

function setup_settings_menu_option_add_groups_manually () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Add-Groups-Manually${RESET}"\
        "to function ${MAGENTA}action_add_groups_manually${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Add-Groups-Manually" 'action_add_groups_manually'

    return $?
}

function setup_settings_menu_option_add_user_groups () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Add-User-Groups${RESET}"\
        "to function ${MAGENTA}action_add_user_groups_manually${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Add-User-Groups" 'action_add_user_groups_manually'

    return $?
}

function setup_settings_menu_option_add_directories_manually () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Add-Directories-Manually${RESET}"\
        "to function ${MAGENTA}action_add_directory_paths_manually${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Add-Directories-Manually" 'action_add_directory_paths_manually'

    return $?
}

function setup_settings_menu_option_add_files_manually () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Add-Files-Manually${RESET}"\
        "to function ${MAGENTA}action_add_file_paths_manually${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Add-Files-Manually" 'action_add_file_paths_manually'

    return $?
}

function setup_settings_menu_option_add_symlinks_manually () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Add-Symlinks-Manually${RESET}"\
        "to function ${MAGENTA}action_add_symbolic_links_manually${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Add-Symlinks-Manually" 'action_add_symbolic_links_manually'

    return $?
}

function setup_settings_menu_option_import_users_file () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Import-Users-File${RESET}"\
        "to function ${MAGENTA}action_import_user_file${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Import-Users-File" 'action_import_user_file'

    return $?
}

function setup_settings_menu_option_import_groups_file () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Import-Groups-File${RESET}"\
        "to function ${MAGENTA}action_import_groups_file${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Import-Groups-File" 'action_import_groups_file'

    return $?
}

function setup_settings_menu_option_import_user_groups () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Import-User-Groups${RESET}"\
        "to function ${MAGENTA}action_import_user_groups_file${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Import-User-Groups" 'action_import_user_groups_file'

    return $?
}

function setup_settings_menu_option_import_directory_paths () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Import-Directory-Paths${RESET}"\
        "to function ${MAGENTA}action_import_directory_paths_file${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Import-Directory-Paths" 'action_import_directory_paths_file'

    return $?
}

function setup_settings_menu_option_import_file_paths () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Import-File-Paths${RESET}"\
        "to function ${MAGENTA}action_import_file_paths_file${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Import-File-Paths" 'action_import_file_paths_file'

    return $?
}

function setup_settings_menu_option_import_symlinks_file () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Import-Symlinks-File${RESET}"\
        "to function ${MAGENTA}action_import_symbolic_links_file${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Import-Symlinks-File" 'action_import_symbolic_links_file'

    return $?
}

function setup_settings_menu_option_install_dependencies () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Install-Dependencies${RESET}"\
        "to function ${MAGENTA}action_install_dependencies${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" \
        "Install-Dependencies" 'action_install_dependencies'

    return $?
}

function setup_settings_menu_option_back () {

    info_msg "Binding ${CYAN}$SETTINGS_CONTROLLER_LABEL${RESET} option"\
        "${YELLOW}Back${RESET}"\
        "to function ${MAGENTA}action_back${RESET}..."
    bind_controller_option \
        'to_action' "$SETTINGS_CONTROLLER_LABEL" 'Back' "action_back"

    return $?
}

