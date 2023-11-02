local telescope = require "telescope"

telescope.setup {
  pickers = {
    colorscheme = {
      enable_preview = true,
    },
    project = {
      base_dirs = {
        { "~/projects", max_depth = 4 },
      },
      order_by = "recent",
      sync_with_nvim_tree = true,
    },
  },
}

telescope.load_extension "project"
telescope.load_extension "media_files"
telescope.load_extension "file_browser"
telescope.load_extension "ui-select"
-- telescope.load_extension('harpoon')
--

local tele = require "telescope"
local telebuilt = require "telescope.builtin"
local wk = require "which-key"
wk.register({
  name = "Telescope",
  f = { telebuilt.find_files, "Find files" },
  -- h = { "<cmd>Telescope harpoon marks<cr>", "Harpoon marks" },
  g = { telebuilt.live_grep, "Live grep" },
  a = { telebuilt.builtin, "Telescope builtins" },
  t = { telebuilt.treesitter, "Treesitter symbols" },
  q = { telebuilt.quickfix, "Quickfix" },
  l = { telebuilt.loclist, "Location list" },
  p = { telebuilt.oldfiles, "Previous files" },
  b = { telebuilt.buffers, "Open buffers" },
  j = { telebuilt.jumplist, "Jump list" },
  h = { telebuilt.help_tags, "Help tags" },
  m = { telebuilt.man_pages, "Man pages" },
  o = {
    function()
      tele.extensions.project.project { display_type = "full" }
    end,
    "Search projects",
  },
  d = { vim.cmd.TodoTelescope, "Find TODOs" },
  ["/"] = { telebuilt.current_buffer_fuzzy_find, "Fuzzy find" },
}, { prefix = "<leader>f" })
