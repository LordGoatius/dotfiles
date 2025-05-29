vim.opt.number = true
vim.opt.smartcase = false
vim.opt.hlsearch = false
vim.opt.wrap = false
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.matchpairs:append("<:>")
vim.opt.filetype.plugins = true
vim.opt.filetype.indentation = true
vim.syntax = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.wo.relativenumber = true

vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.opt.undofile = true

vim.keymap.set('n', 'gd', '<C-]>', { noremap = true })
vim.keymap.set('i', '<C-/>', 'copilot#Accept()',  { expr=true, noremap = true, silent = true })
vim.keymap.set('n', 'gh', vim.lsp.buf.hover, {})
vim.keymap.set({'n', 'v'}, "K", "6k", { noremap = true })
vim.keymap.set({'n', 'v'}, "J", "6j", { noremap = true })
vim.keymap.set('n', "<C-n>", ":bn<CR>", { noremap = true })
vim.keymap.set('n', "<C-p>", ":bp<CR>", { noremap = true })

vim.api.nvim_set_keymap('n', ' cc', "<Plug>CoqStart", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ' cj', "<Plug>CoqNext", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ' ck', "<Plug>CoqUndo", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ' cq', "<Plug>CoqStop", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ' cl', "<Plug>CoqToLine", { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '<C-Down>', "<Plug>CoqNext", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-Up>', "<Plug>CoqUndo", { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-Left>', "<Plug>CoqToLine", { noremap = true, silent = true })

local lazy = {}
lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

function lazy.install(path)
    if not vim.uv.fs_stat(path) then
        print('Installing lazy.nvim')
        vim.fn.system({
            'git',
            'clone',
            '--filter=blob:none',
            'https://github.com/folke/lazy.nvim.git',
            '--branch=stable',
            path,
        })
    end
end

function lazy.setup(plugins)
    lazy.install(lazy.path)

    vim.opt.rtp:prepend(lazy.path)
    require('lazy').setup(plugins, lazy.opts)
end

lazy.setup({
    {'Mofiqul/vscode.nvim'},
    {'iruzo/matrix-nvim'},
    {'nvim-tree/nvim-web-devicons'},
    {'nvim-lua/plenary.nvim'},
    {'nvim-lualine/lualine.nvim'},
    {'MunifTanjim/nui.nvim'},
    {'nvim-neo-tree/neo-tree.nvim'},
    {'williamboman/mason.nvim'},
    {'neovim/nvim-lspconfig'},
    {'williamboman/mason-lspconfig.nvim'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/nvim-cmp'},
    {'onsails/lspkind.nvim'},
    {'akinsho/bufferline.nvim'},
    {'nvim-tree/nvim-tree.lua'},
    {'nvim-treesitter/nvim-treesitter'},
    {'jiangmiao/auto-pairs'},
    {'L3MON4D3/LuaSnip'},
    {'nvim-telescope/telescope.nvim'},
    {'kdheepak/lazygit.nvim'},
    {'lervag/vimtex'},
    {'windwp/nvim-ts-autotag'},
    {'andweeb/presence.nvim'},
    {'github/copilot.vim'},
    {'jghauser/mkdir.nvim'},
    {'christoomey/vim-tmux-navigator'},
    {'whonore/Coqtail'},
    {'mlaursen/vim-react-snippets'},
    {'Julian/lean.nvim'},
    {'numToStr/Comment.nvim'},
    {"scottmckendry/cyberdream.nvim"},
})

require('Comment').setup {
    --- Add a space b/w comment and the line
    padding = true,
    --- Whether the cursor should stay at its position
    sticky = true,
    --- Lines to be ignored while (un)comment
    ignore = nil,
    -- - LHS of toggle mappings in NORMAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = 'gcc',
        -- Block-comment toggle keymap
        block = 'gbc',
    },
    --- LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = 'gc',
        ---Block-comment keymap
        block = 'gb',
    },
    --- LHS of extra mappings
    extra = {
        ---Add comment on the line above
        above = 'gcO',
        ---Add comment on the line below
        below = 'gco',
        ---Add comment at the end of line
        eol = 'gcA',
    },
    --- Enable keybindings
    --- NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = true,
    },
    --- Function to call before (un)comment
    pre_hook = nil,
    --- Function to call after (un)comment
    post_hook = nil,
}

require('presence').setup()

require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "c", "yaml", "toml", "lua", "vim", "vimdoc", "query", "rust", "css", "html", "javascript",  "typescript", "tsx", "php" , "zig", "svelte", "haskell", "cmake", "bash"},

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false,

    -- List of parsers to ignore installing (for "all")
    ignore_install = { },

    modules = { },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
      enable = true,

      -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
      -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
      -- the name of the parser)
      -- list of language that will be disabled
      -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
      disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
              return true
          end
      end,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
}

vim.treesitter.language.register("python", "by")
vim.treesitter.language.register("ebnf", "ebnf")
vim.filetype.add({
    extension = {
        by = "by",
        ebnf = "ebnf",
    }
})

require('nvim-tree').setup()
require('nvim-ts-autotag').setup()

vim.opt.termguicolors = true

vim.g.matrix_disable_background = true
require('matrix').set()
require('vscode').setup({
    transparent = true,
})
require('vscode').load()
vim.cmd.colorscheme('vscode')

