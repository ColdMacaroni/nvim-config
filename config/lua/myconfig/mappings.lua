local wk = require "which-key"
vim.g.mapleader = " "

-- {{{ Non WhichKey
-- Disable highlighting
vim.keymap.set("n", "<Esc>", vim.cmd.nohlsearch, { silent = true })
-- }}}

-- NOTE: Harpoon is broken, binds commented out
-- TODO: Change the prefix = <leader> to the corresponding one. E.g. <leader>g
-- {{{ Nice terminal splitting: start_term(vsplit | split)
local function start_term(split_cmd)
  local prevbelow = vim.o.splitbelow
  vim.cmd(split_cmd .. " term://" .. vim.env.SHELL)
  -- Kill as soon as it's out of sight
  vim.bo.bufhidden = "wipe"

  vim.api.nvim_create_autocmd({ "TermClose" }, {
    buffer = vim.api.nvim_get_current_buf(),
    callback = function(args)
      -- If it is in fact hidden, then the previous option should handle it
      -- Thanks to https://old.reddit.com/r/neovim/comments/q5z38t/easiest_way_to_find_if_a_buffer_is_hidden/hggptam/
      if vim.fn.getbufinfo(args.buf)[1].hidden == 0 then
        vim.cmd "bwipeout"
      end
    end,
  })
end
-- }}}

-- {{{ Terminal starting
wk.register({
  v = {
    v = {
      function()
        start_term "vsplit"
      end,
      "Vertical terminal",
    },
  },
  h = {
    h = {
      function()
        start_term "split"
      end,
      "Horizontal terminal",
    },
  },
}, { prefix = "<leader>" })
-- }}}

-- {{{ Git
wk.register({
  name = "Git",
  -- Open fugitive to the right
  g = { "<cmd>vertical Git<cr>", "Fugitive" },
  a = { "<cmd>Git add %<cr>", "Add buffer" },
  c = { "<cmd>vertical Git commit -v<cr>", "Commit" },
  b = { "<cmd>Gitsigns blame_line<cr>", "Show blame" },
  d = { "<cmd>Telescope git_status<cr>", "Git diffs" },
  n = { "<cmd>Gitsigns next_hunk<cr>", "Next hunk" },
  p = { "<cmd>Gitsigns prev_hunk<cr>", "Prev hunk" },
}, { prefix = "<leader>g" })
-- }}}

-- {{{ Commenting
wk.register({
  ["/"] = {
    function()
      require("Comment.api").toggle.linewise.current()
    end,
    "Comment",
  },
}, { prefix = "<leader>" })

wk.register({
  ["/"] = {
    function()
      -- From the Comment.nvim documentation
      local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
      vim.api.nvim_feedkeys(esc, "nx", false)
      require("Comment.api").toggle.linewise(vim.fn.visualmode())
    end,
    "Comment",
  },
}, { mode = { "v" }, prefix = "<leader>" })
-- }}}

-- {{{ Toggles
wk.register({
  name = "Toggles",
  s = { "<cmd>set spell!<cr>", "Toggle spellcheck" },
}, { prefix = "<leader>t" })
---}}}

-- {{{ Telescope
-- This is lazy loaded, all actual things are in the config file.
wk.register({
    f = "Load Telescope"
}, { prefix = "<leader>" })
-- }}}

--[[ -- {{{ Harpoon
wk.register({
  name = "Harpoon",
  a = { require("harpoon.mark").add_file, "Add file" },
  m = { require("harpoon.ui").toggle_quick_menu, "Toggle menu" },
  n = { require("harpoon.ui").nav_next(), "Next file" },
  p = { require("harpoon.ui").nav_prev(), "Prev file" },
}, { prefix = "<leader>h" })
-- }}} ]]

-- {{{ DAP
-- Check :help dap-api
wk.register({
  name = "Debugging",
  b = { require("dap").toggle_breakpoint, "Toggle Breakpoint" },
  B = {
    function()
      require("dap").list_breakpoints(true)
    end,
    "List breakpoints",
  },
  e = { require("dap").set_exception_breakpoints, "Set exception breakpoints" },
  D = { require("dap").clear_breakpoints, "Clear breakpoints" },
  c = { require("dap").continue, "Continue" },
  s = { require("dap").step_over, "Step" },
  i = { require("dap").step_into, "Step in" },
  o = { require("dap").step_out, "Step out" },
  r = { require("dap").repl.toggle, "Toggle REPL" },
  h = { require("dap").run_to_cursor, "Run to cursor" },
  ["<Up>"] = { require("dap").up, "Stacktrace up" },
  ["<Down>"] = { require("dap").down, "Stacktrace down" },
  k = {
    function()
      require("dap").disconnect()
      require("dap").close()
    end,
    "Stop debugging",
  },
}, { prefix = "<leader>d" })
-- }}}

-- {{{ Easy window movement with ctrl
wk.register({
  ["<C-Up>"] = { "<C-w>k", "Go to the up window" },
  ["<C-Down>"] = { "<C-w>j", "Go to the down window" },
  ["<C-Left>"] = { "<C-w>h", "Go to the left window" },
  ["<C-Right>"] = { "<C-w>l", "Go to the right window" },
  ["<C-k>"] = { "<C-w>k", "Go to the up window" },
  ["<C-j>"] = { "<C-w>j", "Go to the down window" },
  ["<C-h>"] = { "<C-w>h", "Go to the left window" },
  ["<C-l>"] = { "<C-w>l", "Go to the right window" },
}, {})
-- }}}

-- {{{ Quick splits
wk.register({
  s = { vim.cmd.vsplit, "Vertical split" },
}, { mode = { "n" }, prefix = "<leader>v" })
wk.register({
  p = { vim.cmd.split, "Horizontal split" },
}, { mode = { "n" }, prefix = "<leader>s" })
-- }}}

-- {{{ Text moving
wk.register({
  ["<M-Down>"] = { ":move '>+1<cr>gv=gv", "Move lines down" },
  ["<M-Up>"] = { ":move '<-2<cr>gv=gv", "Move lines up" },
  ["<M-k>"] = { ":move '<-2<cr>gv=gv", "which_key_ignore" },
  ["<M-j>"] = { ":move '>+1<cr>gv=gv", "which_key_ignore" },
}, { mode = "v" })
wk.register({
  ["<M-Down>"] = { "V:move '>+1<cr>gv=gv", "Move lines down" },
  ["<M-Up>"] = { "V:move '<-2<cr>gv=gv", "Move lines up" },
  ["<M-k>"] = { "V:move '<-2<cr>gv=gv", "which_key_ignore" },
  ["<M-j>"] = { "V:move '>+1<cr>gv=gv", "which_key_ignore" },
}, { mode = "n" })
-- }}}

-- {{{ Loose mappings
wk.register({
  x = { "<cmd>Bdelete<cr>", "Delete buffer" },
  e = "Load NvimTree"
}, { prefix = "<leader>" })

wk.register({
  w = { "<cmd>WhichKey<cr>", "Open WhichKey" },
}, { mode = { "n", "v" }, prefix = "<leader>" })

-- }}}
