#!/bin/bash
#
# Regards, the Alveare Solutions society.
#
# DISPLAY

function display_system_users_loaded_flag () {
    if [ -z "${HB_TERRAFORM['users']}" ]; then
        return 1
    fi
    echo "[ ${CYAN}System Users${RESET}             ]: ${GREEN}Locked && Loaded${RESET}"
    return 0
}

function display_system_groups_loaded_flag () {
    if [ -z "${HB_TERRAFORM['groups']}" ]; then
        return 1
    fi
    echo "[ ${CYAN}System Groups${RESET}            ]: ${GREEN}Locked && Loaded${RESET}"
    return 0
}

function display_mapped_user_groups_flag () {
    if [ -z "${HB_TERRAFORM['user-groups']}" ]; then
        return 1
    fi
    echo "[ ${CYAN}User Groups${RESET}              ]: ${GREEN}Locked && Loaded${RESET}"
    return 0
}

function display_directories_loaded_flag () {
    if [ -z "${HB_TERRAFORM['directory-paths']}" ]; then
        return 1
    fi
    echo "[ ${CYAN}Directory Paths${RESET}          ]: ${GREEN}Locked && Loaded${RESET}"
    return 0
}

function display_files_loaded_flag () {
    if [ -z "${HB_TERRAFORM['file-paths']}" ]; then
        return 1
    fi
    echo "[ ${CYAN}File Paths${RESET}               ]: ${GREEN}Locked && Loaded${RESET}"
    return 0
}

function display_symlinks_loaded_flag () {
    if [ -z "${HB_TERRAFORM['symlink-paths']}" ]; then
        return 1
    fi
    echo "[ ${CYAN}Symbolic Links${RESET}           ]: ${GREEN}Locked && Loaded${RESET}"
    return 0
}

function display_home_base_banner () {
    figlet -f lean -w 1000 "$SCRIPT_NAME" > "${MD_DEFAULT['tmp-file']}"
    clear; echo -n "${BLUE}`cat ${MD_DEFAULT['tmp-file']}`${RESET}"
    echo -n > ${MD_DEFAULT['tmp-file']}
    return 0
}

function display_imported_system_users_file () {
    if [ -z ${HB_IMPORTS['system-users']} ]; then
        return 1
    fi
    echo "[ ${CYAN}Imported System Users${RESET}    ]: ${YELLOW}${HB_IMPORTS['system-users']}${RESET}"
    return 0
}

function display_imported_system_groups_file () {
    if [ -z ${HB_IMPORTS['system-groups']} ]; then
        return 1
    fi
    echo "[ ${CYAN}Imported System Groups${RESET}   ]: ${YELLOW}${HB_IMPORTS['system-groups']}${RESET}"
    return 0
}

function display_imported_user_groups_file () {
    if [ -z ${HB_IMPORTS['user-groups']} ]; then
        return 1
    fi
    echo "[ ${CYAN}Imported User Groups${RESET}     ]: ${YELLOW}${HB_IMPORTS['user-groups']}${RESET}"
    return 0
}

function display_imported_directory_paths_file () {
    if [ -z ${HB_IMPORTS['dir-paths']} ]; then
        return 1
    fi
    echo "[ ${CYAN}Imported Directory Paths${RESET} ]: ${YELLOW}${HB_IMPORTS['dir-paths']}${RESET}"
    return 0
}

function display_imported_file_paths_file () {
    if [ -z ${HB_IMPORTS['file-paths']} ]; then
        return 1
    fi
    echo "[ ${CYAN}Imported File Paths${RESET}      ]: ${YELLOW}${HB_IMPORTS['file-paths']}${RESET}"
    return 0
}

function display_imported_symbolic_link_file () {
    if [ -z ${HB_IMPORTS['symlink-paths']} ]; then
        return 1
    fi
    echo "[ ${CYAN}Imported SymLinks${RESET}        ]: ${YELLOW}${HB_IMPORTS['symlink-paths']}${RESET}"
    return 0
}

function display_home_base_optional_settings () {

    display_system_users_loaded_flag
    display_system_groups_loaded_flag
    display_mapped_user_groups_flag
    display_directories_loaded_flag
    display_files_loaded_flag
    display_symlinks_loaded_flag

    display_imported_system_users_file
    display_imported_system_groups_file
    display_imported_user_groups_file
    display_imported_directory_paths_file
    display_imported_file_paths_file
    display_imported_symbolic_link_file

    return 0
}

function display_home_base_settings () {
    DISPLAY_SAFETY=`format_flag_colors "$MD_SAFETY"`
    echo "[ ${CYAN}Conf File${RESET}                ]: ${YELLOW}${MD_DEFAULT['conf-file']}${RESET}
[ ${CYAN}Log File${RESET}                 ]: ${YELLOW}${MD_DEFAULT['log-file']}${RESET}
[ ${CYAN}Temporary File${RESET}           ]: ${YELLOW}${MD_DEFAULT['tmp-file']}${RESET}
[ ${CYAN}File Editor${RESET}              ]: ${MAGENTA}${MD_DEFAULT['file-editor']}${RESET}
[ ${CYAN}Log Lines${RESET}                ]: ${WHITE}${MD_DEFAULT['log-lines']}${RESET}
[ ${CYAN}Safety${RESET}                   ]: $DISPLAY_SAFETY"
    display_home_base_optional_settings | column
    echo; return 0
}

