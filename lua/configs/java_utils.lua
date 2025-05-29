local M = {}

M.compile_and_run = function(file_path, class_name, dir_path)
    -- Find project root (directory yang berisi folder src)
    local project_root = vim.fn.fnamemodify(vim.fn.finddir("src", dir_path .. ";"), ":p:h:h")
    
    if project_root == "" then
        vim.notify("Not a valid Java project structure (missing src folder)", vim.log.levels.ERROR)
        return false
    end

    local src_path = project_root .. "/src"
    local bin_path = project_root .. "/bin"
    local lib_path = project_root .. "/lib"
    
    -- Pastikan path yang dihasilkan benar
    vim.notify("Project root: " .. project_root)
    vim.notify("Bin path: " .. bin_path)
    
    -- Create bin directory if it doesn't exist
    if vim.fn.isdirectory(bin_path) == 0 then
        vim.fn.system('mkdir -p ' .. bin_path)
    end
    
    -- Build classpath including lib folder if it exists
    local classpath = bin_path
    if vim.fn.isdirectory(lib_path) == 1 then
        local lib_jars = vim.fn.glob(lib_path .. "/*.jar")
        if lib_jars ~= "" then
            classpath = classpath .. ":" .. lib_path .. "/*"
        end
    end

    -- Compile with output to bin directory
    local compile_cmd = string.format('javac -d "%s" "%s"', bin_path, file_path)
    local compile_result = vim.fn.system(compile_cmd)
    
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
        local run_cmd = string.format('java -cp "%s" %s', classpath, class_name)
        vim.fn.chansend(job_id, run_cmd .. '\n')
        return true
    end
    
    return false
end

-- Helper function to get package name if exists
M.get_package_name = function(file_path)
    local content = vim.fn.readfile(file_path)
    for _, line in ipairs(content) do
        local package = string.match(line, "^%s*package%s+([%w%.]+);")
        if package then
            return package
        end
    end
    return nil
end

return M