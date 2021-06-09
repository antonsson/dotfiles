export ANDROID_SDK=~/sdks/android-sdk/
export FLUTTER_SDK=~/sdks/flutter
export GOPATH=$HOME/.local/go
export ANDROID_HOME=$ANDROID_SDK
export ADB_DEFAULT="awesome:* ANTON:* BeerTime:* System.err DEBUG:* AndroidRuntime:* crunchfish:* salsa:* flutter:* *:S"
export XKB_DEFAULT_LAYOUT=se
export _JAVA_AWT_WM_NONREPARENTING=1

export NPM_PACKAGES="$HOME/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

# Wayland backend
export XDG_CURRENT_DESKTOP=sway
export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_FORCE_DPI=physical
export QT_QPA_PLATFORMTHEME=gtk3
export DESKTOP_APP_DISABLE_GTK_INTEGRATION=1

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
#unset MANPATH  # delete if you already modified MANPATH elsewhere in your configuration
#MANPATH="$NPM_PACKAGES/share/man:$(manpath)"
PATH=$HOME/.local/bin:$HOME/bin:$NPM_PACKAGES/bin:$PM_PACKAGES/bin:$HOME/.pub-cache/bin:$ANDROID_SDK/platform-tools/:$FLUTTER_SDK/bin:$FLUTTER_SDK/bin/cache/dart-sdk/bin/:$PATH:$GOPATH/bin:$HOME/.gem/ruby/2.7.0/bin:$HOME/programs/kotlin-lsp-server/bin

export PATH
