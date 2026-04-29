local progress_status = {
  client = nil,
  kind = nil,
  title = nil,
  icon = nil,
}
return {
  {
    "sschleemilch/slimline.nvim",
    opts = function()
      local function lsp_progress_component(active)
        if not progress_status.client or not progress_status.title then
          return ""
        end
        local formatted_status =
          string.format("%s %s: %s", progress_status.icon, progress_status.client, progress_status.title)
        return Slimline.highlights.hl_component(
          { primary = formatted_status },
          Slimline.highlights.hls.components["git"],
          Slimline.get_sep("git"),
          "right",
          active,
          "fg"
        )
      end
      vim.api.nvim_create_autocmd("LspProgress", {
        callback = vim.schedule_wrap(function(ev)
          if not ev.data then
            return
          end

          progress_status = {
            client = vim.lsp.get_client_by_id(ev.data.client_id).name,
            kind = ev.data.params.value.kind,
            title = ev.data.params.value.title,
          }
          local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
          progress_status.icon = spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]

          if progress_status.kind == "end" then
            progress_status.title = nil
            vim.cmd.redrawstatus()
          else
            vim.cmd.redrawstatus()
          end
        end),
      })
      return {
        -- Merge of the pure and stealth recipes
        style = "fg",
        bold = true,
        hl = {
          primary = "StatusLine",
          secondary = "StatusLineNC",
          base = "StatusLine",
          base_inactive = "StatusLineNC",
        },
        configs = {
          path = {
            hl = {
              primary = "Label",
            },
          },
          git = {
            hl = {
              primary = "Function",
            },
          },
          filetype_lsp = {
            hl = {
              primary = "String",
            },
          },
          progress = {
            follow = false,
          },
        },
        spaces = {
          components = "",
          left = "",
          right = "",
        },
        components = {
          left = {
            "mode",
            "path",
            "git",
          },
          center = {},
          right = {
            lsp_progress_component,
            "diagnostics",
            "filetype_lsp",
            "progress",
          },
        },
      }
    end,
  },
}
