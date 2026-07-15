---@diagnostic disable: need-check-nil

------------------
---- MONITORS ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({output = "", mode = "preferred", position = "auto", scale = "auto"})
hl.monitor({
    output = "desc: Dell Inc. DELL U2518D 3C4YP92CBK5L",
    mode = "preferred",
    position = "0x0",
    transform = 1,
    scale = "auto"
})
hl.monitor({
    output = "desc: Dell Inc. DELL P2715Q V7WP95AVA40L",
    mode = "preferred",
    position = "1440x0",
    scale = "1.33"
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "foot"
local fileManager = "nautilus"

-------------------
---- AUTOSTART/STOP ----
-------------------

hl.on("hyprland.start", function()
    hl.exec_cmd("noctalia")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("systemctl --user start ssh-agent.service")
    hl.exec_cmd("systemctl --user start hyprland-session.target")
end)

hl.on("hyprland.shutdown", function()
    os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 8,

        border_size = 1,

        col = {
            active_border = {
                colors = {"rgba(33ccffee)", "rgba(00ff99ee)"},
                angle = 45
            },
            inactive_border = "rgba(595959aa)"
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle"
    },

    decoration = {
        rounding = 8,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = 0xee1a1a1a
        },

        blur = {enabled = true, size = 3, passes = 2, vibrancy = 0.1696}
    },

    animations = {enabled = true}
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", {type = "bezier", points = {{0.23, 1}, {0.32, 1}}})
hl.curve("easeInOutCubic", {type = "bezier", points = {{0.65, 0.05}, {0.36, 1}}})
hl.curve("linear", {type = "bezier", points = {{0, 0}, {1, 1}}})
hl.curve("almostLinear", {type = "bezier", points = {{0.5, 0.5}, {0.75, 1}}})
hl.curve("quick", {type = "bezier", points = {{0.15, 0}, {0.1, 1}}})

-- Default springs
hl.curve("easy", {
    type = "spring",
    mass = 1,
    stiffness = 71.2633,
    dampening = 15.8273644
})

hl.animation({leaf = "global", enabled = true, speed = 10, bezier = "default"})
hl.animation({
    leaf = "border",
    enabled = true,
    speed = 5.39,
    bezier = "easeOutQuint"
})
hl.animation({leaf = "windows", enabled = true, speed = 4.79, spring = "easy"})
hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 4.1,
    spring = "easy",
    style = "popin 87%"
})
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 1.49,
    bezier = "linear",
    style = "popin 87%"
})
hl.animation({
    leaf = "fadeIn",
    enabled = true,
    speed = 1.73,
    bezier = "almostLinear"
})
hl.animation({
    leaf = "fadeOut",
    enabled = true,
    speed = 1.46,
    bezier = "almostLinear"
})
hl.animation({leaf = "fade", enabled = true, speed = 3.03, bezier = "quick"})
hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 3.81,
    bezier = "easeOutQuint"
})
hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 4,
    bezier = "easeOutQuint",
    style = "fade"
})
hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 1.5,
    bezier = "linear",
    style = "fade"
})
hl.animation({
    leaf = "fadeLayersIn",
    enabled = true,
    speed = 1.79,
    bezier = "almostLinear"
})
hl.animation({
    leaf = "fadeLayersOut",
    enabled = true,
    speed = 1.39,
    bezier = "almostLinear"
})
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 1.94,
    bezier = "almostLinear",
    style = "fade"
})
hl.animation({
    leaf = "workspacesIn",
    enabled = true,
    speed = 1.21,
    bezier = "almostLinear",
    style = "fade"
})
hl.animation({
    leaf = "workspacesOut",
    enabled = true,
    speed = 1.94,
    bezier = "almostLinear",
    style = "fade"
})
hl.animation({leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick"})

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true -- You probably want this
    }
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({master = {new_status = "master"}})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({scrolling = {fullscreen_on_one_column = true}})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = true,
        disable_splash_rendering = true
    }
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "se",
        kb_variant = "",
        kb_model = "",
        kb_options = "caps:super",
        kb_rules = "",
        numlock_by_default = true,
        repeat_rate = 40,
        repeat_delay = 200,

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {natural_scroll = false}
    }
})

