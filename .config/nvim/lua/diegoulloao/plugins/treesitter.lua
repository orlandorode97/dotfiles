return {
  "nvim-treesitter/nvim-treesitter",
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })
  end,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- nvim 0.12 passes captures as node lists; master's directives expect a single node
    -- ponytail: remove once on nvim-treesitter `main`
    local function first(n) return type(n) == "table" and n[1] or n end
    vim.treesitter.query.add_directive("set-lang-from-info-string!", function(match, _, bufnr, pred, metadata)
      local node = first(match[pred[2]])
      if not node then return end
      local alias = vim.treesitter.get_node_text(node, bufnr):lower()
      local ft = vim.filetype.match({ filename = "a." .. alias })
      metadata["injection.language"] = ft or ({ ex = "elixir", pl = "perl", sh = "bash", uxn = "uxntal", ts = "typescript" })[alias] or alias
    end, { force = true })
    vim.treesitter.query.add_directive("downcase!", function(match, _, bufnr, pred, metadata)
      local node = first(match[pred[2]])
      if not node then return end
      metadata[pred[2]] = metadata[pred[2]] or {}
      metadata[pred[2]].text = vim.treesitter.get_node_text(node, bufnr, { metadata = metadata[pred[2]] }):lower()
    end, { force = true })
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
  opts = function(_, _) end,
}
