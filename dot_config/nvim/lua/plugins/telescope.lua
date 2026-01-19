-- lua/plugins.telescope.lua
return {
  {
    "coffebar/neovim-project",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      {
        "nvim-telescope/telescope.nvim",
        dependencies = {
          { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        }
      },
      { "Shatur/neovim-session-manager" },
    },
    lazy = false,
    priority = 100,
    opts = {
      projects = {
        "~/projects/*",
        "~/.config/*",
        "~/homelab/*",
      },
      patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "terraform.tfstate" },
    },
    init = function()
      -- Enable saving the session on exit
      vim.opt.sessionoptions:append("globals")
    end,
    config = function(_, opts)
      require("neovim-project").setup(opts)

      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = {
          path_display = { "truncate" },
          preview = {
            treesitter = false,
          },
        }
      })

      telescope.load_extension("fzf")
      telescope.load_extension("neovim-project")

      -- Keymaps for finder
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Grep Search" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })

      -- Keymaps for project discovery
      vim.keymap.set("n", "<leader>fp", ":Telescope neovim-project discover<CR>", { desc = "Discover Projects" })
      vim.keymap.set("n", "<leader>fr", ":Telescope neovim-project history<CR>", { desc = "Recent Projects" })
    end,
  },
}
