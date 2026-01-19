-- lua/plugins.alpha.lua
return {
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")


      dashboard.section.header.val = {
        [[ __                        ]],
        [[/\ \                       ]],
        [[\ \ \___   __  __     __   ]],
        [[ \ \  _ `\/\ \/\ \  /'__`\ ]],
        [[  \ \ \ \ \ \ \_\ \/\  __/ ]],
        [[   \ \_\ \_\ \____/\ \____\]],
        [[    \/_/\/_/\/___/  \/____/]],
      }

      -- Set the header color to your shell's orange
      vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#ef5f06" })
      dashboard.section.header.opts.hl = "AlphaHeader"

      -- Dashboard Menu Actions
      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
        dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
        dashboard.button("p", "  Projects", ":Telescope neovim-project discover <CR>"),
        dashboard.button("r", "  Recent Files", ":Telescope oldfiles <CR>"),
        dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
        dashboard.button("q", "󰩈  Quit", ":qa<CR>"),
      }

      -- Custom Footer using your _G.env_type
      local v = vim.version()
      local env = _G.env_type or "Unknown"
      dashboard.section.footer.val = "v" .. v.major .. "." .. v.minor .. "." .. v.patch .. "  |  Env: " .. env
      dashboard.section.footer.opts.hl = "Comment"

      alpha.setup(dashboard.opts)
    end,
  },
}
