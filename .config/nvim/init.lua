-- Packer {{{1
require("packer").startup(function(use)
    -- Package manager
    use({
        "wbthomason/packer.nvim",
    })
    -- Dependencies of other plugins
    use({
        "nvim-lua/plenary.nvim",
    })
    -- Faster startup
    use({
        "lewis6991/impatient.nvim",
    })

    -- Editing enchancements and tools
    use({
        "numToStr/Comment.nvim",
    })

    -- LSP + syntax
    use({
        "nvim-treesitter/nvim-treesitter",
    })
    use({
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    })
    use({
        "neovim/nvim-lspconfig",
    })
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
        },
    })
    use({
        "L3MON4D3/LuaSnip",
        requires = {
            "saadparwaiz1/cmp_luasnip",
        },
    })

    -- UI + utils
    use({
        "romgrk/barbar.nvim",
    })
    use({
        "echasnovski/mini.nvim",
    })
    use({
        "EdenEast/nightfox.nvim",
    })
    use({
        "nvim-lualine/lualine.nvim",
    })
    use({
        "lewis6991/gitsigns.nvim",
    })
    use({
        "folke/trouble.nvim",
    })
    use({
        "jose-elias-alvarez/null-ls.nvim",
    })
end)
-- }}}1

-- General {{{1
-- Use space as leader key
vim.g.mapleader = " "

-- Enable syntax highlighting
vim.o.syntax = "enable"

-- Do not wrap long lines
vim.o.wrap = false

-- Allow hidden buffers
vim.o.hidden = true

-- Use utf-8
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"

-- Better display for messages
vim.o.cmdheight = 2

-- Faster diagnostic messages
vim.o.updatetime = 300

-- Enable mouse usage (all modes) in terminals
vim.o.mouse = "a"

-- Sane splits
vim.o.splitbelow = true
vim.o.splitright = true

-- Tabs as 4 spaces
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smarttab = true
vim.o.expandtab = true

-- Auto indent
vim.o.smartindent = true
vim.o.autoindent = true

-- Show line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Show column
vim.o.colorcolumn = "100"

-- Prevent buffer moving when adding/deleting sign.
vim.o.signcolumn = "yes"

-- Indicate that a dark background should be used
vim.o.background = "dark"

-- Always use system clipboard
vim.o.clipboard = "unnamedplus"

-- Enable colors in the terminal UI
vim.o.termguicolors = true

-- Permanent undo
vim.o.undodir = os.getenv("HOME") .. "/.vimdid"
vim.o.undofile = true

-- Decent wildmenu
vim.o.wildmenu = true
vim.o.wildmode = "list:longest"

-- Show whitespace characters
vim.opt.listchars = {
    space = "⋅",
    tab = "__",
    trail = "•",
    extends = "❯",
    precedes = "❮",
    nbsp = "_",
}
vim.o.list = true

-- Enable folding
vim.o.foldmethod = "marker"

-- Barbar
vim.g.bufferline = {
    icons = false,
    icon_close_tab = "x",
}

-- Colorscheme
vim.o.termguicolors = true
vim.cmd([[colorscheme terafox]])
-- }}}1

