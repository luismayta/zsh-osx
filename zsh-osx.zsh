#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

#
# Defines functions osx for osx or linux.
#
# Authors:
#   Luis Mayta <luis@hadenlabs.com>
#
#
ZSH_OSX_PATH=$(dirname "${0}")

# shellcheck source=/dev/null
source "${ZSH_OSX_PATH}"/config/main.zsh

# shellcheck source=/dev/null
source "${ZSH_OSX_PATH}"/core/main.zsh

# shellcheck source=/dev/null
source "${ZSH_OSX_PATH}"/internal/main.zsh

# shellcheck source=/dev/null
source "${ZSH_OSX_PATH}"/pkg/main.zsh