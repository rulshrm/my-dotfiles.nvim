local M = {}
local util = require "lspconfig.util"

-- Capabilities (CMP)
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

-- Diagnostics (gunakan API baru)
vim.diagnostic.config {
  update_in_insert = false,
  virtual_text = false,
  signs = true,
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    max_width = 80,
  },
}

local on_attach = function(client, bufnr)
  -- Matikan formatting untuk TypeScript (gunakan prettier/none-ls)
  if client.name == "tsserver" or client.name == "ts_ls" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  local buf_map = function(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  buf_map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
  buf_map("n", "gr", vim.lsp.buf.references, { desc = "Go to References" })
  buf_map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
  buf_map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
  buf_map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })

  vim.notify(string.format("LSP %s attached to buffer %d", client.name, bufnr), vim.log.levels.INFO)
end

-- Helper untuk merge config umum dan custom
local function with_common(opts)
  return vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    capabilities = capabilities,
  }, opts or {})
end

-- Helper: kumpulkan bundles JDT test/debug
local function get_java_test_bundles()
  local bundles = {}
  local java_test_path = vim.fn.stdpath "data" .. "/mason/packages/java-test/extension/server/"
  local java_debug_path = vim.fn.stdpath "data" .. "/mason/packages/java-debug-adapter/extension/server/"

  local test_bundles = vim.split(vim.fn.glob(java_test_path .. "*.jar"), "\n")
  for _, b in ipairs(test_bundles) do
    if b ~= "" then
      table.insert(bundles, b)
    end
  end

  local debug_bundles = vim.split(vim.fn.glob(java_debug_path .. "com.microsoft.java.debug.plugin-*.jar"), "\n")
  for _, b in ipairs(debug_bundles) do
    if b ~= "" then
      table.insert(bundles, b)
    end
  end

  return bundles
end

M.setup = function()
  -- Daftar server dengan config default (on_attach + capabilities)
  local default_servers = {
    "yamlls",
    "vimls",
    "gopls",
    "nimls",
    "jsonls",
    "cssls",
    "ts_ls",
  }

  for _, name in ipairs(default_servers) do
    vim.lsp.config(name, with_common())
  end

  -- lua_ls (custom)
  vim.lsp.config(
    "lua_ls",
    with_common {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = {
              vim.fn.expand "$VIMRUNTIME/lua",
              vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
            },
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    }
  )

  -- ts_ls (custom)
  vim.lsp.config(
    "ts_ls",
    with_common {
      root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json"),
      single_file_support = false, -- hindari attach di file lepas tanpa proyek
    }
  )
  vim.lsp.enable "ts_ls"

  -- denols (custom)
  vim.lsp.config(
    "denols",
    with_common {
      root_dir = util.root_pattern("deno.json", "deno.jsonc"),
      -- init_options = { lint = true, unstable = true },
    }
  )

  -- rust_analyzer (custom)
  vim.lsp.config(
    "rust_analyzer",
    with_common {
      settings = {
        ["rust-analyzer"] = {
          inlayHints = {
            chainingHints = { enable = true },
            closingBraceHints = { enable = true, minLines = 25 },
            parameterHints = { enable = true },
            typeHints = { enable = true },
          },
        },
      },
    }
  )

  -- Intelephense (PHP/Laravel)
  vim.lsp.config(
    "intelephense",
    with_common {
      settings = {
        intelephense = {
          environment = { phpVersion = "8.2" },
          files = { maxSize = 5000000 },
          stubs = {
            "apache",
            "bcmath",
            "bz2",
            "calendar",
            "com_dotnet",
            "Core",
            "curl",
            "date",
            "dba",
            "dom",
            "enchant",
            "exif",
            "fileinfo",
            "filter",
            "fpm",
            "ftp",
            "gd",
            "hash",
            "iconv",
            "imap",
            "interbase",
            "intl",
            "json",
            "ldap",
            "libxml",
            "mbstring",
            "mcrypt",
            "meta",
            "mssql",
            "mysqli",
            "oci8",
            "odbc",
            "openssl",
            "pcntl",
            "pcre",
            "PDO",
            "pdo_ibm",
            "pdo_mysql",
            "pdo_pgsql",
            "pdo_sqlite",
            "pgsql",
            "Phar",
            "posix",
            "pspell",
            "readline",
            "recode",
            "Reflection",
            "regex",
            "session",
            "shmop",
            "SimpleXML",
            "snmp",
            "soap",
            "sockets",
            "sodium",
            "SPL",
            "sqlite3",
            "standard",
            "superglobals",
            "sybase",
            "sysvmsg",
            "sysvsem",
            "sysvshm",
            "tidy",
            "tokenizer",
            "xml",
            "xmlreader",
            "xmlrpc",
            "xmlwriter",
            "xsl",
            "Zend OPcache",
            "zip",
            "zlib",
            "mysql",
            "laravel",
          },
        },
      },
    }
  )

  -- HTML
  vim.lsp.config(
    "html",
    with_common {
      filetypes = { "html", "template", "jsx", "tsx" },
      init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = { css = true, javascript = true },
        provideFormatter = false,
      },
    }
  )

  -- Emmet
  vim.lsp.config(
    "emmet_ls",
    with_common {
      filetypes = {
        "html",
        "typescriptreact",
        "javascriptreact",
        "css",
        "sass",
        "scss",
        "less",
        "template",
      },
    }
  )

  -- JDTLS (Java)
  vim.lsp.config(
    "jdtls",
    with_common {
      settings = {
        java = {
          home = vim.fn.expand "$JAVA_HOME",
          configuration = {
            runtimes = {
              { name = "JavaSE-23", path = vim.fn.expand "$JAVA_HOME", default = true },
            },
          },
          maven = { downloadSources = true, updateSnapshots = true },
          gradle = { enabled = true, downloadSources = true },
          format = {
            enabled = true,
            settings = {
              url = vim.fn.stdpath "config" .. "/lang-servers/eclipse-java-google-style.xml",
              profile = "GoogleStyle",
            },
          },
          completion = {
            favoriteStaticMembers = {
              "org.junit.Assert.*",
              "org.junit.Assume.*",
              "org.junit.jupiter.api.Assertions.*",
              "org.junit.jupiter.api.Assumptions.*",
              "org.mockito.Mockito.*",
              "org.mockito.ArgumentMatchers.*",
            },
            importOrder = { "java", "javax", "com", "org" },
          },
          signatureHelp = { enabled = true },
          contentProvider = { preferred = "fernflower" },
          implementationsCodeLens = { enabled = true },
          referencesCodeLens = { enabled = true },
          references = { includeDecompiledSources = true },
          inlayHints = { parameterNames = { enabled = true }, debug = { enabled = false } },
          compiler = {
            nullAnalysis = { mode = "interactive" },
            errors = { incompleteClasspath = { severity = "warning" } },
          },
        },
      },
      init_options = {
        bundles = get_java_test_bundles(),
      },
    }
  )

  -- Aktifkan semua server
  local to_enable = {
    "lua_ls",
    "ts_ls",
    "html",
    "cssls",
    "jsonls",
    "yamlls",
    "vimls",
    "rust_analyzer",
    "gopls",
    "nimls",
    "intelephense",
    "emmet_ls",
    "jdtls",
    "typescript-language-server",
  }
  for _, name in ipairs(to_enable) do
    vim.lsp.enable(name)
  end
end

return M
