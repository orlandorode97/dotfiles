return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- custom setup
    require("nvim-treesitter.configs").setup({
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "comment",
        "regex",
        "astro",
        "hurl",
      },
      auto_install = true,
    })
  end,
  opts = function(_, _)
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

    parser_config.hurl = {
      install_info = {
        url = "/Users/orlandoromo/tree-sitter-hurl",
        files = { "src/parser.c" },
        branch = "main",
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
      },
      filetype = "hurl",
    }

    vim.filetype.add({
      extension = {
        hurl = "hurl",
      },
    })
  end,
}
