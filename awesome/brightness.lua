local awful = require("awful")
local paths = require("paths")


function update_brightness(comm)
    local f = io.open(states_path .. "brightnessState", "r+")
    if f == nil then
        f = io.open(states_path .. "brightnessState", "w")
        f:write("0.5")
        f:close()
    end
    local before = tonumber(f:read())

    if ((comm == "+") and (before < 0.9)) then
        before = before + 0.1
    elseif ((comm == "-") and (before > 0.0)) then
        before = before - 0.1
    end
    awful.spawn("xrandr --output " .. laptopScreen .. " --brightness " .. before)
    f:seek("set", 0)
    f:write(before)
    f:close()
end