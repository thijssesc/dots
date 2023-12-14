-- harpoon

local M = {
    'ThePrimeagen/harpoon',
    name = 'harpoon',
    version = false,
}

M.opts = function()
    local build_cmd = 'mvn clean install -Dmaven.javadoc.skip -Dmaven.test.skip'
    local run_cmd = 'mvn -Pcargo.run -Drepo.path=./storage -Dcargo.jvm.args="-Xmx4g"'
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

    return {
      global_settings = {
          save_on_toggle = true,
          save_on_change = true,
      },
      projects = projects,
  }
end

M.keys = {
    { '<C-q>', [[<cmd>lua require('harpoon.mark').add_file()<CR>]] },
    { '<C-p>', [[<cmd>lua require('harpoon.mark').rm_file()<CR>]] },
    { '<leader>hh', [[<cmd>lua require('harpoon.ui').nav_file(1)<CR>]] },
    { '<leader>jj', [[<cmd>lua require('harpoon.ui').nav_file(2)<CR>]] },
    { '<leader>kk', [[<cmd>lua require('harpoon.ui').nav_file(3)<CR>]] },
    { '<leader>ll', [[<cmd>lua require('harpoon.ui').nav_file(4)<CR>]] },
    { '<leader>s1', [[<cmd>lua require('harpoon.term').sendCommand(1, 1)<CR>]] },
    { '<leader>s2', [[<cmd>lua require('harpoon.term').sendCommand(1, 2)<CR>]] },
    { '<leader>tt', [[<cmd>lua require('harpoon.term').gotoTerminal(1)<CR>]] },
    { '<leader>tr', [[<cmd>lua require('harpoon.term').gotoTerminal(2)<CR>]] },
    { '<leader>te', [[<cmd>lua require('harpoon.term').gotoTerminal(3)<CR>]] },
}

return M
