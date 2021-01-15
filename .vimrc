" Basics "{{{1

if has('vim_starting')
  set encoding=utf-8
  scriptencoding utf-8

  if !has('gui_running') && exists('&termguicolors') && $COLORTERM ==# 'truecolor'
    let &t_8f = "\e[38;2;%lu;%lu;%lum"
    let &t_8b = "\e[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
endif

augroup MyAutoCmd
  autocmd!
augroup END

" Plugins "{{{1
let s:cache_dir = expand('~/.cache')

if !isdirectory(s:cache_dir)
  call mkdir(s:cache_dir, 'p')
endif

let s:dein_dir = s:cache_dir . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if has('vim_starting')
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml('~/.vim/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.vim/deinlazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" Options "{{{1

filetype plugin indent on "プラグインをオンにする

" ファイル処理関連
set confirm
set hidden

if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" 検索/置換
set ignorecase
set infercase
set smartcase
set wrapscan
set incsearch

" ctags用
set tags=./tags,tags

" 文字コード
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932

set iminsert=0 " 入力モードで自動的に日本語入力を使わない
set imsearch=0 " 挿入モードで自動的に日本語入力を使わない

syntax enable                            "シンタックスハイライト
set number                               "行番号表示
set expandtab                            "タブにスペースを使う
set tabstop=2 shiftwidth=2 softtabstop=2 "インデント幅を2文字に
set helplang=ja,en                       "helpを日本語化, helptags ~/vimfiles/doc/

"ファイル情報の表示
set laststatus=2
set showtabline=2

" 不可視文字の可視化
set list
"set listchars=eol:￢,tab:_.
set listchars=tab:._,eol:$

set hlsearch " 検索結果をハイライト

set mouse=a

set showmatch

set shellslash

set history=10000

set backspace=indent,eol,start

set ambiwidth=double

let g:vim_indent_cont = 0

" undofile
set undofile
set undodir='~/tmp/vim-undofile'

let g:tex_flavor = 'latex'

" 拡張子設定
autocmd MyAutoCmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
autocmd MyAutoCmd BufNewFile,BufRead *.{aspx,ascx} set filetype=html
autocmd MyAutoCmd BufNewFile,BufRead *.{xaml} set filetype=xml
autocmd MyAutoCmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd MyAutoCmd BufNewFile,BufRead *.slim setlocal filetype=slim

autocmd MyAutoCmd BufNewFile,BufRead *.html setlocal tabstop=4 shiftwidth=4
autocmd MyAutoCmd BufNewFile,BufRead *.html setlocal noexpandtab softtabstop=4
autocmd MyAutoCmd BufNewFile,BufRead *.html setlocal foldmethod=syntax

autocmd MyAutoCmd FileType vue syntax sync fromstart

autocmd MyAutoCmd FileType *
\   if &l:omnifunc == ''
\ |   setlocal omnifunc=syntaxcomplete#Complete
\ | endif

" omni completion
autocmd MyAutoCmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd MyAutoCmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd MyAutoCmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd MyAutoCmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd MyAutoCmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

"スペルチェックを有効にする(ただし日本語は除外する)
set spelllang& spelllang+=cjk
" set spell

if !has('gui_running') && &t_Co == 256
  colorscheme iceberg
end

if has('mac')
  set clipboard=unnamed " クリップボード利用設定
  if has('gui_running')
    set macmeta
  endif
endif

" Mappings "{{{1

" vimrcをオープン, リロード
nnoremap <Space>.  :<C-u>edit $MYVIMRC<CR>
if has('gui_running')
  nnoremap <Space>,  :<C-u>edit $MYGVIMRC<CR>
  nnoremap <Space>v. :<C-u>source $MYVIMRC<CR> :<C-u>source $MYGVIMRC<CR>
else
  nnoremap <Space>v. :<C-u>source $MYVIMRC<CR>
endif

" fzf.vim
nnoremap <Space>b :<C-u>Buffers<CR>
nnoremap <Space>h :<C-u>History<CR>
nnoremap <Space>r :<C-u>Rg 
nnoremap <Space>f :<C-u>GFiles<CR>

" UTF-8 として読み込む
nnoremap <Space>e  :<C-u>e ++enc=utf-8<CR>
nnoremap <Space>E  :<C-u>e! ++enc=utf-8<CR>

" gitコマンドのショートカット
nnoremap <Space>g :<C-u>Git -p 
nnoremap <Space>G :<C-u>Git 
nnoremap <Space>l :<C-u>Git -p ls-files<CR>

nnoremap <Space>n :<C-u>Gina 
nnoremap <Space>N :<C-u>Gina! 

" タブページ操作
nnoremap [TABCMD]  <nop>
nmap <Space>t [TABCMD]
nnoremap <silent> [TABCMD]f :<C-u>tabfirst<CR>
nnoremap <silent> [TABCMD]l :<C-u>tablast<CR>
nnoremap <silent> [TABCMD]e :<C-u>tabedit<CR>
nnoremap <silent> [TABCMD]c :<C-u>tabclose<CR>
nnoremap <silent> [TABCMD]o :<C-u>tabonly<CR>
nnoremap <silent> [TABCMD]s :<C-u>tabs<CR>
nnoremap <silent> [TABCMD]r :<C-u>TabRecent<CR>
nnoremap          [TABCMD]m :<C-u>tabm

" vim-lsp
nnoremap <Space>p :<C-u>LspHover<CR>

" git-diff-aware version of gf commands.
nnoremap <expr> gf  <SID>do_git_diff_aware_gf('gf')
nnoremap <expr> gF  <SID>do_git_diff_aware_gf('gF')
nnoremap <expr> <C-w>f  <SID>do_git_diff_aware_gf('<C-w>f')
nnoremap <expr> <C-w><C-f>  <SID>do_git_diff_aware_gf('<C-w><C-f>')
nnoremap <expr> <C-w>F  <SID>do_git_diff_aware_gf('<C-w>F')
nnoremap <expr> <C-w>gf  <SID>do_git_diff_aware_gf('<C-w>gf')
nnoremap <expr> <C-w>gF  <SID>do_git_diff_aware_gf('<C-w>gF')

" 81桁目以降の色をトグルする
noremap <Plug>(ToggleColorColumn)
  \ :<C-u>let &colorcolumn = len(&colorcolumn) > 0 ? '' :
  \   join(range(81, 9999), ',')<CR>

" ノーマルモードの 'cc' に割り当てる
nmap <Space>c <Plug>(ToggleColorColumn)
set pastetoggle=<F5> " <F5>でペーストモードのトグル

nnoremap <F5>  :!ctags -R<CR>

" &コマンドの修正
nnoremap &  :&&<CR>
xnoremap &  :&&<CR>

" コマンドラインモード用
set wildmenu
set wildmode=longest:full,full

cnoremap <C-a> <Home>
cnoremap <C-b> <Left>
" cnoremap <C-d> <Del>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" 検索時のエスケープ
cnoremap <expr> / (getcmdtype() == '/') ? '\/' : '/'
cnoremap <expr> ? (getcmdtype() == '?') ? '\?' : '?'

" 検索時単語境界の付与
cnoremap <C-o> <C-\>e(getcmdtype() == '/' <Bar><Bar> getcmdtype() == '?') ? '\<' . getcmdline() . '\>' : getcmdline()<CR>

noremap ;  :
noremap :  ;

noremap Y y$

nnoremap <C-h> :<C-u>help<Space>

noremap <C-@> <Esc>
noremap! <C-@> <Esc>

map <C-Space> <C-@>
map! <C-Space> <C-@>

" カーソル下のunixtimeをタイムスタンプに変換
nmap <Space>d m"ciw<C-r>=strftime("%Y/%m/%d %T", @m)<CR><Esc>

" Customize "{{{1

let s:FALSE = 0
let s:TRUE = !s:FALSE

function! s:do_git_diff_aware_gf(command)
  let target_path = expand('<cfile>')
  if target_path =~# '^[ab]/'  " with a peculiar prefix of git-diff(1)?
    if filereadable(target_path) || isdirectory(target_path)
      return a:command
    else
      " BUGS: Side effect - Cursor position is changed.
      let [_, c] = searchpos('\f\+', 'cenW')
      return c . '|' . 'v' . (len(target_path) - 2 - 1) . 'h' . a:command
    endif
  else
    return a:command
  endif
endfunction

autocmd MyAutoCmd BufWritePre * call <SID>auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
function! s:auto_mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force || input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(a:dir, 'p')
  endif
endfunction

if filereadable(expand('~/.vimrc.local'))
  source $HOME/.vimrc.local
endif

" __END__  "{{{1
" vim: expandtab softtabstop=2 shiftwidth=2
" vim: foldmethod=marker
