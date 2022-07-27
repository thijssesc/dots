-- keybindings

screen = screen or {} ---@diagnostic disable-line: lowercase-global

local awful = require('awful')
local beautiful = require('beautiful')
local gtable = require('gears.table')

local config = require('config')
local modkey = config.modkey

local clientkeys = gtable.join(
    awful.key({ modkey }, 'q', function(c)
        c:kill()
    end),
    awful.key({ modkey }, '[', function(c)
        c:kill()
    end),
    awful.key({ modkey, 'Shift' }, '[', function(c)
        c:move_to_screen(c.screen.index - 1)
    end),
    awful.key({ modkey, 'Shift' }, ']', function(c)
        c:move_to_screen()
    end),
    awful.key({ modkey, 'Shift' }, 'space', awful.client.floating.toggle)
)

local clientbuttons = gtable.join(
    awful.button({}, 1, function(c)
        c:emit_signal('request::activate', 'mouse_click', { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal('request::activate', 'mouse_click', { raise = true })
        c.floating = true
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal('request::activate', 'mouse_click', { raise = true })
        awful.layout.set(awful.layout.suit.floating)
        awful.mouse.client.resize(c)
    end)
)

local rules = {
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = false,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
            maximized = false,
        },
        callback = function(c)
            awful.client.setslave(c)
        end,
    },

    {
        rule_any = { floating = true },
        properties = {
            placement = awful.placement.centered + awful.placement.no_offscreen,
        },
    },

    {
        rule = { class = 'firefoxdeveloperedition' },
        properties = {
            tag = ' ☰ ',
            screen = screen[1],
        },
    },

    {
        rule_any = {
            class = { 'sun-awt-X11-XDialogPeer', 'jetbrains-idea' },
        },
        properties = {
            tag = screen.count() > 1 and ' ☲ ' or ' ☱ ',
            screen = screen[1],
        },
    },

    {
        rule_any = {
            instance = { 'nnnterm', 'tmuxterm' },
        },
        properties = {
            tag = ' ☲ ',
            screen = screen[3] or screen[1],
        },
    },

    {
        rule = { class = 'Slack' },
        properties = {
            tag = screen.count() > 1 and ' ☱ ' or ' ☴ ',
            screen = screen[3] or screen[1],
        },
    },

    {
        rule = { class = 'Google-chrome' },
        properties = {
            tag = screen.count() > 1 and ' ☰ ' or ' ☶ ',
            screen = screen[2] or screen[1],
        },
    },

    {
        rule = { class = 'Postman' },
        properties = {
            tag = screen.count() > 1 and ' ☶ ' or ' ☰ ',
            screen = screen[3] or screen[1],
        },
    },

    {
        rule_any = {
            instance = { 'rtorrentterm', 'sptterm' },
        },
        properties = {
            tag = screen.count() > 1 and ' ☴ ' or ' ☵ ',
            screen = screen[3] or screen[1],
        },
    },

    {
        rule = {
            class = 'qBittorrent',
            instance = 'qbittorrent',
        },
        properties = {
            tag = screen.count() > 1 and ' ☴ ' or ' ☴ ',
            screen = screen[3] or screen[1],
        },
    },
}

return rules
