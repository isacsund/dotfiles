-------------
-- LSP config
-------------

local lspconfig = require('lspconfig')

-- lsp_signature
-- https://github.com/ray-x/lsp_signature.nvim#full-configuration-with-default-values
local on_attach_lsp_signature = function(client)
  require('lsp_signature').on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      floating_window = true,
      handler_opts = {
        border = "single"
      },
      zindex = 99,     -- <100 so that it does not hide completion popup.
      fix_pos = false, -- Let signature window change its position when needed, see GH-53
    })
end

-- Customize LSP behavior
-- [[ A callback executed when LSP engine attaches to a buffer. ]]
local on_attach = function(client, bufnr)
  -- Always use signcolumn for the current buffer
  vim.wo.signcolumn = 'yes:1'

  -- Activate LSP signature on attach.
  on_attach_lsp_signature(client)

  -- Activate LSP status on attach (see a configuration below).
  require('lsp-status').on_attach(client)

  -- Keybindings
  -- https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
end

-- Register and activate LSP servers (managed by nvim-lsp-installer)
local builtin_lsp_servers = {
  -- List name of LSP servers that will be automatically installed and managed by :LspInstall.
  -- LSP servers will be installed locally at: ~/.local/share/nvim/lsp_servers
  'bashls',
  'pyright',
  'rust_analyzer',
}

-- Optional and additional LSP setup options other than (common) on_attach, capabilities, etc.
local lsp_setup_opts = {}

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = on_attach,

    -- Suggested configuration by nvim-cmp
    capabilities = require('cmp_nvim_lsp').update_capabilities(
     vim.lsp.protocol.make_client_capabilities()
    ),
  }

  -- Customize the options passed to the server
  opts = vim.tbl_extend("error", opts, lsp_setup_opts[server.name] or {})

  -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end)

-- Automatically install if a required LSP server is missing.
for _, lsp_name in ipairs(builtin_lsp_servers) do
  local ok, lsp = require('nvim-lsp-installer.servers').get_server(lsp_name)

  if ok and not lsp:is_installed() then
    vim.defer_fn(function()
      -- install with a UI so users can be notified
      lsp_installer.install(lsp_name)
    end, 0)
  end
end

-------------------------
-- LSP Handlers (general)
-------------------------
-- :help lsp-method
-- :help lsp-handler

local lsp_handlers_hover = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'single'
})
vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
  local bufnr, winnr = lsp_handlers_hover(err, result, ctx, config)
  if winnr ~= nil then
    vim.api.nvim_win_set_option(winnr, "winblend", 20)  -- opacity for hover
  end
  return bufnr, winnr
end

------------------
-- LSP diagnostics
------------------
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization

-- Customize how to show diagnostics:
vim.diagnostic.config({
  virtual_text = false,
  float = {
    source = 'always',
    focusable = false,   -- See neovim#16425
    border = 'single',
  },
})
_G.LspDiagnosticsShowPopup = function()
  return vim.diagnostic.open_float(0, {scope="cursor"})
end

-- Show diagnostics in a pop-up window on hover
_G.LspDiagnosticsPopupHandler = function()
  local current_cursor = vim.api.nvim_win_get_cursor(0)
  local last_popup_cursor = vim.w.lsp_diagnostics_last_cursor or {nil, nil}

  -- Show the popup diagnostics window,
  -- but only once for the current cursor location (unless moved afterwards).
  if not (current_cursor[1] == last_popup_cursor[1] and current_cursor[2] == last_popup_cursor[2]) then
    vim.w.lsp_diagnostics_last_cursor = current_cursor
    local _, winnr = _G.LspDiagnosticsShowPopup()
    if winnr ~= nil then
      vim.api.nvim_win_set_option(winnr, "winblend", 20)  -- opacity for diagnostics
    end
  end
end
vim.cmd [[
augroup LSPDiagnosticsOnHover
  autocmd!
  autocmd CursorHold *   lua _G.LspDiagnosticsPopupHandler()
augroup END
]]

-------------------------------
-- nvim-cmp: completion support
-------------------------------
-- https://github.com/hrsh7th/nvim-cmp#recommended-configuration
-- ~/.vim/plugged/nvim-cmp/lua/cmp/config/default.lua

vim.o.completeopt = "menu,menuone,noselect"

local cmp = require('cmp')
cmp.setup {
  snippet = {
    -- REQUIRED by nvim-cmp.
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  documentation = {
    border = {'╭', '─', '╮', '│', '╯', '─', '╰', '│'}  -- in a clockwise order
  },
   mapping = {
    -- Tab immediately completes. C-n/C-p to select.
    ['<Tab>'] = cmp.mapping.confirm({ select = true })
  },
  sources = {
    { name = 'nvim_lsp', priority = 100 },
    { name = 'path', priority = 30, },
    { name = 'buffer', priority = 10 },
  },
  experimental = {
    ghost_text = true
  },
}


------------
-- LSPstatus
------------
local lsp_status = require('lsp-status')
lsp_status.config({
    -- Avoid using use emoji-like or full-width characters
    -- because it can often break rendering within tmux and some terminals
    -- See ~/.vim/plugged/lsp-status.nvim/lua/lsp-status.lua
    indicator_errors = 'E',
    indicator_warnings = 'W',
    indicator_info = 'i',
    indicator_hint = '?',
    indicator_ok = 'Ok',

    -- Automatically sets b:lsp_current_function
    current_function = true,
})
lsp_status.register_progress()

-- LspStatus(): status string for airline
_G.LspStatus = function()
  if #vim.lsp.buf_get_clients() > 0 then
    return lsp_status.status()
  end
  return ''
end
