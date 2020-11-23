-----------------------------------------------------------------------------------------------------------------------
--                                              Autostart app list                                                   --
-----------------------------------------------------------------------------------------------------------------------

-- Grab environment
local awful = require("awful")

-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local autostart = {}

-- Application list function
--------------------------------------------------------------------------------
function autostart.run()
	-- Resolution, TODO: currently just tries everything and hopes for the best
	awful.spawn.with_shell("xrandr --auto --output HDMI-A-0 --mode 2560x1440 --pos 3440x0")
	awful.spawn.with_shell("xrandr --auto --output HDMI-A-1 --mode 2560x1440 --pos 3440x0")
	awful.spawn.with_shell("xrandr --auto --output HDMI-A-2 --mode 2560x1440 --pos 3440x0")
	-- Main monitor display port number changes randomly
	-- awful.spawn.with_shell("xrandr --auto --output HDMI-A-1 --mode 2560x1440 --output DisplayPort-2 --mode 3440x1440 --rate 74.98 --left-of HDMI-A-1")
end

-- Read and commands from file and spawn them
--------------------------------------------------------------------------------
function autostart.run_from_file(file_)
	local f = io.open(file_)
	for line in f:lines() do
		if line:sub(1, 1) ~= "#" then awful.spawn.with_shell(line) end
	end
	f:close()
end

-- End
-----------------------------------------------------------------------------------------------------------------------
return autostart