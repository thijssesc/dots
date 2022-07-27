-- java lsp

local jdtls = require('jdtls')
local on_attach = require('thijssesc.plugins.lsp.on_attach')

local M = {}

M.on_jdtls_attach = function(client, buffer)
    on_attach(client, buffer)

    jdtls.setup_dap()
    jdtls.setup.add_commands()

    vim.keymap.nnoremap { '<leader>df', jdtls.test_class, { buffer = buffer } }
    vim.keymap.nnoremap { '<leader>dn', jdtls.test_nearest_method, { buffer = buffer } }
    vim.keymap.nnoremap { '<leader>dp', jdtls.pick_test, { buffer = buffer } }
    vim.keymap.nnoremap { '<leader>ec', jdtls.extract_constant, { buffer = buffer } }
    vim.keymap.nnoremap { '<leader>ev', jdtls.extract_variable, { buffer = buffer } }
    vim.keymap.nnoremap { '<leader>oi', jdtls.organize_imports, { buffer = buffer } }
    vim.keymap.vnoremap { '<leader>ec', "<esc><cmd>lua require('jdtls').extract_constant()", { buffer = buffer } }
    vim.keymap.vnoremap { '<leader>em', "<esc><dmd>lua require('jdtls').extract_method(true)<CR>", { buffer = buffer } }
    vim.keymap.vnoremap { '<leader>ev', "<esc><cmd>lua require('jdtls').extract_variable(true)", { buffer = buffer } }
end

M.on_init = function(client)
    if client.config.settings then
        client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
    end
end

M.setup = function()
    local root_dir = jdtls.setup.find_root { '.git', 'mvnw', 'gradlew' }
    local home = os.getenv('HOME')

    local jar_patterns = {
        '/Software/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
        '/Software/vscode-java-decompiler/server/*.jar',
        '/Software/vscode-java-test/server/*.jar',
    }
    local bundles = {}
    for _, jar_pattern in ipairs(jar_patterns) do
        for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
            if not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
                table.insert(bundles, bundle)
            end
        end
    end

    local capabilities = {
        workspace = {
            configuration = true,
        },
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true,
                },
            },
        },
    }

    local extendedClientCapabilities = jdtls.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    local settings = {
        java = {
            signatureHelp = { enabled = true },
            contentProvider = { preferred = 'fernflower' },
            completion = {
                favoriteStaticMembers = {
                    -- 'org.hamcrest.MatcherAssert.assertThat',
                    -- 'org.hamcrest.Matchers.*',
                    -- 'org.hamcrest.CoreMatchers.*',
                    'org.junit.jupiter.api.Assertions.*',
                    -- 'java.util.Objects.requireNonNull',
                    -- 'java.util.Objects.requireNonNullElse',
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
                    url = home .. '/.config/nvim/language-servers/hppo-eclipse-formatting-1.0.xml',
                    profile = 'Hippo-eclipse-formatting',
                },
            },
            configuration = {
                runtimes = {
                    {
                        name = 'JavaSE-1.8',
                        path = '/usr/lib/jvm/java-8-openjdk/',
                    },
                    {
                        name = 'JavaSE-11',
                        path = '/usr/lib/jvm/java-11-openjdk/',
                    },
                },
            },
        },
    }

    local workspace_folder = home .. '/.cache/workspace/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')
    local eclipse_folder = home .. '/Software/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository'
    jdtls.start_or_attach {
        cmd = {
            '/usr/lib/jvm/java-11-openjdk/bin/java',
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-Xms1g',
            '--add-modules=ALL-SYSTEM',
            '--add-opens',
            'java.base/java.util=ALL-UNNAMED',
            '--add-opens',
            'java.base/java.lang=ALL-UNNAMED',
            '-jar',
            eclipse_folder .. '/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
            '-configuration',
            eclipse_folder .. '/config_linux',
            '-data',
            workspace_folder,
        },
        root_dir = root_dir,
        on_attach = M.on_jdtls_attach,
        on_init = M.on_init,
        filetypes = { 'java' },
        flags = {
            debounce_text_changes = 150,
            service_side_fuzzy_completion = true,
        },
        init_options = {
            bundles = bundles,
            extendedClientCapabilities = extendedClientCapabilities,
        },
        capabilities = capabilities,
        settings = settings,
    }
end

return M
