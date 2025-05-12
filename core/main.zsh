#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

function osx::core::main::factory {
    # shellcheck source=/dev/null
    source "${ZSH_OSX_PATH}"/core/base.zsh
    case "${OSTYPE}" in
    darwin*)
        # shellcheck source=/dev/null
        source "${ZSH_OSX_PATH}"/core/osx.zsh
        ;;
    linux*)
        # shellcheck source=/dev/null
        source "${ZSH_OSX_PATH}"/core/linux.zsh
      ;;
    esac
}

osx::core::main::factory