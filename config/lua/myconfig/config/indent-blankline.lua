local ibl = require "ibl"
ibl.setup()

local config = require "ibl.config".config

-- config.scope.char = ";"

local hooks = require "ibl.hooks"
hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

-- local highlights = {"IndentBlanklineChar"}
-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function() 
--
-- end)
--
-- {{{ AutoCMD: Make background lines darker
-- It will look kinda ugly in light themes but like that's your problem  ( ◕ ◡ ◕ ✿ )
-- vim.api.nvim_create_autocmd({ "ColorScheme" }, {
--   callback = function()
--     -- Can't do this from the nvim API
--     if vim.g.transparent_enabled then
--       vim.cmd "highlight IndentBlanklineChar guifg=#202020 gui=nocombine"
--     else
--       vim.cmd "highlight IndentBlanklineChar guifg=#303040 gui=nocombine"
--     end
--   end,
-- })
-- }}}
