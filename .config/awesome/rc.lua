pcall(require, 'luarocks.loader')

root = root or {} ---@diagnostic disable-line: lowercase-global

local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
require('awful.autofocus')

local config = require('config')
local bar = require('bar')
local errors = require('errors')
local keybindings = require('keybindings')
local rules = require('rules')
local signals = require('signals')

errors.startup_errors()
errors.runtime_errors()

beautiful.init(gears.filesystem.get_configuration_dir() .. '/theme.lua')

awful.layout.layouts = config.layouts

awful.screen.connect_for_each_screen(bar.setup)

root.keys(keybindings.global_keys)

awful.rules.rules = rules

signals.setup()

-- TODO:
-- other keymaps when using scylla/kyria keyboard
