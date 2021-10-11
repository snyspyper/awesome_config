local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

volume_widget = wibox.widget.textbox()
volume_widget:set_font("Play 11")

function update_volume_widget(widget, comm)
    local vol_state = io.popen("pamixer --get-mute"):read("*all")
    local current

    if (comm == "+") then
        awful.spawn("pamixer -i 5")
    elseif (comm == "-") then
        awful.spawn("pamixer -d 5")
    elseif (comm == "m") then
        if (vol_state == "true\n") then
            awful.spawn("pamixer -u")
        else
            awful.spawn("pamixer -m")
        end
    end

    current = io.popen(
        "echo " .. ((vol_state == "true\n") and '  ' or '  $(pamixer --get-volume)')
    ):read("*all")

    widget:set_text(current)
end

volume_timer = gears.timer({ timeout = 100 })
volume_timer:connect_signal("timeout", function () update_volume_widget(volume_widget, "") end)
volume_timer:start()

volume_timer:emit_signal("timeout")