-- theme

local gfs = require('gears.filesystem')
local xresources = require('beautiful.xresources')

local current_theme = xresources.get_current_theme()
local themes_path = gfs.get_themes_dir()

local theme = {
    font = 'RobotoMono 11',

    bg_normal = current_theme.background,
    bg_focus = current_theme.color4,
    bg_urgent = current_theme.background,
    bg_minimize = current_theme.background,

    fg_normal = current_theme.foreground,
    fg_focus = current_theme.foreground,
    fg_urgent = current_theme.foreground,
    fg_minimize = current_theme.foreground,

    useless_gap = xresources.apply_dpi(5),
    border_width = xresources.apply_dpi(3),
    border_normal = current_theme.background,
    border_focus = current_theme.color4,
    border_marked = current_theme.background,

    notification_bg = current_theme.color4,
    notification_fg = current_theme.foreground,
    nofification_border_color = current_theme.background,

    layout_floating = themes_path .. 'default/layouts/floatingw.png',
    layout_max = themes_path .. 'default/layouts/maxw.png',
    layout_tile = themes_path .. 'default/layouts/tilew.png',
    wallpaper = '/home/sjoerd/Pictures/walls/bck.jpg',
}

return theme
