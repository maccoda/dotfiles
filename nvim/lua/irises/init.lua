-- Neovim color scheme - Irises
-- Based on Van Gogh's painting "Irises"

local Irises = {}

local colors = require("irises.colors")

local groups = {
  -- TODO: Look into the below to see how we can link them like popular ones (tokyonight, dracula, gruvbox)

  -- Core
  Comment = { fg = colors.comment, italic = true },
  Cursor = { fg = colors.cursor },
  CursorLine = { bg = colors.bg1 },
  CursorLineNr = { bg = colors.bg1, fg = colors.cursor },
  EndOfBuffer = { fg = colors.fg0, bg = colors.bg0 },
  Folded = { bg = colors.bg0, italic = true },
  LineNr = { fg = colors.fg2, bg = colors.bg0 },
  Normal = { fg = colors.fg0, bg = colors.bg0 },
  NormalFloat = { fg = colors.fg0, bg = colors.bg2 },
  NormalNC = { fg = colors.fg0, bg = colors.bg0 },
  Pmenu = { bg = colors.bg1, fg = colors.fg1 }, -- Popup menu: normal item.
  PmenuMatch = { bg = colors.bg1, fg = colors.fresh_green }, -- Popup menu: Matched text in normal item.
  PmenuSbar = { bg = colors.bg2 }, -- Popup menu: scrollbar.
  PmenuSel = { bg = colors.selection, bold = true }, -- Popup menu: selected item.
  PmenuKind = { bg = colors.bg1, fg = colors.fg1 },
  PmenuThumb = { bg = colors.dust_olive }, -- Popup menu: Thumb of the scrollbar.
  Substitute = { bg = colors.selection, fg = colors.fg0 },
  Search = { bg = colors.selection, fg = colors.fg0 },
  StatusLine = { bg = colors.bg2 },
  StatusLineNC = { bg = colors.bg3 },
  Visual = { bg = colors.bg3 },
  VisualNOS = { link = "Visual" },
  WinBar = { link = "StatusLine" },
  WinBarNC = { link = "StatusLineNC" },
  WinSeparator = { bg = colors.bg0, fg = colors.fg1 },
  -- ColorColumn = { bg = c.black }, -- used for the columns set with 'colorcolumn'
  -- Conceal = { fg = c.dark5 }, -- placeholder characters substituted for concealed text (see 'conceallevel')
  -- lCursor = { fg = c.bg, bg = c.fg }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
  -- CursorIM = { fg = c.bg, bg = c.fg }, -- like Cursor, but used when in IME mode |CursorIM|
  -- CursorColumn = { bg = c.bg_highlight }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
  -- Directory = { fg = c.blue }, -- directory names (and other special names in listings)
  -- DiffAdd = { bg = c.diff.add }, -- diff mode: Added line |diff.txt|
  -- DiffChange = { bg = c.diff.change }, -- diff mode: Changed line |diff.txt|
  -- DiffDelete = { bg = c.diff.delete }, -- diff mode: Deleted line |diff.txt|
  -- DiffText = { bg = c.diff.text }, -- diff mode: Changed text within a changed line |diff.txt|
  -- ErrorMsg = { fg = c.error }, -- error messages on the command line
  -- VertSplit = { fg = c.border }, -- the column separating vertically split windows
  -- FoldColumn = { bg = opts.transparent and c.none or c.bg, fg = c.comment }, -- 'foldcolumn'
  -- SignColumn = { bg = opts.transparent and c.none or c.bg, fg = c.fg_gutter }, -- column where |signs| are displayed
  -- SignColumnSB = { bg = c.bg_sidebar, fg = c.fg_gutter }, -- column where |signs| are displayed
  -- LineNrAbove = { fg = c.fg_gutter },
  -- LineNrBelow = { fg = c.fg_gutter },
  -- MatchParen = { fg = c.orange, bold = true }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
  -- ModeMsg = { fg = c.fg_dark, bold = true }, -- 'showmode' message (e.g., "-- INSERT -- ")
  -- MsgArea = { fg = c.fg_dark }, -- Area for messages and cmdline
  -- MoreMsg = { fg = c.blue }, -- |more-prompt|
  -- NonText = { fg = c.dark3 }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
  -- NormalSB = { fg = c.fg_sidebar, bg = c.bg_sidebar }, -- normal text in sidebar
  -- FloatBorder = { fg = c.border_highlight, bg = c.bg_float },
  -- FloatTitle = { fg = c.border_highlight, bg = c.bg_float },
  -- PmenuMatchSel = { bg = Util.blend_bg(c.fg_gutter, 0.8), fg = c.blue1 }, -- Popup menu: Matched text in selected item.
  -- Question = { fg = c.blue }, -- |hit-enter| prompt and yes/no questions
  QuickFixLine = { bg = colors.selection, bold = true }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
  IncSearch = { bg = colors.rust_orange, fg = colors.fg0 }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
  CurSearch = { link = "IncSearch" },
  -- SpecialKey = { fg = c.dark3 }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
  -- SpellBad = { sp = c.error, undercurl = true }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
  -- SpellCap = { sp = c.warning, undercurl = true }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
  -- SpellLocal = { sp = c.info, undercurl = true }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
  -- SpellRare = { sp = c.hint, undercurl = true }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
  TabLine = { bg = colors.bg2, fg = colors.fg2 }, -- tab pages line, not active tab page label
  TabLineFill = { bg = colors.bg1 }, -- tab pages line, where there are no labels
  TabLineSel = { fg = colors.bg0, bg = colors.selection }, -- tab pages line, active tab page label
  -- Title = { fg = c.blue, bold = true }, -- titles for output from ":set all", ":autocmd" etc.
  -- WarningMsg = { fg = c.warning }, -- warning messages
  -- Whitespace = { fg = c.fg_gutter }, -- "nbsp", "space", "tab" and "trail" in 'listchars'
  -- WildMenu = { bg = c.bg_visual }, -- current match in 'wildmenu' completion

  -- Bold = { bold = true, fg = c.fg }, -- (preferred) any bold text
  -- Character = { fg = c.green }, --  a character constant: 'c', '\n'
  Constant = { fg = colors.sky_accent },
  -- Debug = { fg = c.orange }, --    debugging statements
  Delimiter = { link = "Special" }, --  character that needs attention
  Error = { fg = colors.carmine_red },
  Function = { fg = colors.iris_blue, bold = true },
  Identifier = { fg = colors.deep_purple },
  -- Italic = { italic = true, fg = c.fg }, -- (preferred) any italic text
  -- Keyword = { fg = c.cyan, style = opts.styles.keywords }, --  any other keyword
  -- Operator = { fg = c.blue5 }, -- "sizeof", "+", "*", etc.
  PreProc = { fg = colors.rust_orange, bold = true },
  Special = { fg = colors.sky_accent },
  Statement = { fg = colors.rust_orange },
  String = { fg = colors.fresh_green },
  -- Todo = { bg = c.yellow, fg = c.bg }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
  Type = { fg = colors.iris_blue },
  Underlined = { underline = true }, -- (preferred) text that stands out, HTML links
  -- debugBreakpoint = { bg = Util.blend_bg(c.info, 0.1), fg = c.info }, -- used for breakpoint colors in terminal-debug
  -- debugPC = { bg = c.bg_sidebar }, -- used for highlighting the current line in terminal-debug
  dosIniLabel = { link = "@property" },
  -- helpCommand = { bg = c.terminal_black, fg = c.blue },
  -- htmlH1 = { fg = c.magenta, bold = true },
  -- htmlH2 = { fg = c.blue, bold = true },
  qfFileName = { fg = colors.iris_blue },
  qfLineNr = { fg = colors.comment },

  -- Native LSP

  LspReferenceRead = { bg = colors.bg2 },
  LspReferenceTarget = { link = "Visual" },
  LspReferenceText = { link = "LspReferenceRead" },
  LspReferenceWrite = { link = "LspReferenceRead" },
  -- LspSignatureActiveParameter = { bg = Util.blend_bg(c.bg_visual, 0.4), bold = true },
  -- LspCodeLens = { fg = c.comment },
  -- LspInlayHint = { bg = Util.blend_bg(c.blue7, 0.1), fg = c.dark3 },
  -- LspInfoBorder = { fg = c.border_highlight, bg = c.bg_float },

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

  -- Blink
  -- BlinkCmpLabel = { fg = colors.fg0 },
  -- BlinkCmpLabelDeprecated = { link = "GruvboxFg1" },
  -- BlinkCmpLabelMatch = { link = "GruvboxBlueBold" },
  -- BlinkCmpLabelDetail = { link = "GruvboxGray" },
  -- BlinkCmpLabelDescription = { link = "GruvboxGray" },
  -- BlinkCmpSource = { link = "GruvboxGray" },
  -- BlinkCmpGhostText = {},

  -- Kinds were copied from tokyonight for the linking idea
  BlinkCmpKindArray = { link = "@punctuation.bracket" },
  BlinkCmpKindBoolean = { link = "@boolean" },
  BlinkCmpKindCodeium = { fg = colors.sky_accent, bg = colors.none },
  BlinkCmpKindClass = { link = "@type" },
  BlinkCmpKindColor = { link = "Special" },
  BlinkCmpKindConstant = { link = "@constant" },
  BlinkCmpKindConstructor = { link = "@constructor" },
  BlinkCmpKindEnum = { link = "@lsp.type.enum" },
  BlinkCmpKindEnumMember = { link = "@lsp.type.enumMember" },
  BlinkCmpKindEvent = { link = "Special" },
  BlinkCmpKindField = { link = "@variable.member" },
  BlinkCmpKindFile = { link = "Normal" },
  BlinkCmpKindFolder = { link = "Directory" },
  BlinkCmpKindFunction = { link = "@function" },
  BlinkCmpKindInterface = { link = "@lsp.type.interface" },
  BlinkCmpKindKey = { link = "@variable.member" },
  BlinkCmpKindKeyword = { link = "@lsp.type.keyword" },
  BlinkCmpKindMethod = { link = "@function.method" },
  BlinkCmpKindModule = { link = "@module" },
  BlinkCmpKindNamespace = { link = "@module" },
  BlinkCmpKindNull = { link = "@constant.builtin" },
  BlinkCmpKindNumber = { link = "@number" },
  BlinkCmpKindObject = { link = "@constant" },
  BlinkCmpKindOperator = { link = "@operator" },
  BlinkCmpKindPackage = { link = "@module" },
  BlinkCmpKindProperty = { link = "@property" },
  BlinkCmpKindReference = { link = "@markup.link" },
  BlinkCmpKindSnippet = { link = "Conceal" },
  BlinkCmpKindString = { link = "@string" },
  BlinkCmpKindStruct = { link = "@lsp.type.struct" },
  BlinkCmpKindUnit = { link = "@lsp.type.struct" },
  BlinkCmpKindText = { link = "@markup" },
  BlinkCmpKindTypeParameter = { link = "@lsp.type.typeParameter" },
  BlinkCmpKindVariable = { link = "@variable" },
  BlinkCmpKindValue = { link = "@string" },
  BlinkCmpSignatureHelpBorder = { fg = colors.fg1, bg = colors.bg2 },
}

-- TODO: git commit messages
-- TODO: Flash plugin
-- TODO: bufferline

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
  require("nvim.lua.irises.init").load()
end

return Irises
