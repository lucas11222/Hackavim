local M = {}

function M.hello_world()
  print("Hello, World!")
end

-- Map a command to the function
vim.api.nvim_create_user_command(
  "Hackatime",
  function()
    require("Hackavim").hello_world()
  end,
  {}
)
return M