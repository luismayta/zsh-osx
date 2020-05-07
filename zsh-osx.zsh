#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

#
# Defines install osx for osx or linux.
#
# Authors:
#   Luis Mayta <slovacus@gmail.com>
#
osx_package_name=osx
[ -z "${COMPUTER_NAME}" ] && export COMPUTER_NAME="Osiris"

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

###############################################################################
# 🍎 Mac App Store
###############################################################################
function osx::appStore {
    defaults write com.apple.appstore ShowDebugMenu -bool true
    defaults write com.apple.commerce AutoUpdate -bool true
    defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
    defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
    defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

    # Check for software updates daily, not just once per week
    defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

    # Allow the App Store to reboot machine on macOS updates
    defaults write com.apple.commerce AutoUpdateRestartRequired -bool true
}

###############################################################################
# ⌨️ Keyboard
###############################################################################
function osx::keyboard {
    defaults write -g KeyRepeat -int 3
    defaults write -g InitialKeyRepeat -int 15

    # Disable press-and-hold for keys in favour of key repeat
    defaults write -g ApplePressAndHoldEnabled -bool true

    # Shortcut to maximize window
    defaults write -g NSUserKeyEquivalents -dict-add "Zoom" -string "@~^f"

    # Disable automatic modifications of entered text
    defaults write -g NSAutomaticCapitalizationEnabled -bool false
    defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
    defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
    defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
    defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

    # Enable full keyboard access for all controls
    # (e.g. enable Tab in modal dialogs)
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

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
    local screenshot_location
    message_info "Requiring password immediately after sleep or screen saver begins"
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 0

    message_info "Setting Screenshot location to ~/Desktop/Screenshots"
    screenshot_location="${HOME}/Desktop/Screenshots"
    mkdir -p "${screenshot_location}"
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

    defaults write com.apple.finder DisableAllAnimations -bool true
    defaults write -g AppleShowAllExtensions -bool true
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
    defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
    defaults write com.apple.finder NewWindowTarget -string "PfDe"
    defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder ShowStatusBar -bool true
    defaults write com.apple.finder FinderSpawnTab -bool false
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
    defaults write com.apple.finder _FXSortFoldersFirst -bool true
    defaults write com.apple.finder QLEnableTextSelection -bool TRUE

    # Toolbar icons
    defaults write com.apple.finder 'NSToolbar Configuration Browser' '{
    "TB Default Item Identifiers" =     (
        "com.apple.finder.BACK",
        NSToolbarFlexibleSpaceItem,
        "com.apple.finder.SWCH",
        "com.apple.finder.ARNG",
        "com.apple.finder.ACTN",
        "com.apple.finder.SHAR",
        "com.apple.finder.LABL",
        NSToolbarFlexibleSpaceItem,
        NSToolbarFlexibleSpaceItem,
        "com.apple.finder.SRCH"
    );
    "TB Display Mode" = 2;
    "TB Icon Size Mode" = 1;
    "TB Is Shown" = 1;
    "TB Item Identifiers" =     (
        "com.apple.finder.BACK",
        NSToolbarFlexibleSpaceItem,
        "com.apple.finder.SWCH",
        "com.apple.finder.ARNG",
        NSToolbarSpaceItem,
        "com.apple.finder.NFLD",
        NSToolbarFlexibleSpaceItem,
        "com.apple.finder.SRCH"
    );
    "TB Size Mode" = 1;
}'

    # Modify behaviour for "Save" modal window
    defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false
    defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
    defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true

    # Enable spring loading for directories: https://www.youtube.com/watch?v=F9kdAxGe9SE
    defaults write -g com.apple.springing.enabled -bool true
    defaults write -g com.apple.springing.delay -float 0

    # Automatically open a new Finder window when a volume is mounted
    defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
    defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
    defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

    # Show item info near icons on the desktop and in other icon views
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist

    # Show item info to the right of the icons on the desktop
    /usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

    # Enable snap-to-grid for icons on the desktop and in other icon views
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

    # Increase grid spacing for icons on the desktop and in other icon views
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist

    # Increase the size of icons on the desktop and in other icon views
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist

    # Expand the following File Info panes:
    # “General”, “Open with”, and “Sharing & Permissions”
    defaults write com.apple.finder FXInfoPanesExpanded -dict \
	           General -bool true \
	           OpenWith -bool true \
	           Privileges -bool true

    # When performing a search, search the current folder by default
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

    # Show icons for hard drives, servers, and removable media on the desktop
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
    killall Finder

    # Show Sidebar, but remove the Tags section.
    defaults write com.apple.finder ShowSidebar -bool true
    defaults write com.apple.finder ShowRecentTags -bool false

}

