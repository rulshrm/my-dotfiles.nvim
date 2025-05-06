local M = {}

M.apply_patches = function()
  -- Monkeypatch various null-ls and vim.lsp functions
  local ok, null_ls = pcall(require, "null-ls")
  if not ok then
    vim.notify("null-ls not found, patches not applied", vim.log.levels.WARN)
    return
  end

  -- 1. Patch client-related functions in null-ls
  if null_ls and null_ls.client then
    local original_functions = {}
    for func_name, func in pairs(null_ls.client) do
      if type(func) == "function" then
        original_functions[func_name] = func
        null_ls.client[func_name] = function(client, ...)
          if client and not client._request_name_to_capability then
            client._request_name_to_capability = {}
          end
          return original_functions[func_name](client, ...)
        end
      end
    end
  end

  -- 2. Create a safe format function that handles null-ls client issues
  local orig_format = vim.lsp.buf.format
  vim.lsp.buf.format = function(options)
    options = options or {}
    
    -- Get clients with the null-ls patch applied
    local get_clients = vim.lsp.get_clients
    local original_get_clients = get_clients
    
    vim.lsp.get_clients = function(opts)
      local clients = original_get_clients(opts)
      
      -- Apply the patch to each client
      for _, client in ipairs(clients) do
        if not client._request_name_to_capability then
          client._request_name_to_capability = {}
        end
      end
      
      return clients
    end
    
    -- Call the original format function
    local result = orig_format(options)
    
    -- Restore original function
    vim.lsp.get_clients = original_get_clients
    
    return result
  end

  vim.notify("All null-ls patches applied successfully", vim.log.levels.INFO)
end

return M