-- Module to keep all the language specific tooling in one spot so it can be easily managed
-- as new languages are used. It manages the LSP, linters and formatters.
local langs = {}

--  Add any additional override configuration in the following tables. Available keys are:
--  - cmd (table): Override the default command used to start the server
--  - filetypes (table): Override the default list of associated filetypes for the server
--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--  - settings (table): Override the default settings passed when initializing the server.
--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
langs.servers = {
  --
  -- clangd = {},
  gopls = {},
  terraformls = {},
  yamlls = {},
  marksman = {},
  jsonls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
  --
  -- Some languages (like typescript) have entire language plugins that can be useful:
  --    https://github.com/pmizio/typescript-tools.nvim
  --
  -- But for many setups, the LSP (`ts_ls`) will work just fine
  -- ts_ls = {},
  --

  lua_ls = {
    -- cmd = { ... },
    -- filetypes = { ... },
    -- capabilities = {},
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        -- diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },
}

langs.linters = {
  markdown = { 'markdownlint' },
  terraform = { 'terraform_validate' },
  tf = { 'terraform_validate' },
  go = { 'golangcilint' },
  ['*'] = { 'typos' },
}
langs.formatters = {
  lua = { 'stylua' },
  fish = { 'fish_indent' },
  sh = { 'shfmt' },
  typescript = { 'prettierd' },
  terraform = { 'terraform_fmt' },
  tf = { 'terraform_fmt' },
}

-- Not all of the above are actually needed to be installed by Mason so manually managing
-- the list of those that are below.
local mason_installed = vim.tbl_keys(langs.servers or {})
vim.list_extend(mason_installed, {
  'stylua', -- Used to format Lua code
  'golangci-lint',
  'typos',
  'shfmt',
  'prettierd',
})
langs.mason_installed = mason_installed

return langs
