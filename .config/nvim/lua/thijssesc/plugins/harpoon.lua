-- harpoon

local harpoon = require('harpoon')
local mark = require('harpoon.mark')
local term = require('harpoon.term')
local ui = require('harpoon.ui')

local build_cmd = 'mvn clean install -Dmaven.javadoc.skip -Dmaven.test.skip'
local run_cmd = 'mvn -Pcargo.run -Drepo.path=./storage'
local projects = {}
for _, v in pairs { 1, 2, 3, 4, 5, 6 } do
    table.insert(projects, {
        ['$PROJECT' .. v] = {
            term = {
                cmds = {
                    build_cmd .. '\n',
                    build_cmd .. ' -Ptest-content && ' .. run_cmd .. '\n',
                },
            },
        },
    })
end

harpoon.setup {
    global_settings = {
        save_on_toggle = true,
        save_on_change = true,
    },
    projects = projects,
}

vim.keymap.nnoremap { '<C-p>', mark.add_file }
vim.keymap.nnoremap { '<C-q>', mark.rm_file }
vim.keymap.nnoremap {
    '<leader>hh',
    function()
        ui.nav_file(1)
    end,
}
vim.keymap.nnoremap {
    '<leader>jj',
    function()
        ui.nav_file(2)
    end,
}
vim.keymap.nnoremap {
    '<leader>kk',
    function()
        ui.nav_file(3)
    end,
}
vim.keymap.nnoremap {
    '<leader>ll',
    function()
        ui.nav_file(4)
    end,
}
vim.keymap.nnoremap {
    '<leader>s1',
    function()
        term.sendCommand(1, 1)
    end,
}
vim.keymap.nnoremap {
    '<leader>s2',
    function()
        term.sendCommand(1, 2)
    end,
}
vim.keymap.nnoremap {
    '<leader>tt',
    function()
        term.gotoTerminal(1)
    end,
}
vim.keymap.nnoremap {
    '<leader>tr',
    function()
        term.gotoTerminal(2)
    end,
}
vim.keymap.nnoremap {
    '<leader>te',
    function()
        term.gotoTerminal(3)
    end,
}