-- Keymaps {{{1
-- Wrapper functions {{{2
local nnoremap = function(lhs, rhs, silent)
    vim.keymap.set("n", lhs, rhs, { noremap = true, silent = silent })
end

local inoremap = function(lhs, rhs)
    vim.keymap.set("i", lhs, rhs, { noremap = true })
end

local nmap = function(lhs, rhs)
    vim.keymap.set("n", lhs, rhs, {})
end

local map = function(lhs, rhs)
    vim.keymap.set("", lhs, rhs, {})
end
-- }}}2

-- Quick-save
nmap("<leader>w", ":w<CR>")

-- Quickly insert an empty new line without entering insert mode
nnoremap("<Leader>o", "o<Esc>")
nnoremap("<Leader>O", "O<Esc>")

-- Jump to start and end of line using the home row keys
map("H", "^")
map("L", "$")

-- <Leader><Leader> toggles between buffers
nnoremap("<Leader><Leader>", "<c-^>")

-- Move by line
nnoremap("j", "gj")
nnoremap("k", "gk")

-- Switch barbar buffers
nnoremap("<Leader>H", ":BufferPrevious<CR>")
nnoremap("<Leader>L", ":BufferNext<CR>")

-- Trouble
nnoremap("<leader>xx", "<cmd>Trouble<cr>")
nnoremap("<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
nnoremap("<leader>xd", "<cmd>Trouble document_diagnostics<cr>")

-- No arrow keys
nnoremap("<up>", "<nop>")
nnoremap("<down>", "<nop>")
nnoremap("<left>", "<nop>")
nnoremap("<right>", "<nop>")
inoremap("<up>", "<nop>")
inoremap("<down>", "<nop>")
inoremap("<left>", "<nop>")
inoremap("<right>", "<nop>")
-- }}}1

-- Plugins {{{1
require("impatient")

-- Editing enchancements and tools {{{2
-- Enable Comment.nvim
require("Comment").setup()
-- }}}2

-- LSP + syntax {{{2
-- nvim-treesitter
require("nvim-treesitter.configs").setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
        "lua",
        "python",
        "rust",
    },
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
})

-- nvim-lspconfig
local on_attach = function(_, bufnr)
    nmap("<leader>rn", vim.lsp.buf.rename)
    nmap("<leader>ca", vim.lsp.buf.code_action)

    nmap("gd", vim.lsp.buf.definition)
    nmap("gi", vim.lsp.buf.implementation)

    nmap("K", vim.lsp.buf.hover)
    nmap("<C-k>", vim.lsp.buf.signature_help)

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration)
    nmap("<leader>D", vim.lsp.buf.type_definition)

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(
        bufnr,
        "Format",
        vim.lsp.buf.format or vim.lsp.buf.formatting,
        { desc = "Format current buffer with LSP" }
    )

    nmap("<leader>f", vim.lsp.buf.format)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Ensure the servers are installed
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd",
        "pyright",
        "rust_analyzer",
        "sumneko_lua",
    },
})

-- pyright
require("lspconfig").pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off",
            },
        },
    },
})
-- rust_analyzer
require("lspconfig").rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
            },
        },
    },
})

-- sumneko
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").sumneko_lua.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you"re using (most likely LuaJIT)
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path,
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        },
    },
})

-- clangd
require("lspconfig").clangd.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

-- nvim-cmp
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = {
        completeopt = "menu,menuone,noinsert",
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "path" },
        { name = "buffer", keyword_length = 8 },
    },
    experimental = {
        ghost_text = true,
    },
})
-- }}}2

-- UI + utils {{{2
-- barbar.nvim
vim.g.bufferline = {
    icons = false,
    icon_close_tab = "x",
}

-- mini.nvim.trailspace
require("mini.trailspace").setup()

-- lualine.nvim
require("lualine").setup({
    options = {
        theme = "auto",
        icons_enabled = false,
    },
})

-- gitsigns.nvim
require("gitsigns").setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
    },
})

-- trouble.nvim
require("trouble").setup({
    icons = false,
    fold_open = "v", -- icon used for open folds
    fold_closed = ">", -- icon used for closed folds
    indent_lines = false, -- add an indent guide below the fold icons
    signs = {
        -- icons / text used for a diagnostic
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info",
    },
    use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
})

-- null-ls
local null_ls = require("null-ls")
null_ls.setup({
    -- Diagnostics
    null_ls.builtins.diagnostics.shellcheck.with({
        diagnostics_format = "[#{c}] #{m} (#{s})",
    }),
    null_ls.builtins.diagnostics.pylint.with({
        diagnostics_format = "[#{c}] #{m} (#{s})",
    }),

    -- Formatting
    null_ls.builtins.formatting.shfmt.with({
        extra_args = { "-i", "4", "-sr", "-ci" },
    }),
    null_ls.builtins.formatting.stylua.with({
        extra_args = { "--indent-type", "Spaces" },
    }),

    -- Code actions
    null_ls.builtins.code_actions.shellcheck,
})

-- }}}2
-- }}}1
