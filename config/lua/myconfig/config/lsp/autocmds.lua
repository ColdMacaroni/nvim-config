-- For autocmds related to lsp stuff

-- From https://github.com/lvimuser/lsp-inlayhints.nvim
vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_inlayhints",
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    require("lsp-inlayhints").setup()
    require("lsp-inlayhints").on_attach(client, bufnr)
  end,
})

-- {{{ LSP keybinds
--  AutoCMD from lspconfig readme.md, hotkeys and such modified by me
local wk = require "which-key"
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }

    wk.register({
      q = { vim.diagnostic.open_float, "Floating diagnostic" },
    }, { prefix = "<leader>" })

    wk.register {
      ["]d"] = { vim.diagnostic.goto_next, "Next diagnostic" },
      ["[d"] = { vim.diagnostic.goto_prev, "Prev diagnostic" },
      K = { vim.lsp.buf.hover, "LSP Hover", opts },
    }

    wk.register({
      name = "LSP",
      q = { vim.diagnostic.setloclist, "Set location list" },
      a = { vim.lsp.buf.code_action, "Code action", opts },
      r = { "<cmd>Telescope lsp_references<cr>", "References", opts },
      w = {
        name = "Workspace folders",
        a = { vim.lsp.buf.add_workspace_folder, "Add folder", opts },
        r = { vim.lsp.buf.remove_workspace_folder, "Remove folder", opts },
        l = {
          function()
            local str = ""
            for i, v in ipairs(vim.lsp.buf.list_workspace_folders()) do
              str = str .. i .. ". " .. v .. "\n"
            end
            print(str)
          end,
          "List folders",
          opts,
        },
      },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document symbols", opts },
      S = { vim.lsp.buf.signature_help, "Signature help", opts },
      n = { vim.lsp.buf.rename, "Rename", opts },
      f = {
        function()
          vim.lsp.buf.format { async = true }
        end,
        "Format",
        opts,
      },
      d = { vim.lsp.buf.definition, "Definition", opts },
      D = { vim.lsp.buf.declaration, "Declaration", opts },
      i = { vim.lsp.buf.implementation, "Implementation", opts },
      t = { vim.lsp.buf.type_definition, "Type definition", opts },
      v = { require("telescope.builtin").diagnostics, "Diagnostics" },
    }, { prefix = "<leader>l" })
  end,
})
-- }}}
