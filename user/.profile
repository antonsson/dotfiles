export ANDROID_SDK=~/sdks/android-sdk/
export ANDROID_HOME=$ANDROID_SDK
export ADB_DEFAULT="awesome:* ANTON:* BeerTime:* System.err DEBUG:* AndroidRuntime:* crunchfish:* salsa:* flutter:* *:S"
export XKB_DEFAULT_LAYOUT=se
export _JAVA_AWT_WM_NONREPARENTING=1

# Wayland backend
export XDG_CURRENT_DESKTOP=sway
export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_FORCE_DPI=physical
export QT_QPA_PLATFORMTHEME=gtk3
export DESKTOP_APP_DISABLE_GTK_INTEGRATION=1

export VISUAL="nvim"
export EDITOR="$VISUAL"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export PAGER=/usr/bin/most

# History settings
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignorespace:erasedups
shopt -s histappend
PROMPT_COMMAND='history -a'

export PATH=$PATH:$HOME/.local/bin:$ANDROID_SDK/platform-tools/:$HOME/.cargo/bin:$HOME/.local/share/kotlin-language-server/bin
