# Good keyboard default
export XKB_DEFAULT_LAYOUT=se

# Wayland backend
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
# Firefox
export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1
# Qt Wayland
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=gtk3
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
# JVM
export _JAVA_AWT_WM_NONREPARENTING=1

# Editor
export VISUAL="nvim"
export EDITOR="$VISUAL"

# Enable ssh agent
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# History settings
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignorespace:erasedups
shopt -s histappend
PROMPT_COMMAND='history -a'

# Android dev
export ANDROID_SDK=~/sdks/android-sdk/
export ANDROID_HOME=$ANDROID_SDK
export ADB_DEFAULT="ANTON:* BeerTime:* System.err DEBUG:* AndroidRuntime:* crunchfish:* *:S"

# Path
export PATH=$PATH:$HOME/.local/bin:$ANDROID_SDK/platform-tools/:$HOME/.cargo/bin:$HOME/.local/share/kotlin-language-server/bin
