local M = {}
function M.hello_world()
  print("Hello, World!")
end

vim.api.nvim_create_user_command('BufOnly',function()
  pcall(function()
    M.hello_world()
  end)
end,{})
return M
