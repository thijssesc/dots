-- text_layoutbox

local awful = require('awful')
local wibox = require('wibox')

tag = tag or {} ---@diagnostic disable-line: lowercase-global

local text_layoutbox = { mt = {} }

local boxes = nil

local function update(w, screen)
    local name = awful.layout.getname(awful.layout.get(screen))
    w.textbox.text = name
end

local function update_from_tag(t)
    local w = boxes[t.screen]
    if w then
        update(w, t.screen)
    end
end

function text_layoutbox.new(screen)
    if boxes == nil then
        boxes = setmetatable({}, { __mode = 'kv' })
        tag.connect_signal('property::selected', update_from_tag)
        tag.connect_signal('property::layout', update_from_tag)
        tag.connect_signal('property::screen', function()
            for s, w in pairs(boxes) do
                if s.valid then
                    update(w, s)
                end
            end
        end)
        text_layoutbox.boxes = boxes
    end

    local w = boxes[screen]
    if not w then
        w = wibox.widget {
            {
                id = 'textbox',
                widget = wibox.widget.textbox,
            },
            layout = wibox.layout.fixed.horizontal,
        }

        update(w, screen)
        boxes[screen] = w
    end

    return w
end

function text_layoutbox.mt:__call(...)
    return text_layoutbox.new(...)
end

return setmetatable(text_layoutbox, text_layoutbox.mt)
