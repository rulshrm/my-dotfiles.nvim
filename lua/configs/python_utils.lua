local M = {}

M.run_python = function(file_path, args)
  -- Save file before running
  pcall(function() vim.cmd('write!') end)
  
  -- Open terminal in split
  vim.cmd('split')
  vim.cmd('terminal')
  vim.cmd('startinsert')
  
  -- Get terminal job ID
  local job_id = vim.b.terminal_job_id
  if job_id then
    local run_cmd = string.format('python3 "%s"', file_path)
    if args and args ~= "" then
      run_cmd = run_cmd .. " " .. args
    end
    vim.fn.chansend(job_id, run_cmd .. '\n')
    return true
  end
  
  return false
end

M.run_python_with_venv = function(file_path, args)
  -- Check if virtual environment exists
  local venv_paths = { "venv", ".venv", "env", ".env" }
  local venv_python = nil
  
  for _, venv in ipairs(venv_paths) do
    local python_path = venv .. "/bin/python"
    if vim.fn.filereadable(python_path) == 1 then
      venv_python = python_path
      break
    end
  end
  
  -- Save file before running
  pcall(function() vim.cmd('write!') end)
  
  -- Open terminal in split
  vim.cmd('split')
  vim.cmd('terminal')
  vim.cmd('startinsert')
  
  local job_id = vim.b.terminal_job_id
  if job_id then
    local python_cmd = venv_python or "python3"
    local run_cmd = string.format('%s "%s"', python_cmd, file_path)
    if args and args ~= "" then
      run_cmd = run_cmd .. " " .. args
    end
    
    if venv_python then
      vim.notify("Running with virtual environment: " .. venv_python, vim.log.levels.INFO)
    end
    
    vim.fn.chansend(job_id, run_cmd .. '\n')
    return true
  end
  
  return false
end

M.run_pytest = function()
  pcall(function() vim.cmd('write!') end)
  
  vim.cmd('split')
  vim.cmd('terminal')
  vim.cmd('startinsert')
  
  local job_id = vim.b.terminal_job_id
  if job_id then
    vim.fn.chansend(job_id, 'pytest -v\n')
    return true
  end
  
  return false
end

M.run_current_test = function()
  local file_path = vim.fn.expand('%:p')
  
  pcall(function() vim.cmd('write!') end)
  
  vim.cmd('split')
  vim.cmd('terminal')
  vim.cmd('startinsert')
  
  local job_id = vim.b.terminal_job_id
  if job_id then
    local cmd = string.format('pytest -v "%s"', file_path)
    vim.fn.chansend(job_id, cmd .. '\n')
    return true
  end
  
  return false
end

return M
