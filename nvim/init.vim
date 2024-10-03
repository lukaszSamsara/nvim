syntax enable        " enable syntax processing
set nowrap           " turn off word wapring/wrapping

set tabstop=2        " number of visual spaces per tab
set softtabstop=2    " number of spaces in tab when editing
set shiftwidth=2     " number of spaces with movving with << or >>
set expandtab        " tabs are automatically converted to spaces

set nu               " show line numbers

set wildmenu         " visual autocomplete for command menu
set showmatch        " hightlight matching opening and closing [{()}]

set linebreak        " only break between words
set smartindent      " indents according to the syntax/style of code
set cmdheight=2      " height of the command line area

set signcolumn=yes   " left side bar for linting/git/errors

set incsearch        " search as characters are entered

set encoding=UTF-8
set termguicolors

" This will show you all the spaces, tabs, and trailing spaces in your code
"set listchars=tab:>·,trail:~,space:·
set listchars=tab:⇤–⇥,space:~,trail:·,precedes:⇠,extends:⇢,nbsp:×
set list

" Set an 80 line column and its color
set colorcolumn=80   " highlight column
highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'williamboman/mason.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'gpanders/editorconfig.nvim'
Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'vim-autoformat/vim-autoformat'
Plug 'marko-cerovac/material.nvim'
"Plug 'ray-x/lsp_signature.nvim'
Plug 'SmiteshP/nvim-navic'
Plug 'j-hui/fidget.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
Plug 'folke/trouble.nvim'
Plug 'github/copilot.vim'
Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'
call plug#end()

noremap <leader>w :set list!<cr>

nnoremap <C-Up> 10k
nnoremap <C-Down> 10j
inoremap <C-Up> <Esc><Esc>10ki
inoremap <C-Down> <Esc><Esc>10ji

nnoremap <C-s> <cmd>w<cr>
nnoremap <Leader>/ :noh<CR>

"nnoremap <leader>ff <cmd>Telescope find_files<cr>
"nnoremap <leader>fg <cmd>Telescope live_grep<cr>
"nnoremap <leader>fb <cmd>Telescope buffers<cr>
"nnoremap <leader>fh <cmd>Telescope help_tags<cr>

nnoremap <leader>fk <cmd>FzfLua keymaps<cr>
nnoremap <leader>ff <cmd>FzfLua files<cr>
nnoremap <leader>fg <cmd>FzfLua grep_project<cr>
nnoremap <leader>fb <cmd>FzfLua buffers<cr>
nnoremap <leader>fdc <cmd>FzfLua dap_commands<cr>
nnoremap <leader>fdb <cmd>FzfLua dap_breakpoints<cr>
nnoremap <leader>fdv <cmd>FzfLua dap_variables<cr>

nnoremap <leader>tf <cmd>NvimTreeFindFile<cr>
nnoremap <leader>tt <cmd>NvimTreeToggle<cr>
nnoremap <leader>t= <cmd>NvimTreeResize +10<cr>
nnoremap <leader>t- <cmd>NvimTreeResize -10<cr>

nnoremap . <cmd>FzfLua lsp_code_actions<cr>
nnoremap <leader>gr <cmd>FzfLua lsp_references<cr>
nnoremap <leader>gd <cmd>FzfLua lsp_definitions<cr>
nnoremap <leader>gi <cmd>FzfLua lsp_implementations<cr>

let g:python3_host_prog="/usr/bin/python3"
let g:formatters_go = ['goimports']

nnoremap == <cmd>Autoformat<cr>

lua << EOF
  --vim.g.material_style = "deep ocean"
  --vim.cmd 'colorscheme material'
  vim.cmd 'colorscheme tokyonight-night'
  require('myconfig')
  require('debugger')
EOF