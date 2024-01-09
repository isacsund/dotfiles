-- Bootstrapping {{{1
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
-- }}}1

local plugins = {
    -- Dependencies of other plugins
    "nvim-lua/plenary.nvim",

    ------------------------
    -- General Enhancements
    ------------------------
    -- Filetree
    "kyazdani42/nvim-tree.lua",
    -- Commenting
    "numToStr/Comment.nvim",
    -- Syntax highlighting
    { "nvim-treesitter/nvim-treesitter",  build = ":TSUpdate" },
    -- Git in sign column
    "lewis6991/gitsigns.nvim",
    -- Git UI
    "sindrets/diffview.nvim",
    -- Faster startup
    "lewis6991/impatient.nvim",
    -- Search and replace in multiple files
    "windwp/nvim-spectre",

    ---------------------
    -- LSP and Completion
    ---------------------
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        dependencies = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lua" },
            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
    },
    -----------------------
    -- Visual Enhancements
    -----------------------
    -- Color theme
    {
        "mcchrish/zenbones.nvim",
        dependencies = {
            { "rktjmp/lush.nvim" },
        },
    },
    -- Icons
    "kyazdani42/nvim-web-devicons",
    -- Status line
    "nvim-lualine/lualine.nvim",
    -- Diagnostics
    "folke/trouble.nvim",
    -- TODO comments
    "folke/todo-comments.nvim",
    -- Automatic word highlighting
    "RRethy/vim-illuminate",
    -- Buffer bar
    "akinsho/bufferline.nvim",
    -- Mini
    "echasnovski/mini.nvim",
}

require("lazy").setup(plugins, {})

----------
-- General
----------
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

-- Colorscheme
vim.o.background = "dark"
vim.o.termguicolors = true

vim.g.zenbones_darkness = "stark"
vim.g.zenbones_italic_comments = false

vim.cmd([[colorscheme zenbones]])

-- Override italics for strings and numbers
local lush = require("lush")
local specs = lush.parse(function()
  return {
    Constant { base.Constant, gui = '' },
    Number { base.Number, gui = '' },
  }
end)
lush.apply(lush.compile(specs))

----------
-- Keymaps
----------

-- Wrapper functions {{{1
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
-- }}}1

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

-- Switch bufferline buffers
nnoremap("<Leader>H", ":BufferPrevious<CR>")
nnoremap("<Leader>L", ":BufferNext<CR>")

-- Trouble
nnoremap("<leader>xx", "<cmd>Trouble<cr>")
nnoremap("<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
nnoremap("<leader>xd", "<cmd>Trouble document_diagnostics<cr>")

-- NvimTree
nnoremap("<C-n>", ":NvimTreeToggle<CR>")

-- nvim-spectre
nnoremap("<leader>sr", "<cmd>lua require('spectre').open()<CR>")

-- vim-illuminate
nnoremap("[[", "<cmd>lua require('illuminate').goto_next_reference()<CR>")
nnoremap("]]", "<cmd>lua require('illuminate').goto_prev_reference()<CR>")

-- No arrow keys
nnoremap("<up>", "<nop>")
nnoremap("<down>", "<nop>")
nnoremap("<left>", "<nop>")
nnoremap("<right>", "<nop>")
inoremap("<up>", "<nop>")
inoremap("<down>", "<nop>")
inoremap("<left>", "<nop>")
inoremap("<right>", "<nop>")

----------
-- Plugins
----------

---------------------------------
-- Editing echancements and tools
------------------------
require("nvim-tree").setup()
-- Enable Comment.nvim
require("Comment").setup({})

-- LSP
-- nvim-treesitter
require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
})

local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.on_attach(function(client, bufnr)
    nmap("<leader>rn", vim.lsp.buf.rename)
    nmap("<leader>ca", vim.lsp.buf.code_action)

    nmap("gd", vim.lsp.buf.definition)
    nmap("gi", vim.lsp.buf.implementation)

    nmap("K", vim.lsp.buf.hover)
    nmap("<C-k>", vim.lsp.buf.signature_help)

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration)
    nmap("<leader>D", vim.lsp.buf.type_definition)

    nmap("<leader>f", vim.lsp.buf.format)
end)

lsp.ensure_installed({
    "bashls",
    "clangd",
    "pyright",
    "rust_analyzer",
    "zls",
})

-- pyright
lsp.use("pyright", {
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off",
            },
        },
    },
})

lsp.use("rust_analyzer", {
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy",
            },
            completion = {
                autoimport = {
                    enable = true,
                },
            },
        },
    },
})

lsp.nvim_workspace()
lsp.setup()

-- UI + utils
-- bufferline
require("bufferline").setup({})

-- mini.nvim.trailspace
require("mini.trailspace").setup({})

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
    signs = {
        -- icons / text used for a diagnostic
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info",
    },
})
