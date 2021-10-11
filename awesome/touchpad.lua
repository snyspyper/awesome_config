local awful = require("awful")
local paths = require("paths")


function update_touchpad()
    local f = io.open(states_path .. "touchpadState", "r+")
    if f == nil then
        f = io.open(states_path .. "touchpadState", "w")
        f:write("0")
        f:close()
    end
    local before = (tonumber(f:read()) + 1) % 2

    awful.spawn("xinput set-prop 'Synaptics TM3336-001' 'Device Enabled' " .. before)
    f:seek("set", 0)
    f:write(before)
    f:close()
end
