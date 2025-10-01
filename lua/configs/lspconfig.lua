local M = {}

local legacy_lspconfig
local legacy_checked = false

local function resolve_server(server)
  local registry = rawget(vim.lsp, "config")

  if registry ~= nil then
    if type(registry) == "table" and registry[server] then
      return registry[server]
    end

    if type(registry) == "function" then
      local ok, config = pcall(registry, server)
      if ok and config then
        return config
      end
    end

    return nil
  end

  if not legacy_checked then
    local ok, legacy = pcall(require, "lspconfig")
    legacy_lspconfig = ok and legacy or nil
    legacy_checked = true
  end

  if legacy_lspconfig and legacy_lspconfig[server] then
    return legacy_lspconfig[server]
  end
end

local function setup_server(server, opts)
  local config = resolve_server(server)

  if config and type(config.setup) == "function" then
    config.setup(opts or {})
    return
  end

  vim.notify(("LSP server '%s' could not be configured."):format(server), vim.log.levels.WARN)
end

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
  -- Setup LSP dengan handler & capabilities yang di-cache
  for _, server in ipairs({
    "lua_ls", "ts_ls", "html", "cssls", "jsonls"
  }) do
    setup_server(server, {
      capabilities = capabilities,
      handlers = handlers,
      flags = {
        debounce_text_changes = 150,
      },
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
    setup_server(server, {
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end

  -- Custom configuration for specific LSPs
  setup_server("lua_ls", {
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

  setup_server("rust_analyzer", {
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
  setup_server("intelephense", {
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
  setup_server("html", {
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
  setup_server("emmet_ls", {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {
      "html", "typescriptreact", "javascriptreact", "css", 
      "sass", "scss", "less", "template"
    },
  })

  -- Helper function untuk mengumpulkan semua JAR files
  local function get_java_test_bundles()
    local bundles = {}
    local java_test_path = vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/"
    local java_debug_path = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/"
    
    -- Add java-test bundles
    local test_bundles = vim.split(vim.fn.glob(java_test_path .. "*.jar"), "\n")
    for _, bundle in ipairs(test_bundles) do
      if bundle ~= "" then
        table.insert(bundles, bundle)
      end
    end
    
    -- Add java-debug-adapter bundle
    local debug_bundles = vim.split(vim.fn.glob(java_debug_path .. "com.microsoft.java.debug.plugin-*.jar"), "\n")
    for _, bundle in ipairs(debug_bundles) do
      if bundle ~= "" then
        table.insert(bundles, bundle)
      end
    end
    
    return bundles
  end

  -- Java LSP Configuration
  setup_server("jdtls", {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
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
              name = "JavaSE-23",
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
            "org.mockito.Mockito.*",
            "org.mockito.ArgumentMatchers.*",
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
      bundles = get_java_test_bundles()
    }
  })
end

M.setup_server = setup_server
return M
