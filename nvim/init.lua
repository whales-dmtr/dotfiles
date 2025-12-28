require("options")
require("keymaps")
require("transparent")
require("autocmds")

-- Instal plugin manager (config/lazy.lua)
require("config.lazy")

-- Load all plugins from lua/plugins
require("lazy").setup("plugins")
