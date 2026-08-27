return {
  {
    "EdenEast/nightfox.nvim",
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "dayFox",
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      -- 1. Ensure Snacks Explorer is turned on
      explorer = { enabled = true },

      -- 2. Move the explorer to the right side
      picker = {
        sources = {
          explorer = {
            layout = {
              layout = {
                position = "right",
              },
            },
          },
        },
      },
    },
  },
  -- 2. Modify trouble.nvim configuration
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
  },

  -- 3. Override nvim-cmp to add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- 4. Change telescope options and add a keymap
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- 5. Add custom LSP servers (Pyright)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
      },
    },
  },

  -- 6. Import LazyVim community extras
  { import = "lazyvim.plugins.extras.lang.typescript" },
  --{ import = "lazyvim.plugins.extras.ui.mini-starter" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.test.core" },

  -- 7. Add extra Treesitter parsers (safely extending defaults)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "bash",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        })
      end
    end,
  },

  -- 8. Add a custom component to Lualine
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },

  -- 9. Add standard tools to Mason
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "ruff",
      },
    },
  },

  -- 10. Git Diff & Merge Tool (Diffview)
  {
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview Open (Working Tree)" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview Close" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview File History (Current)" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview Branch History" },
    },
    opts = {
      enhanced_diff_highlight = true,
      use_icons = true,
      view = {
        default = {
          layout = "diff2_horizontal",
        },
        merge_tool = {
          layout = "diff3_horizontal",
          disable_diagnostics = true, -- Clean view during merge conflict resolution
        },
        file_history = {
          layout = "diff2_horizontal",
        },
      },
      file_panel = {
        listing_style = "tree",
        tree_options = {
          flatten_dirs = true,
          folder_statuses = "never",
        },
        win_config = {
          position = "left",
          width = 35,
        },
      },
      hooks = {
        diff_buf_read = function(bufnr)
          -- Ensure line numbers remain visible inside diff buffers
          vim.opt_local.number = true
          vim.opt_local.relativenumber = false
        end,
      },
    },
  },
}
