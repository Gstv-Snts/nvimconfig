local lsp_zero = require('lsp-zero')
local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()
lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)

    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        "clangd",
        "lua_ls",
        "tsserver",
    },
    handlers = {
        lsp_zero.default_setup,
    },
})

require 'lspconfig'.terraformls.setup {}
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.tf", "*.tfvars" },
    callback = function()
        vim.lsp.buf.format()
    end,
})

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ['<Tab>'] = cmp_action.luasnip_supertab(),
        ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    })
})
vim.diagnostic.config({
    virtual_text = true,
})

-- Show line diagnostics automatically in hover window
