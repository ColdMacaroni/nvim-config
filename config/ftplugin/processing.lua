-- Let's go gamers

local root_dir = vim.fs.dirname(vim.fs.find(function(name)
  return name:match ".*%.pde$"
end, { type = "file" })[0])

vim.lsp.start {
  name = "processing-lsp",
  cmd = { "/usr/share/processing/processing-lsp" },
  root_dir = root_dir,
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.pde" },
  callback = function()
    vim.cmd [[silent! !ctags --langmap=java:+.pde -R]]
  end,
})
