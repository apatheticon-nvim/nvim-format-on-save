# nvim-format-on-save

```lua
-- TODO: Change the repo url in installation examples
```

A neovim plugin to auto-format a file on save.

* [Features](#features)
* [Installation](#installation)
* [Usage](#usage)
* [Config](#config)
* [Dev Installation](#dev-installation)
* [License](#license)


## Features

* This plugin only formats the current buffer.
* It can format the current buffer automatically when saved. **(configurable)**
* It can add an empty line at the end if there is none. **(configurable)**
* You can specify which filetypes to include or exclude from auto-formatting.
* You can provide custom formatter function.
* Provides API functions that can be used with keymaps.


## Installation

Install this plugin with any plugin manager and then call `require("nvim-format-on-save").setup()`

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "apatheticon/nvim-format-on-save",
  lazy = false,
  opts = {
    ft = "all",
  },
  config = function(_, opts)
    require("nvim-format-on-save").setup(opts)
  end,
}
```


## Usage

By default, if `opts` is not provided, this plugin does not format any filetype.

In the below examples `opts` should be passed to `setup()` function.
In [lazy.nvim](https://github.com/folke/lazy.nvim) plugin manager, you can set `opts` as a field.

```lua
require("nvim-format-on-save").setup(opts)
```

To enable formatting for all filetypes:

```lua
local opts = {
  ft = "all",
}
```

To disable formatting for all filetypes:

```lua
local opts = {
  ft = "none",
}
```

To enable formatting for only certain filetypes:

```lua
local opts = {
  ft = {
    "lua",
    "c",
    "javascript",
  },
}
```

Another way, to enable formatting for only certain filetypes:

```lua
local opts = {
  ft = "none",
  override_ft = {
    lua = true,
    c = true,
    javascript = true,
  },
}
```

Use `override_ft` to override `ft` option.

Format all filetypes except Lua and JavaScript:

```lua
local opts = {
  ft = "all",
  override_ft = {
    lua = false,
    javascript = false,
  },
}
```

Override `ft` table using `override_ft` table. See the example below.

Even if you change `ft` to `"all"` or `"none"`, Lua and Rust will always be formatted on save.
But JavaScript will never be formatted on save.

```lua
local opts = {
  ft = {
    "lua",
    "c",
    "rust",
    "javascript",
    "typescript",
  },
  override_ft = {
    lua = true,
    rust = true,
    javascript = false,
  },
}
```


## Config

### Default Config

```lua
local opts = {
  -- Enable or disable formatter (including ensuring newline)
  enabled = true,

  -- Filetypes to be formatted on save
  -- Values can be "all", "none", or table of filetypes (e.g., { "lua", "c" })
  ft = {},

  -- Table of key-value pairs that override `ft` option.
  -- Lua will always be formatted and C will never be formatted in example below
  -- e.g., { lua = true, c = false }
  override_ft = {},

  -- Ensure newline character at the end of file, i.e., empty line at the end
  -- Setting it to false does not remove already existing empty lines at the end
  ensure_newline = true,

  -- The function that is used to format the files
  formatter = function()
    vim.lsp.buf.format { async = false }
  end,
}
```


## Dev Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

`~/projects` is the default directory where `lazy.nvim` looks for local plugin projects.
You can change that by setting `dev.path` to a custom directory when passing options to `lazy.nvim` plugin.

* Move the `nvim-format-on-save` plugin directory to `~/projects`.
* Add `nvim-format-on-save` plugin in `lazy.nvim`.
    * Set the first item to `"nvim-format-on-save"`
    * Set `name` to `"nvim-format-on-save"`

```lua
local opts = {
  dev = { path = "~/projects" },
}

local plugins = {
  {
    "nvim-format-on-save",
    name = "nvim-format-on-save",
    dev = true,
    lazy = false,
    opts = {},
    config = function(_, opts)
      require("nvim-format-on-save").setup(opts)
    end,
  }
}

require("lazy").setup(plugins, opts)
```

If the above code is not working then remove `name = "nvim-format-on-save"` and then set `dir` to the full path of the directory of the plugin project.

```lua
local plugins = {
  {
    "nvim-format-on-save",
    dir = "~/projects/nvim-format-on-save",
    dev = true,
    lazy = false,
    opts = {},
    config = function(_, opts)
      require("nvim-format-on-save").setup(opts)
    end,
  }
}
```


## License

This work is licensed under multiple licenses (or any later version).
You can choose between one of them if you use this work.

* [MIT](https://spdx.org/licenses/MIT.html)
* [MIT-0](https://spdx.org/licenses/MIT-0.html)
* [Apache-2.0](https://spdx.org/licenses/Apache-2.0.html)


```
SPDX-License-Identifier: MIT OR MIT-0 OR Apache-2.0
```

### About MIT-0 License

* MIT-0 license is a modified version of MIT license with the attribution paragraph removed.
* MIT-0 license is similar to [0BSD](https://spdx.org/licenses/0BSD.html) license.
* MIT-0 license is OSI approved. ([MIT-0 license OSI page](https://opensource.org/license/mit-0))

<!-- vim:set ts=2 sts=2 sw=2: -->

