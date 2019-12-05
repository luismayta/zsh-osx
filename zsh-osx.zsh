#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

#
# Defines install osx for osx or linux.
#
# Authors:
#   Luis Mayta <slovacus@gmail.com>
#
osx_package_name=osx

ZSH_OSX_PATH_ROOT=$(dirname "${0}":A)

# shellcheck source=/dev/null
source "${ZSH_OSX_PATH_ROOT}"/src/helpers/messages.zsh

# shellcheck source=/dev/null
source "${ZSH_OSX_PATH_ROOT}"/src/helpers/tools.zsh

function osx::dependences {
    message_info "Installing dependences for ${osx_package_name}"
    message_success "Installed dependences for ${osx_package_name}"
}

###############################################################################
# General UI/UX
###############################################################################

function osx::ux {

    message_info "Expanding the save panel by default"
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

    message_info "Automatically quit printer app once the print jobs complete"
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

    # Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
    message_info "Displaying ASCII control characters using caret notation in standard text views"
    defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

    message_info "Save to disk, rather than iCloud, by default"
    defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

    message_info "Check for software updates daily, not just once per week"
    defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

    message_info "Removing duplicates in the 'Open With' menu"
    /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

    message_info "Disable smart quotes and smart dashes"
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

    message_info "Disable Photos.app from starting everytime a device is plugged in"
    defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

}

################################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input
###############################################################################
function osx::trackpad {

    message_info "Increasing sound quality for Bluetooth headphones/headsets"
    defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

    message_info "Enabling full keyboard access for all controls (enable Tab in modal dialogs, menu windows, etc.)"
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

    message_info "Disable auto-correct"
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

    message_info "Setting trackpad & mouse speed to a reasonable number"
    defaults write -g com.apple.trackpad.scaling 2
    defaults write -g com.apple.mouse.scaling 2.5

    message_info "Turn off keyboard illumination when computer is not used for 5 minutes"
    defaults write com.apple.BezelServices kDimTime -int 300

}

###############################################################################
# Screen
###############################################################################
function osx::screen {

    message_info "Requiring password immediately after sleep or screen saver begins"
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0

    message_info "Setting Screenshot location to ~/Desktop/Screenshots"
    mkdir -p ~/Desktop/Screenshots
    screenshot_location="${HOME}/Desktop/Screenshots"
    defaults write com.apple.screencapture location -string "${screenshot_location}"

    message_info "Setting screenshot format to PNG"
    defaults write com.apple.screencapture type -string "png"

    message_info "Enabling subpixel font rendering on non-Apple LCDs"
    defaults write NSGlobalDomain AppleFontSmoothing -int 2

}

###############################################################################
# Finder
###############################################################################
function osx::finder {
    message_info "Show icons for hard drives, servers, and removable media on the desktop"
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

    message_info "Show hidden files in Finder"
    defaults write com.apple.Finder AppleShowAllFiles -bool true

    message_info "Show all filename extensions in Finder by default"
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true

    message_info "Show status bar in Finder by default"
    defaults write com.apple.finder ShowStatusBar -bool true

    message_info "Display full POSIX path as Finder window title"
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

    message_info "Use column view in all Finder windows by default"
    defaults write com.apple.finder FXPreferredViewStyle Clmv

    message_info "Avoid creation of .DS_Store files on network volumes"
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

    message_info "Allowing text selection in Quick Look/Preview in Finder by default"
    defaults write com.apple.finder QLEnableTextSelection -bool true

    message_info "Enable snap-to-grid for icons on the desktop and in other icon views"
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

    message_info "Increase grid spacing for icons on the desktop and in other icon views"
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

    message_info "Increase the size of icons on the desktop and in other icon views"
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
}

###############################################################################
# Dock & Mission Control
###############################################################################
function osx::dock {

    message_info "Wipe all (default) app icons from the Dock"
    defaults write com.apple.dock persistent-apps -array
    defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Reminders</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
    defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Notes</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
    defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Messages</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
    defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Calendar</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

    message_info "Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
    defaults write com.apple.dock tilesize -int 36

    message_info "Speeding up Mission Control animations and grouping windows by application"
    defaults write com.apple.dock expose-animation-duration -float 0.1
    defaults write com.apple.dock "expose-group-by-app" -bool true

    message_info "Disable the over-the-top focus ring animation"
    defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

    message_info "Set Dock to auto-hide and remove the auto-hiding delay"
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock autohide-delay -float 0
    defaults write com.apple.dock autohide-time-modifier -float 0

}

###############################################################################
# Chrome, Safari, & WebKit
###############################################################################
function osx::browser {
    message_info "Privacy: Don't send search queries to Apple"
    defaults write com.apple.Safari UniversalSearchEnabled -bool false
    defaults write com.apple.Safari SuppressSearchSuggestions -bool true

    message_info "Show Safari's bookmarks bar by default"
    defaults write com.apple.Safari ShowFavoritesBar -bool true

    message_info "Hiding Safari's sidebar in Top Sites"
    defaults write com.apple.Safari ShowSidebarInTopSites -bool false

    message_info "Disabling Safari's thumbnail cache for History and Top Sites"
    defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

    message_info "Enabling Safari's debug menu"
    defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

    message_info "Making Safari's search banners default to Contains instead of Starts With"
    defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

    message_info "Removing useless icons from Safari's bookmarks bar"
    defaults write com.apple.Safari ProxiesInBookmarksBar "()"

    message_info "Enabling the Develop menu and the Web Inspector in Safari"
    defaults write com.apple.Safari IncludeDevelopMenu -bool true
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
    defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

    message_info "Adding a context menu item for showing the Web Inspector in web views"
    defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

}

###############################################################################
# Messages                                                                    #
###############################################################################
function osx::messages {

    message_info "Disable smart quotes in Messages.app"
    defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

}

###############################################################################
# Optional Extras
###############################################################################
function osx::extras {
    # Create a nice last-change git log message, from https://twitter.com/elijahmanor/status/697055097356943360
    git config --global alias.lastchange 'log -p --follow -n 1'
}


function osx::packages {
    message_info "Install packages for ${osx_package_name}"
    message_success "Installed packages for ${osx_package_name}"
}

function osx::install {
    osx::dependences
    message_info "Installing ${osx_package_name}"
    message_success "Installed ${osx_package_name}"
}

function osx::post_install {
    message_info "Post Install ${osx_package_name}"
    message_success "Success Install ${osx_package_name}"
}

function osx::sync {
    osx::ux
    osx::general
    osx::trackpad
    osx::screen
    osx::finder
    osx::dock
    osx::browser
    osx::messages
    osx::extras
}
