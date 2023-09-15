-- This file should be required before everything else
-- Extremely useful if anything needs to be fixed up, like plugins.
-- There should be a latefixes.lua file for stuff *after* everything's loaded.

-- {{{ vim-surround & leap compatibilty
-- This is from https://github.com/ggandor/leap.nvim/discussions/38#discussioncomment-4244471
vim.g.surround_no_mappings = 1

-- Just the defaults copied here.
vim.keymap.set("n", "ds", "<Plug>Dsurround")
vim.keymap.set("n", "cs", "<Plug>Csurround")
vim.keymap.set("n", "cS", "<Plug>CSurround")
vim.keymap.set("n", "ys", "<Plug>Ysurround")
vim.keymap.set("n", "yS", "<Plug>YSurround")
vim.keymap.set("n", "yss", "<Plug>Yssurround")
vim.keymap.set("n", "ySs", "<Plug>YSsurround")
vim.keymap.set("n", "ySS", "<Plug>YSsurround")

-- The conflicting ones. Note that `<Plug>(leap-cross-window)`
-- _does_ work in Visual mode, if jumping to the same buffer,
-- so in theory, `gs` could be useful for Leap too...
vim.keymap.set("x", "gs", "<Plug>VSurround")
vim.keymap.set("x", "gS", "<Plug>VgSurround")
-- }}}
