local M = {}

function M.setup()
  local mason_ok, mason = pcall(require, "mason")
  if not mason_ok then
    vim.notify("mason.nvim not found!", vim.log.levels.ERROR)
    return
  end

  local mlsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not mlsp_ok then
    vim.notify("mason-lspconfig.nvim not found!", vim.log.levels.ERROR)
    return
  end

  mason.setup({
    ui = {
      border = "rounded",
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })

  -- mason-lspconfig: hanya memastikan terinstal.
  -- Aktivasi/konfigurasi dilakukan di lspconfig.lua via vim.lsp.config + vim.lsp.enable
  mason_lspconfig.setup({
    ensure_installed = {
      "lua_ls",
      "ts_ls", -- gunakan ts_ls (bukan tsserver)
      "eslint",
      "jsonls",
      "html",
      "cssls",
      "tailwindcss",
      "marksman",
      "yamlls",
      "vimls",
      "rust_analyzer",
      "gopls",
      "nimls",
      "intelephense",
      "emmet_ls",
      "jdtls",
    },
    -- Tidak perlu handlers lama berbasis lspconfig.setup
  })
end

return M
