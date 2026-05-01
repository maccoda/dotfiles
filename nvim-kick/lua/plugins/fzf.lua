return {
  "ibhagwan/fzf-lua",
  lazy = false,
  config = function()
    local fzf = require("fzf-lua")
    local actions = fzf.actions
    fzf.setup({
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
      keymap = {
        builtin = {
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
          ["<C-a>"] = "toggle-preview",
        },
      },
      winopts = {
        preview = {
          hidden = true,
        },
      },
      fzf_opts = {
        ["--cycle"] = true,
      },
    })
    fzf.register_ui_select({
      winopts = {
        width = 1,
        height = 0.4,
        row = 1, -- window row position (0=top, 1=bottom)
        col = 0, -- window col position (0=left, 1=right)
      },
    })
  end,
  keys = {
    { "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
    { "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
    { "<leader><space>", "<cmd>FzfLua<cr>", desc = "FzfLua finder" },
    { "<leader>p", "<cmd>FzfLua registers<cr>", desc = "Paste from registers" },
    -- find
    { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find Files (Root Dir)" },
    { "<leader>gs", "<cmd>FzfLua git_status<cr>", desc = "Find files in git status" },
    { "<leader>fr", '<cmd>lua require("fzf-lua").oldfiles({cwd_only = true})<cr>', desc = "Recent" },
    -- git
    { "<leader>gC", "<cmd>FzfLua git_commits<CR>", desc = "[g]it [c]ommits" },
    { "<leader>gc", "<cmd>FzfLua git_bcommits<CR>", desc = "[g]it buffer [c]ommits" },
    -- search
    { '<leader>f"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
    { "<leader>fa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
    { "<leader>fc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
    { "<leader>fC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
    { "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Document Diagnostics" },
    { "<leader>fD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Workspace Diagnostics" },
    { "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Grep (Root Dir)" },
    { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
    { "<leader>fH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>fj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
    { "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
    { "<leader>fl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
    { "<leader>fm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
    { "<leader>fR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
    { "<leader>fq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
    { "<leader>fw", "<cmd>FzfLua grep_cword<cr>", desc = "Word (Root Dir)" },
    { "<leader>fw", "<cmd>FzfLua grep_visual<cr>", mode = "v", desc = "Selection (Root Dir)" },
    {
      "<leader>ft",
      function()
        require("fzf-lua").grep({ search = "(TODO|FIXME|NOTE|HACK):", no_esc = true })
      end,
      desc = "Search: TODOs",
    },
  },
}