###############################################################################
# Dock & Mission Control
###############################################################################
function osx::dock {
    message_info "Implement settings for dock"

    # Automatically hide and show the Dock
    defaults write com.apple.dock autohide -bool true

    # Show only open applications in the Dock
    defaults write com.apple.dock static-only -bool true

    # Wipe all (default) app icons from the Dock
    defaults write com.apple.dock persistent-apps -array

    # Set the icon size of Dock items to 28->64 pixels with magnification
    defaults write com.apple.dock tilesize -int 28
    defaults write com.apple.dock largesize -int 64
    defaults write com.apple.dock magnification -bool true

    # Speed up Mission Control animations
    defaults write com.apple.dock expose-animation-duration -float 0.1

    # Disable Dashboard
    defaults write com.apple.dashboard mcx-disabled -bool true

    # Don’t show Dashboard as a Space
    defaults write com.apple.dock dashboard-in-overlay -bool true

    # Don’t automatically rearrange Spaces based on most recent use
    defaults write com.apple.dock mru-spaces -bool false

    # Top-right hot corner + cmd turns on screen saver
    defaults write com.apple.dock wvous-tr-corner -int 5 # start screen saver
    defaults write com.apple.dock wvous-tr-modifier -int 1048576 # cmd key

    # Bottom-right hot corner + cmd disables screen saver
    defaults write com.apple.dock wvous-br-corner -int 6 # disable screen saver
    defaults write com.apple.dock wvous-br-modifier -int 1048576 # cmd key

    # Require password 5 seconds after sleep or screen saver begins
    defaults write com.apple.screensaver askForPassword -int 1
    defaults write com.apple.screensaver askForPasswordDelay -int 5

    message_success "Settings dock"

}

function osx::automaticUpdates {
    message_info "Implement automatic updates"
    # Automatic updates
    sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticallyInstallMacOSUpdates -bool true
    sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticCheckEnabled -bool true
    sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticDownload -bool true
    sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist ConfigDataInstall -bool true
    sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist CriticalUpdateInstall -bool true
    sudo defaults write /Library/Preferences/com.apple.commerce.plist AutoUpdate -bool true
    message_success "Implemented automatic updates"
}


