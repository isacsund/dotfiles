local M = {}

function M.on_attach(client)
  require("lsp_signature").on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    floating_window = true,
    handler_opts = {
      border = "single",
    },
    zindex = 99, -- <100 so that it does not hide completion popup.
    fix_pos = false, -- Let signature window change its position when needed, see GH-53
    })
end

return M
