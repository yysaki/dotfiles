" todo kaoriya-vimのみ.vim => vimfilesと判断する変数？を導入する
"if has('kaoriya') && (has('win32')||has('win64')||has('win95')||has('win16'))
"  let VIMFILES='~/vimfiles'
"else
"  let VIMFILES='~/.vim'
"endif

filetype off

""" Plugins 
" Neobundle
if has('vim_starting')
  if has('kaoriya') && (has('win32')||has('win64')||has('win95')||has('win16'))
    set runtimepath+=~/vimfiles/bundle/neobundle.vim/
    call neobundle#rc(expand('~/vimfiles/bundle/'))
  else
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand('~/.vim/bundle/'))
  endif
endif

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'hallison/vim-markdown'
NeoBundle 'msanders/cocoa.vim'
if has('python')
  NeoBundle 'kakkyz81/evervim'
endif

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'vim-scripts/errormarker.vim'

"vim-perl
NeoBundle 'petdance/vim-perl'
NeoBundle 'hotchpotch/perldoc-vim'

"NeoBundle 'Shougo/vimproc'
"NeoBundle 'Shougo/vimshell'

""""""""""

"" neocomplcache
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

 " Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Select with <TAB>
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

let g:neocomplcache_ctags_arguments_list = {
  \ 'perl' : '-R -h ".pm"'
  \ }

"" neosnippet
let g:neosnippet#snippets_directory = "~/vimfiles/snippets"
" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default'    : '',
    \ 'perl'       : $HOME . '/vimfiles/dict/perl.dict',
    \ 'cpp'        : $HOME . '/vimfiles/dict/cpp.dict'
    \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"" Evervim
let g:evervim_devtoken='S=s14:U=19a7f1:E=1437499124e:C=13c1ce7e64f:P=1cd:A=en-devtoken:H=9c2cea93a3de758b41d2a699bc55920d'

nnoremap <Leader>l :EvervimNotebookList<CR>
nnoremap <Leader>s :EvervimSearchByQuery<Space>
nnoremap <Leader>c :EvervimCreateNote<CR>
nnoremap <Leader>b :EvervimOpenBrowser<CR>

"" open browser
nnoremap <Leader>o <Plug>(openbrowser-smart-search) 


""""""""""""""""""""

""" Generals
filetype plugin indent on "プラグインをオンにする

if has('win32') || has('win64') || has('win95') || has('win16')
  "TODO sjis-> GUI文字化け無し, UTF-8表示不可
  "     UTF-8->GUI文字化け, UTF-8表示可能
  "  source ~/vimfiles/encode.vim
  set encoding=sjis
else
  set encoding=utf8
endif
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8

syntax on "シンタックスハイライト
set nu "行番号表示
set expandtab "タブにスペースを使う
set tabstop=2 shiftwidth=2 softtabstop=2 "インデント幅を2文字に

"helpを日本語化
helptags ~/vimfiles/doc/
set helplang=ja,en                 

"ファイル情報の表示
set laststatus=2 
set statusline=%F%m%r%h%w\=[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[LOW=%l/%L]

if has('win32') || has('win64') || has('win95') || has('win16')
  "/User/yysaki/に移動(win)
  cd $HOME
endif

if has('gui_macvim')
  " クリップボード利用設定
  set clipboard=unnamed
  NeoBundle 'kana/vim-fakeclip'
endif

source ~/.gvimrc  " .gvimrcを適用 
"TODO 文字数カウント
"vnoremap <C-C> :s/./&/gn<Enter>

" バッファ操作
" http://kaworu.jpn.org/kaworu/2007-07-26-1.php
nnoremap bb :ls<CR>:buf

