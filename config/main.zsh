#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

function osx::config::main::factory {
    # shellcheck source=/dev/null
    source "${ZSH_OSX_PATH}"/config/base.zsh
    case "${OSTYPE}" in
    darwin*)
        # shellcheck source=/dev/null
        source "${ZSH_OSX_PATH}"/config/osx.zsh
        ;;
    linux*)
        # shellcheck source=/dev/null
        source "${ZSH_OSX_PATH}"/config/linux.zsh
      ;;
    esac
}

osx::config::main::factory