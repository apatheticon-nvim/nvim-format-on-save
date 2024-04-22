# nvim-format-on-save

A neovim plugin to auto-format when a buffer is saved.

* This plugin only formats the current buffer.
* It can format the current buffer automatically when saved. **(configurable)**
* It can add an empty line at the end if there is none. **(configurable)**
* You can tell it which file types to include or exclude from auto-formatting.
* You can provide custom formatter function.
* You can set keymaps to toggle on or off auto-formatting.

* [Installation](#installation)
* [Dev Installation](#dev-installation)
* [License](#license)


## Installation

Install this plugin with any plugin manager and then call `require("nvim-format-on-save").setup()`

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
    {
        "apatheticon/nvim-format-on-save",
        lazy = false,
        opts = {},
        config = function(_, opts)
            require("nvim-format-on-save").setup(opts)
        end,
    }
```


## Dev Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

`~/projects` is the default directory where `lazy.nvim` looks for local plugin projects. You can change that by setting `dev.path` to a custom directory when passing options. 

* Move the `nvim-format-on-save` plugin directory to `~/projects`.
* Set the first item as `"nvim-format-on-save"`
* Set `name` as `"nvim-format-on-save"`

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

If in case the above is not working then remove `name = "nvim-format-on-save"` and then set `dir` to the full path of the directory of the plugin project.

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


