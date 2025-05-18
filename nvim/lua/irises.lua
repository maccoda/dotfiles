-- Neovim color scheme - Irises
-- Based on Van Gogh's painting "Irises"

local Irises = {}

local colors = {
  -- TODO: Need colour variations on background that are close in hue
  -- TODO: I think bg0 needs to be a little closer to black
  bg0 = "#22201e",
  bg1 = "#2E2A24", -- Soil brown
  bg2 = "#342f29",
  bg3 = "#3b382e",
  fg0 = "#EAE3D2", -- Parchment
  fg1 = "#fae4ab",
  fg2 = "#a09486",
  cursor = "#AACCFF", -- Sky blue
  selection = "#4A5060", -- Muted violet

  -- Syntax highlighting
  violet = "#735DA5",
  fresh_green = "#C2D94C", -- TODO: Get another green
  ochre_yellow = "#F6AA1C",
  sky_accent = "#B1E5F2",
  dust_olive = "#88846F",
  -- rust_orange = "#EF6C00",
  -- rust_orange = "#ae4e00", --Good
  rust_orange = "#ae6600", -- Good also
  deep_purple = "#8E6BAF",
  carmine_red = "#D33F49",
  iris_blue = "#7e98d1",
  comment = "#869189",
  -- dark blue?
  -- dark green?
  dark_green = "#6b7e0f",
}
local groups = {
  -- TODO: Look into the below to see how we can link them like popular ones (tokyonight, dracula, gruvbox)

  -- Core
  Pmenu = { bg = colors.bg1, fg = colors.fg1 }, -- Popup menu: normal item.
  PmenuMatch = { bg = colors.bg1, fg = colors.fresh_green }, -- Popup menu: Matched text in normal item.
  PmenuSel = { bg = colors.selection, bold = true }, -- Popup menu: selected item.
  PmenuSbar = { bg = colors.bg2 }, -- Popup menu: scrollbar.
  PmenuThumb = { bg = colors.dust_olive }, -- Popup menu: Thumb of the scrollbar.
  Comment = { fg = colors.comment, italic = true },
  Constant = { fg = colors.sky_accent },
  Cursor = { fg = colors.cursor },
  CursorLine = { bg = colors.bg1 },
  CursorLineNr = { bg = colors.bg1, fg = colors.cursor },
  EndOfBuffer = { fg = colors.fg0, bg = colors.bg0 },
  Error = { fg = colors.carmine_red },
  Folded = { bg = colors.bg0, italic = true },
  Function = { fg = colors.iris_blue, bold = true }, -- FIXME: Yellow isn't right for here
  Identifier = { fg = colors.deep_purple },
  LineNr = { fg = colors.fg2, bg = colors.bg0 }, --FIXME: This needs to be more subtle or just set to the same background
  Normal = { fg = colors.fg0, bg = colors.bg0 },
  NormalFloat = { fg = colors.fg0, bg = colors.bg0 },
  NormalNC = { fg = colors.fg0, bg = colors.bg1 },
  PreProc = { fg = colors.fresh_green },
  Special = { fg = colors.sky_accent },
  Statement = { fg = colors.rust_orange },
  StatusLine = { bg = colors.bg2 },
  StatusLineNC = { bg = colors.bg3 },
  String = { fg = colors.fresh_green },
  Type = { fg = colors.iris_blue },
  Visual = { bg = colors.bg3 },
  VisualNOS = { link = "Visual" },
  WinBar = { link = "StatusLine" },
  WinBarNC = { link = "StatusLineNC" },
  WinSeparator = { bg = colors.bg0, fg = colors.fg1 },

  -- TODO: Fill out the remaining of the highlight-groups

  -- LSP

  LspReferenceRead = { bg = colors.bg2 },
  LspReferenceTarget = { link = "Visual" },
  LspReferenceText = { link = "LspReferenceRead" },
  LspReferenceWrite = { link = "LspReferenceRead" },

  DiagnosticError = { fg = colors.carmine_red },
  --     DiagnosticSignError = { link = "IrisesRedSign" },
  DiagnosticUnderlineError = { undercurl = true, sp = colors.carmine_red },
  DiagnosticWarn = { fg = colors.ochre_yellow },
  --     DiagnosticSignWarn = { link = "IrisesYellowSign" },
  DiagnosticUnderlineWarn = { undercurl = true, sp = colors.ochre_yellow },
  --     DiagnosticInfo = { link = "IrisesBlue" },
  --     DiagnosticSignInfo = { link = "IrisesBlueSign" },
  --     DiagnosticUnderlineInfo = { link = "IrisesBlueUnderline" },
  --     DiagnosticHint = { link = "IrisesAqua" },
  --     DiagnosticSignHint = { link = "IrisesAquaSign" },
  --     DiagnosticUnderlineHint = { link = "IrisesAquaUnderline" },
  --     DiagnosticFloatingError = { link = "IrisesRed" },
  --     DiagnosticFloatingWarn = { link = "IrisesOrange" },
  --     DiagnosticFloatingInfo = { link = "IrisesBlue" },
  --     DiagnosticFloatingHint = { link = "IrisesAqua" },
  --     DiagnosticVirtualTextError = { link = "IrisesRed" },
  --     DiagnosticVirtualTextWarn = { link = "IrisesYellow" },
  --     DiagnosticVirtualTextInfo = { link = "IrisesBlue" },
  --     DiagnosticVirtualTextHint = { link = "IrisesAqua" },
  --     DiagnosticOk = { link = "IrisesGreenSign" },

  -- WhichKey
  WhichKeyTitle = { link = "NormalFloat" },

  -- Treesitter

  ["@comment"] = { link = "Comment" },
  ["@none"] = { bg = "NONE", fg = "NONE" },
  ["@preproc"] = { link = "PreProc" },
  ["@define"] = { link = "Define" },
  ["@operator"] = { link = "Operator" },
  ["@punctuation.delimiter"] = { link = "Delimiter" },
  ["@punctuation.bracket"] = { link = "Delimiter" },
  ["@punctuation.special"] = { link = "Delimiter" },
  ["@string"] = { link = "String" },
  ["@string.regex"] = { link = "String" },
  ["@string.regexp"] = { link = "String" },
  ["@string.escape"] = { link = "SpecialChar" },
  ["@string.special"] = { link = "SpecialChar" },
  ["@string.special.path"] = { link = "Underlined" },
  ["@string.special.symbol"] = { link = "Identifier" },
  ["@string.special.url"] = { link = "Underlined" },
  ["@character"] = { link = "Character" },
  ["@character.special"] = { link = "SpecialChar" },
  ["@boolean"] = { link = "Boolean" },
  ["@number"] = { link = "Number" },
  ["@number.float"] = { link = "Float" },
  ["@float"] = { link = "Float" },
  ["@function"] = { link = "Function" },
  ["@function.builtin"] = { link = "Special" },
  ["@function.call"] = { link = "Function" },
  ["@function.macro"] = { link = "Macro" },
  ["@function.method"] = { link = "Function" },
  ["@method"] = { link = "Function" },
  ["@method.call"] = { link = "Function" },
  ["@constructor"] = { link = "Special" },
  ["@parameter"] = { link = "Identifier" },
  ["@keyword"] = { link = "Keyword" },
  ["@keyword.conditional"] = { link = "Conditional" },
  ["@keyword.debug"] = { link = "Debug" },
  ["@keyword.directive"] = { link = "PreProc" },
  ["@keyword.directive.define"] = { link = "Define" },
  ["@keyword.exception"] = { link = "Exception" },
  ["@keyword.function"] = { link = "Keyword" },
  ["@keyword.import"] = { link = "Include" },
  ["@keyword.operator"] = { link = "IrisesRed" },
  ["@keyword.repeat"] = { link = "Repeat" },
  ["@keyword.return"] = { link = "Keyword" },
  ["@keyword.storage"] = { link = "StorageClass" },
  ["@conditional"] = { link = "Conditional" },
  ["@repeat"] = { link = "Repeat" },
  ["@debug"] = { link = "Debug" },
  ["@label"] = { link = "Label" },
  ["@include"] = { link = "Include" },
  ["@exception"] = { link = "Exception" },
  ["@type"] = { link = "Type" },
  ["@type.builtin"] = { link = "Type" },
  ["@type.definition"] = { link = "Typedef" },
  ["@type.qualifier"] = { link = "Type" },
  ["@storageclass"] = { link = "StorageClass" },
  ["@attribute"] = { link = "PreProc" },
  ["@field"] = { link = "Identifier" },
  ["@property"] = { link = "Identifier" },
  ["@variable"] = { link = "IrisesFg1" },
  ["@variable.builtin"] = { link = "Special" },
  ["@variable.member"] = { link = "Identifier" },
  ["@variable.parameter"] = { link = "Identifier" },
  ["@constant"] = { link = "Constant" },
  ["@constant.builtin"] = { link = "Special" },
  ["@constant.macro"] = { link = "Define" },
  ["@markup"] = { link = "IrisesFg1" },
  ["@markup.strong"] = { bold = true }, -- maybe configurable
  ["@markup.italic"] = { link = "@text.emphasis" },
  ["@markup.underline"] = { underline = true }, -- maybe configurable
  ["@markup.strikethrough"] = { strikethrough = true }, -- maybe configurable
  ["@markup.heading"] = { link = "Title" },
  ["@markup.raw"] = { link = "String" },
  ["@markup.math"] = { link = "Special" },
  ["@markup.environment"] = { link = "Macro" },
  ["@markup.environment.name"] = { link = "Type" },
  ["@markup.link"] = { link = "Underlined" },
  ["@markup.link.label"] = { link = "SpecialChar" },
  ["@markup.list"] = { link = "Delimiter" },
  ["@markup.list.checked"] = { link = "IrisesGreen" },
  ["@markup.list.unchecked"] = { link = "IrisesGray" },
  ["@comment.todo"] = { link = "Todo" },
  ["@comment.note"] = { link = "SpecialComment" },
  ["@comment.warning"] = { link = "WarningMsg" },
  ["@comment.error"] = { link = "ErrorMsg" },
  ["@diff.plus"] = { link = "diffAdded" },
  ["@diff.minus"] = { link = "diffRemoved" },
  ["@diff.delta"] = { link = "diffChanged" },
  ["@module"] = { link = "IrisesFg1" },
  ["@namespace"] = { link = "IrisesFg1" },
  ["@symbol"] = { link = "Identifier" },
  ["@text"] = { link = "IrisesFg1" },
  ["@text.strong"] = { bold = true }, -- maybe configurable
  ["@text.emphasis"] = { italic = true }, -- maybe configurable
  ["@text.underline"] = { underline = true }, -- maybe configurable
  ["@text.strike"] = { strikethrough = true }, -- maybe configurable
  ["@text.title"] = { link = "Title" },
  ["@text.literal"] = { link = "String" },
  ["@text.uri"] = { link = "Underlined" },
  ["@text.math"] = { link = "Special" },
  ["@text.environment"] = { link = "Macro" },
  ["@text.environment.name"] = { link = "Type" },
  ["@text.reference"] = { link = "Constant" },
  ["@text.todo"] = { link = "Todo" },
  ["@text.todo.checked"] = { link = "IrisesGreen" },
  ["@text.todo.unchecked"] = { link = "IrisesGray" },
  ["@text.note"] = { link = "SpecialComment" },
  ["@text.note.comment"] = { fg = colors.purple, bold = true },
  ["@text.warning"] = { link = "WarningMsg" },
  ["@text.danger"] = { link = "ErrorMsg" },
  ["@text.danger.comment"] = { fg = colors.fg0, bg = colors.red, bold = true },
  ["@text.diff.add"] = { link = "diffAdded" },
  ["@text.diff.delete"] = { link = "diffRemoved" },
  ["@tag"] = { link = "Tag" },
  ["@tag.attribute"] = { link = "Identifier" },
  ["@tag.delimiter"] = { link = "Delimiter" },
  ["@punctuation"] = { link = "Delimiter" },
  ["@macro"] = { link = "Macro" },
  ["@structure"] = { link = "Structure" },
  ["@lsp.type.class"] = { link = "@type" },
  ["@lsp.type.comment"] = { link = "@comment" },
  ["@lsp.type.decorator"] = { link = "@macro" },
  ["@lsp.type.enum"] = { link = "@type" },
  ["@lsp.type.enumMember"] = { link = "@constant" },
  ["@lsp.type.function"] = { link = "@function" },
  ["@lsp.type.interface"] = { link = "@constructor" },
  ["@lsp.type.macro"] = { link = "@macro" },
  ["@lsp.type.method"] = { link = "@method" },
  ["@lsp.type.modifier.java"] = { link = "@keyword.type.java" },
  ["@lsp.type.namespace"] = { link = "@namespace" },
  ["@lsp.type.parameter"] = { link = "@parameter" },
  ["@lsp.type.property"] = { link = "@property" },
  ["@lsp.type.struct"] = { link = "@type" },
  ["@lsp.type.type"] = { link = "@type" },
  ["@lsp.type.typeParameter"] = { link = "@type.definition" },
  ["@lsp.type.variable"] = { link = "@variable" },
}

Irises.load = function()
  if vim.version().minor < 8 then
    vim.notify_once("colors.nvim: you must use neovim 0.8 or higher")
    return
  end

  -- reset colors
  vim.cmd.hi("clear")
  if vim.g.colors_name then
    vim.cmd.hi("clear")
  end
  vim.g.colors_name = "irises"
  vim.o.termguicolors = true

  for group, settings in pairs(groups) do
    vim.api.nvim_set_hl(0, group, settings)
  end
end

Irises.reload = function()
  package.loaded["irises"] = nil
  require("irises").load()
end

return Irises
