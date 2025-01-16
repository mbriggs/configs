return {
  finder = function(opts, filter)
    local ok_aerial, aerial = pcall(require, "aerial")
    if not ok_aerial then
      vim.notify("aerial not found", vim.log.levels.ERROR)
      return {}
    end

    aerial.sync_load()

    local backends = require("aerial.backends")
    local data = require("aerial.data")
    local config = require("aerial.config")
    local backend = backends.get()
    if not backend then
      backends.log_support_err()
      return
    elseif not data.has_symbols(0) then
      backend.fetch_symbols_sync(0)
    end

    local items = {}
    local bufnr = vim.api.nvim_get_current_buf()
    local bufdata = data.get_or_create(bufnr)

    for i, symbol in bufdata:iter({ skip_hidden = false }) do
      if opts.filter_kind and not opts.filter_kind[symbol.kind] then
        goto continue
      end

      local indent = string.rep("  ", symbol.level)
      local icon = config.get_icon(bufnr, symbol.kind)
      local kind = " " .. symbol.kind

      local text = string.format("%s%s %s%s", indent, icon, symbol.name, kind)

      -- Create item with all required fields
      local item = {
        idx = i,
        text = text,
        symbol = symbol,
        buf = bufnr,
        -- Ensure pos and end_pos have both line and column
        pos = { symbol.lnum or 1, symbol.col or 0 },
        end_pos = symbol.end_lnum and { symbol.end_lnum, symbol.end_col or 0 },
        kind = symbol.kind,
        level = symbol.level,
        name = symbol.name,
        -- Add highlights for the formatted text
        highlights = {
          {
            { icon,        require("aerial.highlight").get_highlight(symbol, true, false) },
            { symbol.name, require("aerial.highlight").get_highlight(symbol, false, false) }
          }
        },
        -- Add score field required by Snacks
        score = 1
      }

      if filter:match(item) then
        table.insert(items, item)
      end

      ::continue::
    end

    if #items == 0 then
      vim.notify("No symbols found", vim.log.levels.WARN)
      return items
    end

    return items
  end,
  preview = "file",
  format = require("snacks.picker.format").lsp_symbol,
  auto_confirm = true,
  layout = {
    preset = "vertical",
    height = 0.5,
    width = 0.7,
  },
  prompt = "Symbols❯ ",
  actions = {
    ["<c-x>"] = { "edit_split", mode = { "i", "n" } },
    ["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
    ["<c-t>"] = { "edit_tab", mode = { "i", "n" } },
  },
  confirm = function(picker, item)
    picker:close()
    if item and item.pos then
      vim.api.nvim_win_set_cursor(0, item.pos)
      vim.cmd("normal! zz") -- Center cursor
    end
  end,
}