hl.gesture({fingers = 3, direction = "horizontal", action = "workspace"})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(
            "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({action = "toggle"}))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with mainMod + keys
hl.bind(mainMod .. " + H", hl.dsp.focus({direction = "left"}))
hl.bind(mainMod .. " + L", hl.dsp.focus({direction = "right"}))
hl.bind(mainMod .. " + K", hl.dsp.focus({direction = "up"}))
hl.bind(mainMod .. " + J", hl.dsp.focus({direction = "down"}))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({direction = "left"}))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({direction = "right"}))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({direction = "up"}))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({direction = "down"}))

hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({x = -20, y = 0}))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({x = 20, y = 0}))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({x = 0, y = 20}))
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({x = 0, y = -20}))

-- Move window
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({direction = "l"}))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({direction = "r"}))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({direction = "u"}))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({direction = "d"}))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({workspace = i}))
    hl.workspace_rule({workspace = "" .. i, monitor = "DP-1", persistent = true})
end

hl.bind(mainMod .. " + Q", hl.dsp.focus({workspace = 21}))
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.window.move({workspace = 21}))
hl.workspace_rule({workspace = "21", monitor = "DP-1", persistent = true})

hl.bind(mainMod .. " + W", hl.dsp.focus({workspace = 22}))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.window.move({workspace = 22}))
hl.workspace_rule({workspace = "22", monitor = "DP-1", persistent = true})

hl.bind(mainMod .. " + F1", hl.dsp.focus({workspace = 31}))
hl.bind(mainMod .. " + SHIFT + F1", hl.dsp.window.move({workspace = 31}))
hl.workspace_rule({workspace = "31", monitor = "HDMI-A-1", persistent = true})

hl.bind(mainMod .. " + F2", hl.dsp.focus({workspace = 32}))
hl.bind(mainMod .. " + SHIFT + F2", hl.dsp.window.move({workspace = 32}))
hl.workspace_rule({workspace = "32", monitor = "HDMI-A-1", persistent = true})

hl.bind(mainMod .. " + F3", hl.dsp.focus({workspace = 33}))
hl.bind(mainMod .. " + SHIFT + F3", hl.dsp.window.move({workspace = 33}))
hl.workspace_rule({workspace = "33", monitor = "HDMI-A-1", persistent = true})

hl.bind(mainMod .. " + F4", hl.dsp.focus({workspace = 34}))
hl.bind(mainMod .. " + SHIFT + F4", hl.dsp.window.move({workspace = 34}))
hl.workspace_rule({workspace = "34", monitor = "HDMI-A-1", persistent = true})

hl.bind(mainMod .. " + SHIFT + N", function()
    local ws = hl.get_active_workspace()
    hl.dispatch(hl.dsp.workspace.move({workspace = ws.id, monitor = "l"}))
end)

hl.bind(mainMod .. " + SHIFT + M", function()
    local ws = hl.get_active_workspace()
    hl.dispatch(hl.dsp.workspace.move({workspace = ws.id, monitor = "r"}))
end)

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S",
        hl.dsp.window.move({workspace = "special:magic"}))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({workspace = "e+1"}))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({workspace = "e-1"}))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), {mouse = true})
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), {mouse = true})

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), {locked = true})
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),
        {locked = true})
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"),
        {locked = true})
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), {locked = true})

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name = "suppress-maximize-events",
    match = {class = ".*"},

    suppress_event = "maximize"
})
suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name = "fix-xwayland-drags",
    match = {
        class = "^$",
        title = "^$",
        xwayland = true,
        float = true,
        fullscreen = false,
        pin = false
    },

    no_focus = true
})

--------------------------------
----------- NOCTALIA -----------
--------------------------------

-- Hyprland-run windowrule
hl.window_rule({
    name = "move-hyprland-run",
    match = {class = "hyprland-run"},

    move = "20 monitor_h-120",
    float = true
})

local ipc = "noctalia msg "

-- Core binds
hl.bind(mainMod .. "+Space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. "+S", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))
hl.bind(mainMod .. "+comma", hl.dsp.exec_cmd(ipc .. "settings-toggle"))

-- Media keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"))

-- Noctalia Settings
hl.window_rule({
    match = {class = "dev.noctalia.Noctalia"},
    float = true,
    size = {1080, 920}
})

-- For Noctalia Color templates
require("noctalia").apply_theme()
