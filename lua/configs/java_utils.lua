local M = {}

M.compile_and_run = function(file_path, class_name, dir_path)
  -- Compile first
  local compile_result = vim.fn.system(string.format('javac "%s"', file_path))
  if vim.v.shell_error ~= 0 then
    vim.notify("Compilation error:\n" .. compile_result, vim.log.levels.ERROR)
    return false
  end
  
  -- Run in terminal
  vim.cmd('split')
  vim.cmd('terminal')
  vim.cmd('startinsert')
  
  local job_id = vim.b.terminal_job_id
  if job_id then
    vim.fn.chansend(job_id, string.format('java -cp "%s" %s\n', dir_path, class_name))
    return true
  end
  
  return false
end

return M