# schwarzwald.nvim

Dark green theme for Neovim $\ge$ 0.5 forked from
[OneDark.nvim](https://github.com/ribru17/bamboo.nvim). Theme written in Lua
with [Tree-sitter](https://github.com/nvim-treesitter/nvim-treesitter) syntax
highlighting and LSP semantic highlighting.

_For latest [Tree-sitter](https://github.com/nvim-treesitter/nvim-treesitter)
syntax highlighting, upgrade to Neovim 0.8.0 or later, built with Tree-sitter
0.20.3+._

## Features

- Blue and purple are used sparingly to help reduce eye strain
- Red, yellow, and green are prioritized more for the same reason
- Comments are colored specifically to be readable and have good contrast with
  other text and background
- _Many_ semantic highlighting tokens are handled and colored nicely
- Light and dark variants
  - Light mode only applies when `vim.o.background = 'light'` (can also use
    `set background=light`)
- Multiple plugins are supported with hand-picked, proper colors
- Colors, highlights, and code style of the theme can be customized as you
  like (refer to [Customization](#customization))
- Integration with other applications (see the
  [`extras`](https://github.com/yelircaasi/schwarzwald.nvim/tree/master/extras)
  directory)

### Regular (`vulgaris`)

<details open>
<summary>Click to toggle previews</summary>

![schwarzwaldmdshowcase](https://github.com/yelircaasi/schwarzwald.nvim/assets/55766287/c2ce1883-d4ad-4ae0-a248-ef668d69aa87)
![schwarzwaldcodeshowcase](https://github.com/yelircaasi/schwarzwald.nvim/assets/55766287/5eb2c125-13cd-46d6-841a-8af3f4406fc1)

</details>

### Greener (`multiplex`)

<details>
<summary>Click to toggle previews</summary>

![schwarzwaldmultiplexshowcase](https://github.com/yelircaasi/schwarzwald.nvim/assets/55766287/e7bb8d9a-95ee-43e4-bcfe-3727ec90fcdd)
![schwarzwaldmultiplexshowcasecode](https://github.com/yelircaasi/schwarzwald.nvim/assets/55766287/6fdb0335-e9bd-4f73-bfba-12e55ddd91f0)

</details>

### Light Mode (`light`)

<details>
<summary>Click to toggle previews</summary>

![schwarzwaldlightshowcasemd](https://github.com/yelircaasi/schwarzwald.nvim/assets/55766287/cee8b8f7-36b3-41af-8d15-ab646bce89d4)
![schwarzwaldlightshowcasecode](https://github.com/yelircaasi/schwarzwald.nvim/assets/55766287/1842892f-4c40-4d83-a5ea-edd2c30895dc)

</details>
<br/>

<!-- End of previews. -->

> [!NOTE]
> The above screenshots utilize Tree-sitter parsers for `lua`, `markdown`,
> `markdown_inline`, `mermaid`, and `latex`.

The `lua` file screenshot also uses a custom query to highlight the `vim` global
as a builtin variable rather than a constant, changing it from pink to red. If
you want this behavior, add the following to a `queries/lua/highlights.scm` file
in your config directory (the `extends` comment is necessary):

```scheme
;; extends
(
 (identifier) @variable.builtin
 (#any-of? @variable.builtin "vim")
 (#set! "priority" 128)
)
```

## Installation

Install via your favorite package manager:

```lua
-- Using lazy.nvim
{
  'yelircaasi/schwarzwald.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('schwarzwald').setup {
      -- optional configuration here
    }
    require('schwarzwald').load()
  end,
},
```

> [!TIP]
> For best results, use (rounded) borders for float windows (or change
> their background to a slightly different color than the main editor background).

## Configuration

### Enable theme

```lua
-- Lua
require('schwarzwald').load()
```

```vim
" Vim
colorscheme schwarzwald
```

## Default Configuration

```lua
-- Lua
require('schwarzwald').setup {
  -- Main options --
  -- NOTE: to use the light theme, set `vim.o.background = 'light'`
  style = 'vulgaris', -- Choose between 'vulgaris' (regular), 'multiplex' (greener), and 'light'
  toggle_style_key = nil, -- Keybind to toggle theme style. Leave it nil to disable it, or set it to a string, e.g. "<leader>ts"
  toggle_style_list = { 'vulgaris', 'multiplex', 'light' }, -- List of styles to toggle between
  transparent = false, -- Show/hide background
  dim_inactive = false, -- Dim inactive windows/buffers
  term_colors = true, -- Change terminal color as per the selected theme style
  ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
  cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

  -- Change code style ---
  -- Options are italic, bold, underline, none
  -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
  code_style = {
    comments = 'italic',
    conditionals = 'italic',
    keywords = 'none',
    functions = 'none',
    namespaces = 'italic',
    parameters = 'italic',
    strings = 'none',
    variables = 'none',
  },

  -- Lualine options --
  lualine = {
    transparent = false, -- lualine center bar transparency
  },

  -- Custom Highlights --
  colors = {}, -- Override default colors
  highlights = {}, -- Override highlight groups

  -- Plugins Config --
  diagnostics = {
    darker = false, -- darker colors for diagnostic
    undercurl = true, -- use undercurl instead of underline for diagnostics
    background = true, -- use background color for virtual text
  },
}
```

### Vimscript Configuration

Schwarzwald can be configured also with Vimscript, using the global dictionary
`g:schwarzwald_config`. **NOTE**: when setting boolean values use `v:true` and
`v:false` instead of 0 and 1.

Example:

```vim
let g:schwarzwald_config = {
  \ 'ending_tildes': v:true,
  \ 'diagnostics': {
    \ 'darker': v:true,
    \ 'background': v:false,
  \ },
\ }
colorscheme schwarzwald
```

## Customization

Example using custom colors and highlights:

```lua
require('schwarzwald').setup {
  colors = {
    bright_orange = '#ff8800', -- define a new color
    green = '#00ffaa', -- redefine an existing color
  },
  highlights = {
    -- make comments blend nicely with background, similar to other color schemes
    ['@comment'] = { fg = '$grey' },

    ['@keyword'] = { fg = '$green' },
    ['@string'] = { fg = '$bright_orange', bg = '#00ff00', fmt = 'bold' },
    ['@function'] = { fg = '#0000ff', sp = '$cyan', fmt = 'underline,italic' },
    ['@function.builtin'] = { fg = '#0059ff' },
  },
}
```

Note that Tree-sitter keywords have been changed after Neovim version 0.8 and
onwards. TS prefix is trimmed and lowercase words are separated with `.`.

The old way before neovim 0.8 looks like this. All highlights used in this
colorscheme can be found in
[this file](https://github.com/yelircaasi/schwarzwald.nvim/blob/master/lua/schwarzwald/highlights.lua).

```lua
require('schwarzwald').setup {
  colors = {
    bright_orange = '#ff8800', -- define a new color
    green = '#00ffaa', -- redefine an existing color
  },
  highlights = {
    TSKeyword = { fg = '$green' },
    TSString = { fg = '$bright_orange', bg = '#00ff00', fmt = 'bold' },
    TSFunction = { fg = '#0000ff', sp = '$cyan', fmt = 'underline,italic' },
    TSFuncBuiltin = { fg = '#0059ff' },
  },
}
```

## Plugins Supported

- [Tree-sitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [LSPDiagnostics](https://neovim.io/doc/user/lsp.html)
- [NvimTree](https://github.com/kyazdani42/nvim-tree.lua)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [WhichKey](https://github.com/folke/which-key.nvim)
- [Dashboard](https://github.com/glepnir/dashboard-nvim)
- [Lualine](https://github.com/hoob3rt/lualine.nvim)
- [GitGutter](https://github.com/airblade/vim-gitgutter)
- [GitSigns](https://github.com/lewis6991/gitsigns.nvim)
- [VimFugitive](https://github.com/tpope/vim-fugitive)
- [DiffView](https://github.com/sindrets/diffview.nvim)
- [Hop](https://github.com/phaazon/hop.nvim)
- [Mini](https://github.com/echasnovski/mini.nvim)
- [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)
- [Neotest](https://github.com/nvim-neotest/neotest)
- [Barbecue](https://github.com/utilyre/barbecue.nvim)
- [ALE](https://github.com/dense-analysis/ale)
- [barbar.nvim](https://github.com/romgrk/barbar.nvim)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- [coc.nvim](https://github.com/neoclide/coc.nvim)
- [Indent Blankline](https://github.com/lukas-reineke/indent-blankline.nvim)
- [dashboard-nvim](https://github.com/nvimdev/dashboard-nvim)
- [aerial.nvim](https://github.com/stevearc/aerial.nvim)
- [symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim)
- Every major rainbow bracket plugin
- Much more!

## Reference

- [onedark.nvim](https://github.com/navarasu/onedark.nvim)
- [Catppuccin for Neovim](https://github.com/catppuccin/nvim)
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)
- [tokyodark.nvim](https://github.com/tiagovla/tokyodark.nvim)

## License

[MIT](https://choosealicense.com/licenses/mit/)
