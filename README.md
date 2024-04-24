# nvim-format-on-save

```lua
-- TODO: Change the repo url in installation examples
```

A neovim plugin to auto-format a file on save.

* [Features](#features)
* [Installation](#installation)
* [Options](#options)
* [API](#api)
* [Dev Installation](#dev-installation)
* [License](#license)


## Features

* This plugin only formats the current buffer.
* It can format the current buffer automatically when saved. **(configurable)**
* It can add an empty line at the end if there is none. **(configurable)**
* You can tell it which filetypes to include or exclude from auto-formatting.
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


## Options

### Default Options

```lua
local opts = {
  enabled = true,
  ft = {},
  override_ft = {},
  ensure_newline = true,
  formatter = function()
    vim.lsp.buf.format { async = false }
  end,
}
```

* [`enabled`](#enabled): `boolean` - Enable or disable auto-formatting (including ensuring newline)
* [`ft`](#ft): `("all" | "none" | string[])` - File types to be auto-formatted
* [`override_ft`](#override_ft): `{[string]: boolean}` - Override `ft` option
* [`ensure_newline`](#ensure_newline): `boolean` - Ensure newline at the end of the file
* [`formatter`](#formatter): `fun(): nil` - Function used to format the file


### `enabled`

```lua
local opts = {
  enabled = false,
  -- enabled = true,
}
```


### `ft`

* `"all"` - Format all filetypes
* `"none"` - Do not format any filetype
* `{ "lua", "c" }` - Table containing the names of filetypes. Format only the filetypes in the table.

The default value of `ft` is an empty table (`{}`)   
This is same as setting it to `"none"`  

```lua
local opts = {
  -- ft = "all",
  -- ft = "none",
  -- ft = {},
  ft = {
    "lua",
    "c",
    "javascript",
  },
}
```


### `override_ft`

Table containing a key-value pair. Key is filetype and value is boolean.

```lua
local opts = {
  override_ft = {
    lua = true,
    c = true,
    javascript = false,
  },
}
```

`true` means formatting will be done on that particular filetype no matter what the value of `ft` is. If `ft` is `"none"` then this can be used to set exceptions. For example, if you do not want to format any filetype except for `lua` and `c` then use the following.

```lua
local opts = {
  ft = "none",
  override_ft = {
    lua = true,
    c = true,
  },
}
```

`false` means formatting will NOT be done on that particular filetype no matter what the value of `ft` is. If `ft` is `"all"` then this can be used to set exceptions. For example, if you want to format all filetypes except for `lua` and `c` then use the following.

```lua
local opts = {
  ft = "all",
  override_ft = {
    lua = false,
    c = false,
  },
}
```

Since the default value of `ft` is an empty table (`{}`) which is same as `"none"`, you can just use `override_ft` without setting `ft`. It has the advantage that even if you change the value of `ft` (for example, from `"all"` to `"none"`), the settings provided in `override_ft` will be applied no matter what. (Depending on the use case, this may be a disadvantage.)

Examples:

```lua
local opts = {
  -- ft = {
  --     "javascript",
  -- },
  override_ft = {
    lua = false,
    c = false,
    javascript = true,
  },
}
```

In the above example, `ft` is commented out because it will have the same effect as `override_ft`.

```lua
local opts = {
  ft = "all",
  override_ft = {
    lua = false,
    c = false,
    javascript = true,
  },
}
```

In the above example, even if we change `ft` to `"none"`, `javascript` will still be auto-formatted.

What if `ft` includes a table containing a certain filetype and `override_ft` sets that filetype to `false`?  
In this case `override_ft` takes over. (That is why it is called `override_ft`). 

For example:

```lua
local opts = {
  ft = {
    "lua",
    "c",
    "javascript",
  },
  override_ft = {
    lua = true,
    javascript = false,
  },
}
```

In the above example, both `lua` and `c` will be auto-formatted. But `javascript` will not be auto-formatted.


### `ensure_newline`

```lua
local opts = {
  ensure_newline = false,
  -- ensure_newline = true,
}
```


### `formatter`

```lua
local opts = {
  formatter = function()
    require("conform").format()
    vim.print("File has been formatted on save")
  end,
}
```


## API

* TODO


## Dev Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

`~/projects` is the default directory where `lazy.nvim` looks for local plugin projects. You can change that by setting `dev.path` to a custom directory when passing options to `lazy.nvim` plugin. 

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

* TODO

<!-- vim:set ts=2 sts=2 sw=2: -->

