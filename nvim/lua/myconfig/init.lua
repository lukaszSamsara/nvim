vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  }
})
require("mason").setup({})
require('nvim-navic').setup({})
local lspconfig= require('lspconfig')
local configs = require 'lspconfig/configs'

lspconfig.gopls.setup({
 on_attach = function(client, bufnr)
   require('nvim-navic').attach(client, bufnr)
 end,
 cmd = { 'gopls', 'serve' },
 filetypes = { 'go', 'gomod' },
 root_dir = require 'lspconfig/util'.root_pattern('go.work', 'go.mod', '.git'),
 settings = {
  gopls = {
    codelenses = {
      test = true
    },
    analyses = {
      unusedparams = true,
    },
    staticcheck = true,
  },
 },
})

local cmp = require('cmp')

local lsp_defaults = {
  flags = {
    debounce_text_changes = 151,
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})
  end
}
lspconfig.util.default_config = vim.tbl_deep_extend(
'force',
lspconfig.util.default_config,
lsp_defaults
)
lspconfig.ts_ls.setup({})
lspconfig.eslint.setup({})
lspconfig.eslint.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    validate = "on",
    packageManager = "yarn",
  },
  root_dir = lspconfig.util.root_pattern(".eslintrc-incremental.js", "package.json"),
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", ".tsx"},
})

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Esc>'] = cmp.mapping.close(),
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),
    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'vsnip' },
  }
})

require("nvim-web-devicons").setup({})

require("nvim-tree").setup({
  view = {
    width = 60,
  }
})

vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, bufopts)
vim.keymap.set('n', 'gl', vim.diagnostic.setloclist, bufopts)
vim.keymap.set('n', 'gh', vim.diagnostic.open_float, bufopts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)

require("fidget").setup({})

require("trouble").setup({})

local navic = require 'nvim-navic'
            require 'lualine'.setup {
                options = {
                    icons_enabled = true,
                    path = 1,
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_a = { { 'mode', fmt = function(str)
                        local lower_mode = str:lower()
                        local single_char = lower_mode:sub(1, 1)
                        local first_mode = lower_mode:sub(1, 2)
                        if first_mode == "v-" then
                            return lower_mode
                        end
                        return single_char

                    end } },
                    lualine_b = {
                        {
                            'diff',
                            on_click = function(_,_,_)
                                vim.cmd('Gvdiffsplit')
                            end
                        },
                        {
                            'diagnostics',
                            on_click = function(_,_,_)
                              vim.cmd('Trouble diagnostics toggle focus=true filter.buf=0')
                            end

                        }
                    },
                    lualine_c = {
                        {
                            'filename',
                            symbols = {
                                readonly = '',      -- Text to show when the file is non-modifiable or readonly.
                            }
                        }
                    },
                    lualine_x = {
                        {
                            'encoding',
                        },
                        -- {
                        --     function()
                        --         local space_pat = [[\v^ +]]
                        --         local tab_pat = [[\v^\t+]]
                        --         local space_indent = vim.fn.search(space_pat, 'nwc')
                        --         local tab_indent = vim.fn.search(tab_pat, 'nwc')
                        --         local mixed = (space_indent > 0 and tab_indent > 0)
                        --         local mixed_same_line
                        --         if not mixed then
                        --             mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
                        --             mixed = mixed_same_line > 0
                        --         end
                        --         if not mixed and space_indent > 0 then
                        --             return "󱁐"
                        --         end
                        --         if not mixed and tab_indent > 0 then
                        --             return "󰌒"
                        --         end
                        --         if mixed_same_line ~= nil and mixed_same_line > 0 then
                        --             return ':'..mixed_same_line
                        --         end
                        --         local space_indent_cnt = vim.fn.searchcount({pattern=space_pat, max_count=1e3}).total
                        --         local tab_indent_cnt =  vim.fn.searchcount({pattern=tab_pat, max_count=1e3}).total
                        --         if space_indent_cnt == 0 and tab_indent_cnt == 0 then
                        --             return "󰢤"
                        --         end
                        --         if space_indent_cnt > tab_indent_cnt then
                        --             return ':'..tab_indent
                        --         else
                        --             return ':'..space_indent
                        --         end
                        --     end
                        -- },
                       {
                           'filetype',
                           on_click = function(_,_,_)
                               require('fzf-lua').filetypes()
                           end
                       }
                    },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' }
                },
                tabline = {
                    lualine_a = {
                        {
                            function()
                                local msg = ''
                                local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                                local clients = vim.lsp.get_active_clients()
                                if next(clients) == nil then
                                    return msg
                                end
                                for _, client in ipairs(clients) do
                                    local filetypes = client.config.filetypes
                                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                        return " " .. client.name
                                    end
                                end
                                return msg
                            end,
                            on_click = function(_,_,_)
                                vim.cmd('LspInfo')
                            end
                        }
                    },
                    lualine_b = {
                        {
                            'branch',
                            on_click = function(_,_,_)
                                LazygitToggle()
                            end
                        },
                    },
                    lualine_c = {
                        {
                            function() return navic.get_location() end,
                            cond = navic.is_available,
                        },
                    },
                    lualine_z = {
                        {
                            function()
                                local hostname = vim.loop.os_gethostname()
                                if string.find(hostname, 'local') then
                                    return 'λ'
                                else
                                    return 'δ'
                                end
                            end
                        }
                    },
                    lualine_y = {
                        {
                            'tabs',
                            mode = 0,
                        },
                    }
                },
                extensions = {
                    'fzf',
                    'lazy',
                    'toggleterm',
                    'symbols-outline',
                    'trouble',
                    'neo-tree',
                    {
                       filetypes = { 'help' },
                       sections = {
                           lualine_a = { function () return '?' end },
                           lualine_c = {
                               {
                                   'filename',
                                   path = 0,
                                   symbols = {
                                       readonly = '',
                                   }
                               }
                           },
                           lualine_z = { 'location' },
                       }

                    },
                    {
                       filetypes = { 'fugitiveblame' },
                       sections = {
                           lualine_a = { function ()
                               return 'Blame'
                           end },
                           lualine_z = { 'location' },
                       }

                    },
                    {
                        filetypes = { 'qf' },
                        sections = {
                            lualine_a = { function ()
                                if vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0 then
                                    return 'Loclist'
                                else
                                    return 'Quickfix'
                                end
                            end },
                            lualine_b = { function ()
                                if vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0 then
                                    return vim.fn.getloclist(0, { title = 0 }).title
                                else
                                    return vim.fn.getqflist({ title = 0 }).title
                                end
                            end },
                            lualine_z = { 'location' },
                        }
                     }
                },
            }

