-- Metadata
-- languages: elixir
-- url: https://elixir-lang.org
local fs = require "efmls-configs.fs"

local program = "mix"
local command = string.format('%s format -', fs.executable(program))

return {
  formatCommand = command,
  formatStdin = true,
  rootMarkers = {
    ".formatter.exs",
  },
}
