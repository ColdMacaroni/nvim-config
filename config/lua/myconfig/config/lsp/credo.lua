-- Metadata
-- languages: elixir
-- url: http://credo-ci.org/
--
-- Config adapted from https://www.mitchellhanberg.com/how-to-set-up-neovim-for-elixir-development/

local sourceText = require("efmls-configs.utils").sourceText
local fs = require "efmls-configs.fs"

-- Needs to be run like `mix credo`
local linter = "mix"
local bin = fs.executable(linter)
local args = "credo suggest --format=flycheck --read-from-stdin '${INPUT}'"
local command = string.format("MIX_ENV=test %s %s", bin, args)

return {
  prefix = "credo",
  lintSource = sourceText(linter),
  lintCommand = command,
  lintStdin = true,
  lintFormats = {
    "%f:%l:%c: %t: %m",
    "%f:%l: %t: %m",
  },
  lintCategoryMap = {
    R = "N",
    D = "I",
    F = "E",
    W = "W",
  },
  lintIgnoreExitCode = true,
  rootMarkers = {
    "mix.exs",
    "mix.lock",
  },
}
