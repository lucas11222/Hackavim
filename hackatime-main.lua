local M = {}

function M.hello_world()
  print("Hello, World!")
end

-- Map a command to the function
vim.api.nvim_command('command! Hackatime-dashboard lua require("hackatime-dashboard").hello_world()')

return M