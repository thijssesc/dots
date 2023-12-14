-- java lsp

local M = {
    'mfussenegger/nvim-jdtls',
    name = 'jdtls',
    version = false,
    ft = { 'java' },
}

M.dependencies = {
    require('thijssesc.plugins.dap'),
    require('thijssesc.plugins.mason'),
}

M.opts = function()
    local jdtls = require('jdtls')

    return {
        settings = {
            java = {
                signatureHelp = { enabled = true },
                contentProvider = { preferred = 'fernflower' },
                completion = {
                    favoriteStaticMembers = {
                        'org.junit.jupiter.api.Assertions.*',
                        'java.util.Objects.requireNonNull',
                        'java.util.Objects.requireNonNullElse',
                        'org.mockito.Matchers.*',
                        'org.mockito.Mockito.*',
                    },
                },
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999,
                    },
                },
                codeGeneration = {
                    toString = {
                        template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
                    },
                    hashCodeEquals = {
                        useJava7Objects = true,
                    },
                    useBlocks = true,
                },
                format = {
                    settings = {
                        url = os.getenv('HOME') .. '/.config/nvim/language-servers/hppo-eclipse-formatting-1.0.xml',
                        profile = 'Hippo-eclipse-formatting',
                    },
                },
                configuration = {
                    maven = {
                        globalSettings = os.getenv('XDG_CONFIG_HOME') .. '/maven/settings.xml',
                    },
                    runtimes = {
                        {
                            name = 'JavaSE-11',
                            path = '/usr/lib/jvm/java-11-openjdk/',
                        },
                        {
                            name = 'JavaSE-17',
                            path = '/usr/lib/jvm/java-17-openjdk/',
                        },
                    },
                },
            },
        },

        root_dir = jdtls.setup.find_root { '.git', 'mvnw', 'gradlew' },

        project_name = function(root_dir)
          return root_dir and vim.fs.basename(root_dir)
        end,

        config_dir = function(project_name)
          return vim.fn.stdpath('cache') .. '/jdtls/' .. project_name .. '/config'
        end,

        workspace_dir = function(project_name)
          return vim.fn.stdpath('cache') .. '/jdtls/' .. project_name .. '/workspace'
        end,

        cmd = { vim.fn.exepath('jdtls') },
        full_cmd = function(opts)
            local project_name = opts.project_name(opts.root_dir)
            local cmd = vim.deepcopy(opts.cmd)

            if project_name then
                vim.list_extend(cmd, {
                    '-configuration', opts.config_dir(project_name),
                    '-data', opts.workspace_dir(project_name),
                })
            end

            return cmd
        end,
    }
end

M.config = function(_, opts)
    local jdtls = require('jdtls')
    local jdtls_dap = require('jdtls.dap')

    local mason_registry = require('mason-registry')
    local bundles = {}
    if mason_registry.is_installed('java-debug-adapter') then
        local java_dbg_pkg = mason_registry.get_package('java-debug-adapter')
        local java_dbg_path = java_dbg_pkg:get_install_path()
        local jar_patterns = {
            java_dbg_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar',
        }

        if mason_registry.is_installed('java-test') then
            local java_test_pkg = mason_registry.get_package('java-test')
            local java_test_path = java_test_pkg:get_install_path()
            vim.list_extend(jar_patterns, {
                java_test_path .. '/extension/server/*.jar',
            })
        end

        for _, jar_pattern in ipairs(jar_patterns) do
            for _, bundle in ipairs(vim.split(vim.fn.glob(jar_pattern), '\n')) do
                table.insert(bundles, bundle)
            end
        end
    end

    local attach_jdtls = function()
        local config = {
            cmd = opts.full_cmd(opts),
            root_dir = opts.root_dir,
            init_options = {
                bundles = bundles,
            },
            settings = opts.settings,
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
        }

        jdtls.start_or_attach(config)
    end

    vim.api.nvim_create_autocmd('FileType', {
        pattern = M.ft,
        callback = attach_jdtls,
    })

    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
            jdtls.setup_dap()

            local buffer = ev.buf
            vim.keymap.nnoremap { '<leader>df', jdtls.test_class, { buffer = buffer } }
            vim.keymap.nnoremap { '<leader>dn', jdtls.test_nearest_method, { buffer = buffer } }
            vim.keymap.nnoremap { '<leader>dp', jdtls.pick_test, { buffer = buffer } }
            vim.keymap.nnoremap { '<leader>ec', jdtls.extract_constant, { buffer = buffer } }
            vim.keymap.nnoremap { '<leader>ev', jdtls.extract_variable, { buffer = buffer } }
            vim.keymap.nnoremap { '<leader>oi', jdtls.organize_imports, { buffer = buffer } }
            vim.keymap.vnoremap { '<leader>ec', "<esc><cmd>lua require('jdtls').extract_constant()", { buffer = buffer } }
            vim.keymap.vnoremap { '<leader>em', "<esc><cmd>lua require('jdtls').extract_method(true)<CR>", { buffer = buffer } }
            vim.keymap.vnoremap { '<leader>ev', "<esc><cmd>lua require('jdtls').extract_variable(true)", { buffer = buffer } }

            vim.keymap.nnoremap { '<leader>tc', jdtls_dap.test_class, { buffer = buffer } }
            vim.keymap.nnoremap { '<leader>tn', jdtls_dap.test_nearest_method, { buffer = buffer } }
            vim.keymap.nnoremap { '<leader>tf', jdtls_dap.pick_test, { buffer = buffer } }
        end
    })

    attach_jdtls()
end

return M
