#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

function osx::internal::main::factory {
    # shellcheck source=/dev/null
    source "${ZSH_OSX_PATH}"/internal/base.zsh
    case "${OSTYPE}" in
    darwin*)
        # shellcheck source=/dev/null
        source "${ZSH_OSX_PATH}"/internal/osx.zsh
        ;;
    linux*)
        # shellcheck source=/dev/null
        source "${ZSH_OSX_PATH}"/internal/linux.zsh
      ;;
    esac
    # shellcheck source=/dev/null
    source "${ZSH_OSX_PATH}"/internal/helper.zsh
}

osx::internal::main::factory