###############################################################################
# 🎛 Mission Control
###############################################################################
function osx::missioncontrol {
    message_info "Implement settings for mission control"
    defaults write com.apple.dock expose-animation-duration -float 0.1
    defaults write com.apple.dashboard mcx-disabled -bool true

    # Don’t automatically rearrange Spaces based on most recent use
    defaults write com.apple.dock mru-spaces -bool false

    # Hot corners
    # Possible values:
    #  0: no-op
    #  2: Mission Control
    #  3: Show application windows
    #  4: Desktop
    #  5: Start screen saver
    #  6: Disable screen saver
    #  7: Dashboard
    # 10: Put display to sleep
    # 11: Launchpad
    # 12: Notification Center

    # Top left screen corner → Show application windows
    defaults write com.apple.dock wvous-tl-corner -int 3
    defaults write com.apple.dock wvous-tl-modifier -int 0

    # Top right screen corner → Mission Control
    defaults write com.apple.dock wvous-tr-corner -int 2
    defaults write com.apple.dock wvous-tr-modifier -int 0

    # Bottom left screen corner → Notification Center
    defaults write com.apple.dock wvous-bl-corner -int 12
    defaults write com.apple.dock wvous-bl-modifier -int 0
    # Bottom right screen corner → Desktop
    defaults write com.apple.dock wvous-br-corner -int 4
    defaults write com.apple.dock wvous-br-modifier -int 0

    killall Dock

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

###############################################################################
# Others
###############################################################################
function osx::others {

    # Disable the sound effects on boot
    sudo nvram SystemAudioVolume=" "

    defaults write -g AppleShowScrollBars -string "Always"
    defaults write -g NSWindowResizeTime -float 0.001

    # Restart automatically if the computer freezes
    sudo systemsetup -setrestartfreeze on

    # Avoid creating .DS_Store files on network or USB volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

    # Font rendering for non-retina displays. More info: https://github.com/Microsoft/vscode/issues/51132
    defaults write -g CGFontRenderingFontSmoothingDisabled -bool false

    # Set computer name (as done via System Preferences → Sharing)
    sudo scutil --set ComputerName "${COMPUTER_NAME}"
    sudo scutil --set HostName "${COMPUTER_NAME}"
    sudo scutil --set LocalHostName "${COMPUTER_NAME}"
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${COMPUTER_NAME}"

    # Disable new disks requests for Time Machine
    defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

    # Auto-play videos when opened with QuickTime Player
    defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true

    # Prevent Photos from opening automatically when devices are plugged in
    defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
}

function osx::mail {
    # Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
    defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

    # # Disable send and reply animations in Mail.app
    defaults write com.apple.mail DisableReplyAnimations -bool true
    defaults write com.apple.mail DisableSendAnimations -bool true

    # # Disable inline attachments (just show the icons)
    defaults write com.apple.mail DisableInlineAttachmentViewing -bool true
}

function osx::spotlight {

    # Don't display first-time Spotlight messages
    defaults write com.apple.spotlight showedFTE 1
    defaults write com.apple.spotlight showedLearnMore 1

    # # Spotlight autocomplete sources
    defaults write com.apple.spotlight orderedItems -array \
             '{"enabled" = 1;"name" = "APPLICATIONS";}' \
             '{"enabled" = 1;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}' \
             '{"enabled" = 1;"name" = "MENU_CONVERSION";}' \
             '{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
             '{"enabled" = 1;"name" = "MENU_DEFINITION";}' \
             '{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
             '{"enabled" = 0;"name" = "MESSAGES";}' \
             '{"enabled" = 0;"name" = "DOCUMENTS";}' \
             '{"enabled" = 0;"name" = "DIRECTORIES";}' \
             '{"enabled" = 0;"name" = "PRESENTATIONS";}' \
             '{"enabled" = 0;"name" = "SPREADSHEETS";}' \
             '{"enabled" = 0;"name" = "PDF";}' \
             '{"enabled" = 0;"name" = "MESSAGES";}' \
             '{"enabled" = 0;"name" = "CONTACT";}' \
             '{"enabled" = 0;"name" = "EVENT_TODO";}' \
             '{"enabled" = 0;"name" = "IMAGES";}' \
             '{"enabled" = 0;"name" = "BOOKMARKS";}' \
             '{"enabled" = 0;"name" = "MUSIC";}' \
             '{"enabled" = 0;"name" = "MOVIES";}' \
             '{"enabled" = 0;"name" = "FONTS";}' \
             '{"enabled" = 0;"name" = "MENU_OTHER";}'

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
    osx::appStore
    osx::keyboard
    osx::trackpad
    osx::screen
    osx::finder
    osx::dock
    osx::mail
    osx::spotlight
    osx::automaticUpdates
    osx::missioncontrol
    osx::browser
    osx::messages
    osx::extras
    osx::others
}
