" http://nvie.com/posts/how-i-boosted-my-vim/

set nocompatible

filetype plugin indent on "indenting intelligence is enabled based on the syntax rules for the file type

" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

" change the mapleader from \ to ,
let mapleader=","

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

set hidden      "hide buffers instead of closing them

set nowrap        " don't wrap lines
set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set number      " show line numbers
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set expandtab
autocmd FileType perl set smartindent

set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set nobackup

" colorscheme mustang

set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
autocmd filetype html,xml set listchars-=tab:>.

set pastetoggle=<F2>

set incsearch   " show search matches as you type

" map ,/ to no highlite search
nmap <silent> ,/ ;nohlsearch<CR>

cmap w!! w !sudo tee % >/dev/null #sudo write file 
