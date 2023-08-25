-- Template from https://github.com/mfussenegger/nvim-jdtls
-- local caps = require("coq").lsp_ensure_capabilities

local cmp_caps = require("cmp_nvim_lsp").default_capabilities()
local function caps(opts)
  return vim.tbl_deep_extend("keep", opts or {}, { capabilities = cmp_caps })
end

local function default_attach()
  return function(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = "lsp_document_highlight",
        buffer = 0,
        callback = vim.lsp.buf.document_highlight,
      })
    end
  end
end

local root_dir = vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]

if root_dir == nil then
  vim.notify("No root dir. RIP.")
  return
end

local config = {
  cmd = { "/usr/bin/jdtls" },
  root_dir = vim.fs.dirname(root_dir),
  settings = {
    java = caps {
      server_capabilities = {
        documentFormattingProvider = false,
        documentRangeFormattingProvider = false,
      },
      {
        signatureHelp = {
          enabled = true,
        },
        contentProvider = {
          preferred = "fernflower",
        },
      },

  on_attach = default_attach(),
    },
  },
}

require("jdtls").start_or_attach(config)
