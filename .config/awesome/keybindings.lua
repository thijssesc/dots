-- keybindings

awesome = awesome or {} ---@diagnostic disable-line: lowercase-global
client = client or {} ---@diagnostic disable-line: lowercase-global

local awful = require('awful')
local gears = require('gears')
local config = require('config')
local modkey = config.modkey

local M = {}

function M.focus_master()
    local current = client.focus
    local master = awful.client.getmaster()
    if current then
        client.focus = master
        master:raise()
    end
end

function M.view_only(i)
    local screen = awful.screen.focused()
    local tag = screen.tags[i]
    if tag then
        tag:view_only()
    end
end

function M.view_toggle(i)
    local screen = awful.screen.focused()
    local tag = screen.tags[i]
    if tag then
        awful.tag.viewtoggle(tag)
    end
end

function M.move_to_tag(i)
    if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
            client.focus:move_to_tag(tag)
        end
    end
end

function M.toggle_tag(i)
    if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
            client.focus:toggle_tag(tag)
        end
    end
end

function M.reset_mwfact()
    local focused = awful.screen.focused()
    focused.selected_tag.master_width_factor = 0.5
end

function M.move_to_all_tags()
    if client.focus then
        local focused = client.focus
        for _, tag in ipairs(client.focus.screen.tags) do
            focused:toggle_tag(tag)
        end
    end
end

function M.toggle_all_tags()
    local screen = awful.screen.focused()
    for _, tag in ipairs(screen.tags) do
        awful.tag.viewtoggle(tag)
    end
end

function M.toggle_bar()
    local screen = awful.screen.focused()
    screen.bar.visible = not screen.bar.visible
end

M.global_keys = gears.table.join(
    awful.key({ modkey }, 'p', function()
        awful.spawn(config.dmenucmd)
    end),
    awful.key({ modkey }, 'o', function()
        awful.spawn(config.termcmd)
    end),
    awful.key({ modkey, 'Shift' }, 'o', function()
        awful.spawn(config.termtmuxcmd)
    end),
    awful.key({ modkey }, 'b', M.toggle_bar),
    awful.key({ modkey }, 'j', function()
        awful.client.focus.byidx(1)
    end),
    awful.key({ modkey }, 'k', function()
        awful.client.focus.byidx(-1)
    end),
    awful.key({ modkey }, 'i', function()
        awful.tag.incnmaster(1, nil, true)
    end),
    awful.key({ modkey }, 'd', function()
        awful.tag.incnmaster(-1, nil, true)
    end),
    awful.key({ modkey }, 'l', function()
        awful.tag.incmwfact(0.05)
    end),
    awful.key({ modkey }, 'h', function()
        awful.tag.incmwfact(-0.05)
    end),
    awful.key({ modkey }, 'r', M.reset_mwfact),
    awful.key({ modkey }, [[\]], M.focus_master),
    awful.key({ modkey }, 'BackSpace', awful.tag.history.restore),
    awful.key({ modkey }, 't', function()
        awful.layout.set(awful.layout.suit.tile)
    end),
    awful.key({ modkey }, 'f', function()
        awful.layout.set(awful.layout.suit.floating)
    end),
    awful.key({ modkey }, 'm', function()
        awful.layout.set(awful.layout.suit.max)
    end),
    awful.key({ modkey }, 3, M.toggle_all_tags),
    awful.key({ modkey, 'Shift' }, 3, M.move_to_all_tags),
    awful.key({ modkey }, ';', function()
        awful.screen.focus_relative(-1)
    end),
    awful.key({ modkey }, [[']], function()
        awful.screen.focus_relative(1)
    end),
    awful.key({ modkey, 'Shift' }, 'q', awesome.restart)
)

for i, v in ipairs { '=', '-', '0', '9', '8', '7', '6', '5', '4' } do
    M.global_keys = gears.table.join(
        M.global_keys,
        awful.key({ modkey }, v, function()
            M.view_only(i)
        end),
        awful.key({ modkey, 'Control' }, v, function()
            M.view_toggle(i)
        end),
        awful.key({ modkey, 'Shift' }, v, function()
            M.move_to_tag(i)
        end),
        awful.key({ modkey, 'Control', 'Shift' }, v, function()
            M.toggle_tag(i)
        end)
    )
end

return M
