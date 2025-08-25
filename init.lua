local M = {}

function M.hello_world()
  print("Hello, World!")
end

-- Map a command to the function
vim.api.nvim_create_user_command(
  "Hackatime",                     -- command name (must start uppercase)
  function()
    require("Hackavim").hello_world()  -- call your Lua function
  end,
  {}                               -- options
)
return M