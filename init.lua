local M = {}

function M.hello_world()
  print("Hello, World!")
end

vim.api.nvim_create_user_command(
  "Hackavim",
  function()
    M.hello_world()
  end,
  { desc = "Say hello from Hackavim" }
)

return M
