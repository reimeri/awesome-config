-----------------------------------------------------------------------------------------------------------------------
--                                               Alsa widget                                                --
-----------------------------------------------------------------------------------------------------------------------
-- Sound widget
-----------------------------------------------------------------------------------------------------------------------

local setmetatable = setmetatable
local os = os
local textbox = require("wibox.widget.textbox")
local beautiful = require("beautiful")
local gears = require("gears")

local tooltip = require("redflat.float.tooltip")
local redutil = require("redflat.util")

-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local alsasound = { mt = {} }

-- Generate default theme vars
-----------------------------------------------------------------------------------------------------------------------
local function default_style()
	local style = {
		font  = "Sans 12",
		tooltip = {},
		color = { text = "#aaaaaa" }
	}
	return redutil.table.merge(style, redutil.table.check(beautiful, "widget.alsasound") or {})
end

-- Create a alsa widget. Shows the current sound level
-----------------------------------------------------------------------------------------------------------------------
function alsasound.new(args, style)

	-- Initialize vars
	--------------------------------------------------------------------------------
	args = args or {}
	style = redutil.table.merge(default_style(), style or {})

	-- Create widget
	--------------------------------------------------------------------------------
	local widg = textbox()
	widg:set_font(style.font)

	-- Set update timer
	--------------------------------------------------------------------------------
	local timer = gears.timer({ timeout = 0.5 })
	timer:connect_signal("timeout",
		function()
			widg:set_markup('<span color="' .. style.color.text .. '">' .. string.match(redutil.read.output("amixer get Master -M"), "([%d]+)%%.*%[([%l]*)") .. "</span>")
		end)
	timer:start()
	timer:emit_signal("timeout")

	--------------------------------------------------------------------------------
	return widg
end

-- Config metatable to call alsasound module as function
-----------------------------------------------------------------------------------------------------------------------
function alsasound.mt:__call(...)
	return alsasound.new(...)
end

return setmetatable(alsasound, alsasound.mt)