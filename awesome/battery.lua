local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

battery_widget = wibox.widget.textbox()
battery_widget:set_font("Play 11")

function update_battery_widget(widget)
    local current = io.popen(
        "echo ' '$(cat /sys/class/power_supply/BAT0/capacity)%'  '"
    ):read("*all")
    widget:set_text(current)
end

battery_timer = gears.timer({ timeout = 100 })
battery_timer:connect_signal("timeout", function () update_battery_widget(battery_widget) end)
battery_timer:start()

battery_timer:emit_signal("timeout")