#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

function osx::pkg::main::factory {
    # shellcheck source=/dev/null
    source "${ZSH_OSX_PATH}"/pkg/base.zsh
    case "${OSTYPE}" in
    darwin*)
        # shellcheck source=/dev/null
        source "${ZSH_OSX_PATH}"/pkg/osx.zsh
        ;;
    linux*)
        # shellcheck source=/dev/null
        source "${ZSH_OSX_PATH}"/pkg/linux.zsh
      ;;
    esac
    # shellcheck source=/dev/null
    source "${ZSH_OSX_PATH}"/pkg/helper.zsh

    # shellcheck source=/dev/null
    source "${ZSH_OSX_PATH}"/pkg/alias.zsh
}

osx::pkg::main::factory
