--signals

client = client or {} ---@diagnostic disable-line: lowercase-global
screen = screen or {} ---@diagnostic disable-line: lowercase-global

local beautiful = require('beautiful')

local M = {}

function M.setup()
    client.connect_signal('mouse::enter', function(c)
        c:emit_signal('request::activate', 'mouse_enter', { raise = true })
    end)

    client.connect_signal('focus', function(c)
        c.border_color = beautiful.border_focus
    end)
    client.connect_signal('unfocus', function(c)
        c.border_color = beautiful.border_normal
    end)

    screen.connect_signal('arrange', function(s)
        local max = s.selected_tag.layout.name == ' ⋈ '
        local only_one = #s.tiled_clients == 1

        for _, c in pairs(s.clients) do
            if (max or only_one) and not c.floating or c.maximixed then
                c.border_width = 0
            else
                c.border_width = beautiful.border_width
            end
        end
    end)
end

return M
