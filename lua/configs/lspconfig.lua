local M = {}

-- Cache capabilities
local capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  require("cmp_nvim_lsp").default_capabilities()
)

-- Optimize diagnostics
vim.diagnostic.config({
  update_in_insert = false,    -- Disable diagnostics in insert mode
  virtual_text = false,        -- Disable virtual text
  signs = true,               -- Show signs
  underline = true,           -- Show underlines
  severity_sort = true,       -- Sort by severity
  float = {
    border = "rounded",
    source = "always",
    max_width = 80,
  },
})

-- Setup handler caching
local handlers = {
  ["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      update_in_insert = false,
      virtual_text = false,
      severity_sort = true,
    }
  ),
}

local on_attach = function(client, bufnr)
  -- Disable formatting for tsserver as we'll use null-ls/prettierd
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  -- Keybindings untuk LSP
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

  -- Notify when LSP attaches
  vim.notify(string.format("LSP %s attached to buffer %d", client.name, bufnr), vim.log.levels.INFO)
end

M.setup = function()
  local lspconfig = require("lspconfig")

  -- Setup LSP dengan handler & capabilities yang di-cache
  for _, server in ipairs({
    "lua_ls", "ts_ls", "html", "cssls", "jsonls"
  }) do
    lspconfig[server].setup({
      capabilities = capabilities,
      handlers = handlers,
      flags = {
        debounce_text_changes = 150,
      }
    })
  end

  -- Default LSP setup
  local servers = {
    "yamlls",
    "vimls",
    "rust_analyzer",
    "gopls",
    "nimls",
  }

  for _, server in ipairs(servers) do
    lspconfig[server].setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end

  -- Custom configuration for specific LSPs
  lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            vim.fn.expand("$VIMRUNTIME/lua"),
            vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
          },
        },
      },
    },
  })

  lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
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
  })

  -- PHP/Laravel Setup
  lspconfig.intelephense.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      intelephense = {
        environment = {
          phpVersion = "8.2" -- Sesuaikan dengan versi PHP Anda
        },
        files = {
          maxSize = 5000000;
        },
        stubs = {
          "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", 
          "curl", "date", "dba", "dom", "enchant", "exif", "fileinfo", 
          "filter", "fpm", "ftp", "gd", "hash", "iconv", "imap", "interbase",
          "intl", "json", "ldap", "libxml", "mbstring", "mcrypt", "meta",
          "mssql", "mysqli", "oci8", "odbc", "openssl", "pcntl", "pcre",
          "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite", "pgsql",
          "Phar", "posix", "pspell", "readline", "recode", "Reflection",
          "regex", "session", "shmop", "SimpleXML", "snmp", "soap", "sockets",
          "sodium", "SPL", "sqlite3", "standard", "superglobals", "sybase",
          "sysvmsg", "sysvsem", "sysvshm", "tidy", "tokenizer", "xml",
          "xmlreader", "xmlrpc", "xmlwriter", "xsl", "Zend OPcache", "zip",
          "zlib", "mysql", "laravel"
        },
      },
    },
  })

  -- HTML LSP Configuration
  lspconfig.html.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "html", "template", "jsx", "tsx" },
    init_options = {
      configurationSection = { "html", "css", "javascript" },
      embeddedLanguages = {
        css = true,
        javascript = true
      },
      provideFormatter = false, -- We use prettier/null-ls for formatting
    }
  })

  -- Emmet LSP Configuration
  lspconfig.emmet_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {
      "html", "typescriptreact", "javascriptreact", "css", 
      "sass", "scss", "less", "template"
    },
  })

  -- Java LSP Configuration
  lspconfig.jdtls.setup({
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)  -- Panggil on_attach default
    end,
    capabilities = capabilities,
    settings = {
      java = {
        -- Konfigurasi Java Home
        home = vim.fn.expand("$JAVA_HOME"),
        
        -- Konfigurasi Runtime
        configuration = {
          runtimes = {
            {
              name = "Java-23",
              path = vim.fn.expand("$JAVA_HOME"),
              default = true
            },
          }
        },

        -- Konfigurasi Maven
        maven = {
          downloadSources = true,
          updateSnapshots = true
        },

        -- Konfigurasi Gradle
        gradle = {
          enabled = true,
          downloadSources = true,
        },

        -- Format & Completion
        format = {
          enabled = true,
          settings = {
            url = vim.fn.stdpath("config") .. "/lang-servers/eclipse-java-google-style.xml",
            profile = "GoogleStyle"
          }
        },
        completion = {
          favoriteStaticMembers = {
            "org.junit.Assert.*",
            "org.junit.Assume.*",
            "org.junit.jupiter.api.Assertions.*",
            "org.junit.jupiter.api.Assumptions.*",
            "org.junit.jupiter.api.DynamicContainer.*",
            "org.junit.jupiter.api.DynamicTest.*"
          },
          importOrder = {
            "java",
            "javax",
            "com",
            "org"
          }
        },

        -- Code Generation & Hints
        signatureHelp = { enabled = true },
        contentProvider = { preferred = 'fernflower' },
        implementationsCodeLens = { enabled = true },
        referencesCodeLens = { enabled = true },
        references = { includeDecompiledSources = true },
        inlayHints = {
          parameterNames = { enabled = true },
          debug = { enabled = false }
        },

        -- Compiler Settings
        compiler = {
          nullAnalysis = { mode = 'interactive' },
          errors = {
            incompleteClasspath = { severity = "warning" }
          }
        }
      }
    },
    init_options = {
      bundles = {
        vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true)
      }
    }
  })
end

return M
