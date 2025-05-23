local colors = require("irises.colors")
return {
  normal = {
    a = { bg = colors.fg2, fg = colors.bg2, gui = "bold" },
    b = { bg = colors.bg1, fg = colors.fg1 },
    c = { bg = colors.bg2, fg = colors.fg2 },
  },
  insert = {
    a = { bg = colors.iris_blue, fg = colors.bg1, gui = "bold" },
    b = { bg = colors.bg1, fg = colors.fg1 },
    c = { bg = colors.bg2, fg = colors.fg2 },
  },
  visual = {
    a = { bg = colors.fresh_green, fg = colors.bg1, gui = "bold" },
    b = { bg = colors.bg1, fg = colors.fg1 },
    c = { bg = colors.bg2, fg = colors.fg2 },
  },
  replace = {
    a = { bg = colors.rust_orange, fg = colors.bg1, gui = "bold" },
    b = { bg = colors.bg1, fg = colors.fg1 },
    c = { bg = colors.bg2, fg = colors.fg2 },
  },
  command = {
    a = { bg = colors.ochre_yellow, fg = colors.bg1, gui = "bold" },
    b = { bg = colors.bg1, fg = colors.fg1 },
    c = { bg = colors.bg2, fg = colors.fg2 },
  },
  inactive = {
    a = { bg = colors.fg2, fg = colors.bg2, gui = "bold" },
    b = { bg = colors.bg1, fg = colors.fg1 },
    c = { bg = colors.bg2, fg = colors.fg2 },
  },
}
