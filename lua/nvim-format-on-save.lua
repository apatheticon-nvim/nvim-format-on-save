---@class NvimFormatOnSaveModule
local M = {}

---@class Config
---@field ft ("all" | "none" | string[]) File types to be formatted on save
---@field override_ft {[string]: boolean} Override ft option
---@field ensure_newline boolean Ensure newline at the end of the file
local config = {
  enabled = true,
  ft = {},
  override_ft = {},
  ensure_newline = true,
  formatter = function()
    vim.lsp.buf.format { async = false }
  end,
}

---@type Config
M._config = config

---@type {[string]: boolean} Filetypes that should be formatted on save
M._included_filetypes = {}

---@type {[string]: boolean} Exclude when ft = "all"
M._excluded_filetypes = {}

---@type boolean Is formatter enabled?
M._enabled = true


M._format = function() end

-- Used by M.toggle()
M._format_fn_backup = function() end


M._ensure_newline = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local line_count = vim.api.nvim_buf_line_count(bufnr)
  local last_line = vim.api.nvim_buf_get_lines(bufnr, line_count - 1, line_count, false)[1]

  if last_line ~= "" then
    vim.api.nvim_buf_set_lines(bufnr, line_count, line_count, false, { "" })
  end
end


M._format_exclude = function()
  if not M._excluded_filetypes[vim.bo.filetype] then
    M._config.formatter()
    if M._config.ensure_newline then
      M._ensure_newline()
    end
  end
end


M._format_include = function()
  if M._included_filetypes[vim.bo.filetype] then
    M._config.formatter()
    if M._config.ensure_newline then
      M._ensure_newline()
    end
  end
end


---@param opts Config?
M.setup = function(opts)
  M._config = vim.tbl_deep_extend("force", M._config, opts or {})
  M._enabled = M._config.enabled

  if M._config.ft == "none" then
    for filetype, should_format in pairs(M._config.override_ft) do
      if should_format then
        M._included_filetypes[filetype] = true
      end
    end

    if vim.tbl_isempty(M._included_filetypes) then
      M._format = function() end
    else
      M._format = M._format_include
    end
  end

  if M._config.ft == "all" then
    for filetype, should_format in pairs(M._config.override_ft) do
      if not should_format then
        M._excluded_filetypes[filetype] = true
      end
    end
    M._format = M._format_exclude
  end


  if type(M._config.ft) == "table" then
    for _, filetype in ipairs(M._config.ft) do
      local should_include_ft = M._config.override_ft[filetype]
      -- Exclude filetype only if 'should_include_ft' value exists and is false
      if should_include_ft == nil or should_include_ft == true then
        M._included_filetypes[filetype] = true
      end
    end

    for filetype, should_format in pairs(M._config.override_ft) do
      if should_format then
        M._included_filetypes[filetype] = true
      end
    end

    if vim.tbl_isempty(M._included_filetypes) then
      M._format = function() end
    else
      M._format = M._format_include
    end
  end

  -- M.toggle() uses this backup to restore the format function
  M._format_fn_backup = M._format

  local format_augroup =
      vim.api.nvim_create_augroup("FormatOnSave", { clear = true })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = format_augroup,
    pattern = "*",
    callback = function()
      M._format()
    end
  })
end

---@param enabled boolean? Toggle auto-formatting on or off
M.toggle = function(enabled)
  if enabled == nil then
    M.toggle(not M._enabled)
  elseif enabled == true then
    M._format = M._format_fn_backup
    M._enabled = true
  elseif enabled == false then
    M._format = function() end
    M._enabled = false
  end
end

---@return Config
M.get_config = function()
  return vim.inspect(M._config)
end

M.print_config = function()
  vim.notify(vim.inspect(M._config))
end

return M

