-- config

local awful = require('awful')

local config = {
    dmenucmd = { 'dma', '-c', '-l', '10' },
    termcmd = { 'tabbed', '-c', 'st', '-w' },
    termtmuxcmd = { 'st', '-e', 'tmux', '-2' },
    modkey = 'Mod1',
    layouts = {
        awful.layout.suit.tile,
        awful.layout.suit.max,
        awful.layout.suit.floating,
    },
}

awful.layout.suit.tile.name = ' ≦ '
awful.layout.suit.max.name = ' ⋈ '
awful.layout.suit.floating.name = ' ⋇ '

return config
