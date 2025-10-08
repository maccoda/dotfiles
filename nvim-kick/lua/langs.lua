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
  dockerls = {},
  gopls = {},
  jsonls = {},
  marksman = {},
  terraformls = {},
  vtsls = {},
  yamlls = {},
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
  dockerfile = { 'hadolint' },
  go = { 'golangcilint' },
  markdown = { 'markdownlint', 'proselint' },
  terraform = { 'terraform_validate' },
  tf = { 'terraform_validate' },
  ['*'] = { 'typos' },
}

langs.formatters = {
  fish = { 'fish_indent' },
  go = { 'goimports' },
  lua = { 'stylua' },
  markdown = { 'prettierd' },
  sh = { 'shfmt' },
  terraform = { 'terraform_fmt' },
  tf = { 'terraform_fmt' },
  typescript = { 'prettierd' },
}

-- Not all of the above are actually needed to be installed by Mason so manually managing
-- the list of those that are below. All of the language servers are however.
local mason_installed = vim.tbl_keys(langs.servers or {})
vim.list_extend(mason_installed, {
  'goimports',
  'golangci-lint',
  'markdownlint',
  'prettierd',
  'proselint',
  'shfmt',
  'stylua', -- Used to format Lua code
  'typos',
})
langs.mason_installed = mason_installed

langs.ts_installed = {
  'bash',
  'c',
  'diff',
  'dockerfile',
  'git_config',
  'git_rebase',
  'gitattributes',
  'gitcommit',
  'gitignore',
  'go',
  'gomod',
  'gosum',
  'gowork',
  'html',
  'javascript',
  'jsdoc',
  'json',
  'json5',
  'jsonc',
  'lua',
  'luadoc',
  'luap',
  'markdown',
  'markdown_inline',
  'printf',
  'python',
  'query',
  'regex',
  'sql',
  'terraform',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'xml',
  'yaml',
}

return langs
