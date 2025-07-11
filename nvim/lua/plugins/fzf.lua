return {
  "ibhagwan/fzf-lua",
  opts = function()
    local fzf = require("fzf-lua")
    local actions = fzf.actions
    return {
      "ivy",
      -- Change the below options so hidden does not conflict with Zellij
      files = {
        cwd_prompt = false,
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-."] = { actions.toggle_hidden },
        },
      },
      grep = {
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-."] = { actions.toggle_hidden },
        },
      },
    }
  end,
}