require("cyberdream").setup({
    -- Set light or dark variant
    variant = "default", -- use "light" for the light variant. Also accepts "auto" to set dark or light colors based on the current value of `vim.o.background`
    -- Enable transparent background
    transparent = true,
    -- Reduce the overall saturation of colours for a more muted look
    saturation = 1, -- accepts a value between 0 and 1. 0 will be fully desaturated (greyscale) and 1 will be the full color (default)
    -- Enable italics comments
    italic_comments = false,
    -- Replace all fillchars with ' ' for the ultimate clean look
    hide_fillchars = false,
    -- Apply a modern borderless look to pickers like Telescope, Snacks Picker & Fzf-Lua
    borderless_pickers = false,
    -- Set terminal colors used in `:terminal`
    terminal_colors = true,
    -- Improve start up time by caching highlights. Generate cache with :CyberdreamBuildCache and clear with :CyberdreamClearCache
    cache = false,
    -- Override highlight groups with your own colour values
    highlights = {
        -- Highlight groups to override, adding new groups is also possible
        -- See `:h highlight-groups` for a list of highlight groups or run `:hi` to see all groups and their current values
        -- Example:
        Comment = { fg = "#696969", bg = "NONE", italic = true },
        -- More examples can be found in `lua/cyberdream/extensions/*.lua`
    },
    -- Override a highlight group entirely using the built-in colour palette
    overrides = function(colors) -- NOTE: This function nullifies the `highlights` option
        -- Example:
        return {
            Comment = { fg = colors.green, bg = "NONE", italic = true },
            ["@property"] = { fg = colors.magenta, bold = true },
        }
    end,
    -- Override a color entirely
    colors = {
        -- For a list of colors see `lua/cyberdream/colours.lua`
        -- Example:
        bg = "#000000",
        green = "#00ff00",
        magenta = "#ff00ff",
    },
    -- Disable or enable colorscheme extensions
    extensions = {
        telescope = true,
        notify = true,
        mini = true,
        ...
    },
})
-- vim.cmd.colorscheme('cyberdream')

require('lualine').setup {
    options = {
        theme = 'matrix'
    }
}
require('mason').setup()
require('telescope').setup()

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local status, nvim_lsp = pcall(require, "lspconfig")
if (not status) then return end

vim.diagnostic.config({
    virtual_text = true,
})

local on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function() end
        })
    end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
)

capabilities.textDocument.completion.completionItem.snippetSupport = true

local status, cmp = pcall(require, "cmp")
if (not status) then return end
local lspkind = require('lspkind')

local luasnip = require('luasnip')

require('vim-react-snippets')

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-1),
        ['<C-f>'] = cmp.mapping.scroll_docs(1),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable() 
          -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "lazydev" },
        { name = "nvim_lsp" },
        { name = "path" },
        }, {
           { name = "buffer" },
        }),
    formatting = {
        format = lspkind.cmp_format({ with_text = false, maxwidth = 50 })
    }
})

require('lean').setup{
    mappings = true,
    abbreviations = {
      enable = true,
    },
    infoview = {
      autoopen = true,

      width = 50,
      height = 20,

      horizontal_position = "bottom",

      separate_tab = false,

      indicators = "auto",
    },
}

local infoview = require('lean.infoview').get_current_infoview()
if infoview then
    infoview.move_to_bottom()
end

nvim_lsp.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

nvim_lsp.gleam.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

nvim_lsp.asm_lsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

nvim_lsp.zls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

nvim_lsp.ts_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

nvim_lsp.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

nvim_lsp.intelephense.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

nvim_lsp.julials.setup {
    -- on_attach = on_attach,
    -- capabilities = capabilities,
}

nvim_lsp.cssls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

nvim_lsp.wgsl_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

nvim_lsp.ghcide.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

nvim_lsp.kotlin_language_server.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

nvim_lsp.pylsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = {
                    ignore = {
                        'E203',
                        'E302',
                        'E305',
                        'E231',
                        'E226',
                        'E265',
                        'E201',
                        'E128',
                        'E124',
                        'E221'
                    },
                    maxLineLength = 150
                }
            }
        }
    }
}

nvim_lsp.html.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
        "html",
        "mustache",
    }
}

nvim_lsp.lua_ls.setup {
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT',
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {'vim'},
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
        },
    },
}

nvim_lsp.sqlls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
}

require('bufferline').setup({
    options = {
        buffer_close_icon = "",
        close_command = "bdelete %d",
        close_icon = "",
        indicator = {
          style = "icon",
          icon = " ",
        },
        left_trunc_marker = "",
        modified_icon = "●",
        offsets = { { filetype = "NvimTree", text = "EXPLORER", text_align = "center" } },
        right_mouse_command = "bdelete! %d",
        right_trunc_marker = "",
        show_close_icon = false,
        show_tab_indicators = true,
    },
    highlights = {
        fill = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
        },
        background = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "StatusLine" },
        },
        buffer_visible = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "Normal" },
        },
        buffer_selected = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "Normal" },
        },
        separator = {
            fg = { attribute = "bg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "StatusLine" },
        },
        separator_selected = {
            fg = { attribute = "fg", highlight = "Special" },
            bg = { attribute = "bg", highlight = "Normal" },
        },
        separator_visible = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "StatusLineNC" },
        },
        close_button = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "StatusLine" },
        },
        close_button_selected = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "Normal" },
        },
        close_button_visible = {
            fg = { attribute = "fg", highlight = "Normal" },
            bg = { attribute = "bg", highlight = "Normal" },
        },
    },
})


vim.cmd [[
    set completeopt=menuone,noinsert,noselect
    highlight! default link CmpItemKind CmpItemMenuDefault
]]
