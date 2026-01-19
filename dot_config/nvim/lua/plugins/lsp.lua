-- lua/plugins/lsp.lua
return {
  -- MASON & LSP
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = { "lua_ls", "bashls", "terraformls" },
      automatic_enable = true,
    },
    config = function(_, opts)
      require("mason-lspconfig").setup(opts)

      -- Global LSP Keymaps
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          local map = function(keys, func)
            vim.keymap.set('n', keys, func, { buffer = ev.buf })
          end
          map('gd', vim.lsp.buf.definition)
          map('K', vim.lsp.buf.hover)
          map('<leader>rn', vim.lsp.buf.rename)
          map('<leader>ca', vim.lsp.buf.code_action)
        end,
      })

      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            diagnostics = { globals = { 'vim' } },
          },
        },
      })
    end,
  },
  -- CONFORM (Formatting)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        sh = { "shfmt" },
        terraform = { "terraform_fmt" },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = true },
    },
  },

  -- NVIM-LINT (Linting)
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        sh = { "shellcheck" },
        terraform = { "tflint" },
      }

      -- Create an autocmd to trigger linting on save/enter
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
