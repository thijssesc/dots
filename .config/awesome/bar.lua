-- bar

local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local text_layoutbox = require('text_layoutbox')
local wibox = require('wibox')

local M = {}

local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        gears.wallpaper.maximized(wallpaper, s, false)
    end
end

function M.setup(s)
    set_wallpaper(s)
    awful.tag(
        { ' ☰ ', ' ☲ ', ' ☱ ', ' ☴ ', ' ☵ ', ' ☶ ', ' ☳ ', ' ☷ ', ' ☰ ' },
        s,
        awful.layout.layouts[1]
    )

    local layout_box = text_layoutbox(s)
    layout_box:buttons(gears.table.join(
        awful.button({}, 1, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 3, function()
            awful.layout.inc(-1)
        end)
    ))

    local taglist_buttons = gears.table.join(awful.button({}, 1, function(t)
        t:view_only()
    end))
    local taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.noempty,
        buttons = taglist_buttons,
    }

    local separator = wibox.widget {
        widget = wibox.widget.separator,
        orientation = 'vertical',
        forced_width = 24,
    }
    local empty_separator = wibox.widget {
        widget = wibox.widget.separator,
        orientation = 'vertical',
        forced_width = 12,
        shape = '',
    }

    local callback = function(widget, stdout)
        widget:set_markup_silently(stdout)
    end

    local volume = awful.widget.watch('swb volume', 1, callback)
    local memory = awful.widget.watch('swb memory', 1, callback)
    local disk = awful.widget.watch('swb disk', 1, callback)
    local cpu = awful.widget.watch('swb cpu', 1, callback)
    local wifi = awful.widget.watch('swb wifi', 1, callback)
    local openvpn = awful.widget.watch('swb openvpn', 5, callback)
    local battery = awful.widget.watch('swb battery', 5, callback)
    local date = awful.widget.watch('swb datee', 5, callback)
    local time = awful.widget.watch('swb timee', 1, callback)

    local layout = wibox.layout.fixed.horizontal()
    layout:add(volume)
    layout:add(separator)
    layout:add(memory)
    layout:add(separator)
    layout:add(disk)
    layout:add(separator)
    layout:add(cpu)
    layout:add(separator)
    layout:add(wifi)
    layout:add(separator)
    layout:add(openvpn)
    layout:add(separator)
    layout:add(battery)
    layout:add(separator)
    layout:add(date)
    layout:add(separator)
    layout:add(time)
    layout:add(empty_separator)

    local bg = wibox.container.background()
    bg.widget = layout

    s.bar = awful.wibar {
        position = 'top',
        height = 24,
        screen = s,
    }

    s.bar:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            taglist,
            layout_box,
        },
        { layout = wibox.layout.fixed.horizontal },
        bg,
    }
end

return M
