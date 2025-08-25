local http_request = require "http.request"
local M = {}
function M.get_user_id()
  vim.ui.input({
    prompt = "Enter your Slack ID",
    default = "",
  }, function(input)
    if not input or input == "" then
      vim.print("you cancelled :(")
      return
    end

    local user_id = (vim.trim and vim.trim(input)) or input:gsub("^%s+", ""):gsub("%s+$", "")
    local url = ("https://hackatime.hackclub.com/api/v1/users/%s/stats?features=projects"):format(user_id)

    local req = assert(http_request.new_from_uri(url))
    local headers, stream = req:go()
    if not headers or not stream then
      vim.notify("network error requesting :( maybe check wifi/ethernet?" .. url, vim.log.levels.ERROR)
      return
    end

    local body, berr = stream:get_body_as_string()
    if not body then
      vim.notify("could not read response body :( : " .. tostring(berr), vim.log.levels.ERROR)
      return
    end

    if headers:get(":status") ~= "200" then
      vim.notify("ummm there has been an error :( " .. body, vim.log.levels.ERROR)
      return
    end

    local ok, data = pcall(vim.json.decode, body)
    if not ok or not data or not data.data then
      vim.notify("invalid JSON in response :( contact lucas11 for this: ", vim.log.levels.ERROR)
      return
    end

    local username = data.data.username
    vim.print("Name: " .. username)
  end)
end
vim.api.nvim_create_user_command(
  "Hackavim",
  function()
    M.get_user_id()
  end,
  {}
)
return M
