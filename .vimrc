" Basics "{{{1

if has('vim_starting')
  set encoding=utf-8

  " 利用可能な場合は true color を有効化する
  if !has('gui_running')
        \ && exists('&termguicolors')
        \ && $COLORTERM ==# 'truecolor'
    if !has('nvim')
      let &t_8f = "\e[38;2;%lu;%lu;%lum"
      let &t_8b = "\e[48;2;%lu;%lu;%lum"
    endif
    set termguicolors       " use truecolor in term
  endif
endif

let s:is_windows = has("win32unix") || has ("win64unix") || has("win32") || has("win64")

" dein.vim "{{{1
let g:vimproc#download_windows_dll = 1
let $BUNDLE_PATH =
  \ s:is_windows
  \ ? '~/vimfiles/dein/'
  \ : '~/.vim/dein/'

if has('vim_starting')
  set runtimepath+=$BUNDLE_PATH/repos/github.com/Shougo/dein.vim
endif

" Bundles "{{{2

if dein#load_state(expand($BUNDLE_PATH))
  call dein#begin(expand($BUNDLE_PATH))

  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#add('OmniSharp/omnisharp-vim')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('cocopon/iceberg.vim')
  call dein#add('cohama/lexima.vim')
  call dein#add('easymotion/vim-easymotion') " <Space>f
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('fatih/vim-go')
  call dein#add('fuenor/qfixgrep')
  call dein#add('fuenor/qfixhowm')             " QFixHowm - hitori otegaru wiki modoki
  call dein#add('hallison/vim-markdown')
  call dein#add('haya14busa/vim-asterisk')
  call dein#add('haya14busa/vim-migemo')
  call dein#add('honza/vim-snippets')
  call dein#add('jelera/vim-javascript-syntax')
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('junegunn/vim-easy-align')
  call dein#add('justinmk/vim-dirvish')
  call dein#add('kana/vim-altr')               " <Space>a
  call dein#add('kana/vim-tabpagecd')
  call dein#add('kana/vim-textobj-entire')   " ae, ie
  call dein#add('kana/vim-textobj-indent')  " ai, ii
  call dein#add('kana/vim-textobj-line')     " al, il
  call dein#add('kana/vim-textobj-user')
  call dein#add('lambdalisue/gina.vim')
  call dein#add('mattn/emmet-vim')              " <C-z>, old: zencoding-vim
  call dein#add('osyo-manga/vim-anzu')
  call dein#add('pangloss/vim-javascript')
  call dein#add('posva/vim-vue')
  call dein#add('prabirshrestha/async.vim')
  call dein#add('prabirshrestha/asyncomplete-lsp.vim')
  call dein#add('prabirshrestha/asyncomplete-ultisnips.vim')
  call dein#add('prabirshrestha/asyncomplete.vim')
  call dein#add('prabirshrestha/vim-lsp')
  call dein#add('rhysd/clever-f.vim')
  call dein#add('scrooloose/nerdtree')
  call dein#add('taichouchou2/vim-endwise.git', {'on_event': 'InsertEnter'})
  call dein#add('thinca/vim-qfreplace')
  call dein#add('thinca/vim-quickrun')         " <Space>qでmakeなど
  call dein#add('thinca/vim-tabrecent')         " <[TABCMD]r
  call dein#add('thinca/vim-textobj-between')
  call dein#add('thinca/vim-textobj-comment') " ac, ic
  call dein#add('tpope/vim-commentary')         " gc{motion}, gcc でコメントのトグル
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-rails')
  call dein#add('tpope/vim-surround')          " <オペレータ>s<デリミタ> or ビジュアルモードでS<デリミタ>
  call dein#add('tpope/vim-unimpaired')        " [q, ]qなど
  call dein#add('tweekmonster/fzf-filemru')
  call dein#add('tyru/capture.vim')
  call dein#add('vim-jp/vimdoc-ja')
  call dein#add('vim-jp/vital.vim')
  call dein#add('vim-scripts/matchit.zip')
  call dein#add('vim-scripts/sudo.vim')
  call dein#add('vim-scripts/vim-niji')


  if executable('composer')
    call dein#add('phpactor/phpactor', {
    \ 'on_ft': ['php'],
    \ 'build': 'composer install'
    \ })
  endif

  " swift
  call dein#add('bumaociyuan/vim-swift')

  " ファイルの構文エラーチェック
  if has('job') && has('channel') && has('timers')
    call dein#add('w0rp/ale')
  endif

  call dein#add('Shougo/vimproc', {
  \ 'build' :
  \   has('mac') ? 'make -f make_mac.mak' :
  \   has('unix') ? 'make' : ''
  \ })

  if has('mac')
    call dein#add('kana/vim-fakeclip')
  endif

  call dein#end()
  call dein#save_state()
endif

" Programming Language Settings {{{2

"" vim-lsp

if executable('typescript-language-server')
    autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'typescript-language-server',
      \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
      \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'tsconfig.json'))},
      \ 'whitelist': ['typescript', 'javascript', 'javascript.jsx'],
      \ })
endif
if executable('vls')
    autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'vue-language-server',
      \ 'cmd': {server_info->['vls']},
      \ 'whitelist': ['vue'],
      \ })
endif

if executable('solargraph')
    " gem install solargraph
    au User lsp_setup call lsp#register_server({
        \ 'name': 'solargraph',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
        \ 'initialization_options': {"diagnostics": "true"},
        \ 'whitelist': ['ruby'],
        \ })
endif

if dein#tap('lexima.vim')
  call lexima#add_rule({'char': '<%', 'input_after': '%>', 'filetype': 'eruby'})
endif

let g:lsp_log_verbose = 1
let g:lsp_log_file = expand('~/vim-lsp.log')

" for asyncomplete.vim log
let g:asyncomplete_log_file = expand('~/asyncomplete.log')

let g:lsp_async_completion = 1
autocmd FileType typescript setlocal omnifunc=lsp#complete

" ale.vim
if dein#tap('ale')
  let g:ale_lint_on_enter = 0

  nmap <silent> [w <Plug>(ale_previous)
  nmap <silent> ]w <Plug>(ale_next)
  nmap <silent> [W <Plug>(ale_toggle)
  nmap <silent> ]W <Plug>(ale_toggle)

  let g:ale_fixers = {
  \   'javascript': ['prettier', 'eslint'],
  \   'ruby': ['rubocop'],
  \   'vue': ['prettier', 'eslint'],
  \}
  let g:ale_fix_on_save = 1
endif

" quickrun.vim

let g:quickrun_config = {}
let g:quickrun_config['_'] = {"runner": "vimproc", "runner/vimproc/updatetime": 60, "split": "below"}
let g:quickrun_config['make']       = {"command": "make", "exec" : "%c %o",  "outputter": "error:buffer:quickfix"}
let g:quickrun_config['make.check'] = {"command": "make", "cmdopt": "check", "outputter": "error:buffer:quickfix"}
let g:quickrun_config['make.run']   = {"command": "make", "cmdopt": "run",   "outputter": "error:buffer:quickfix"}
let g:quickrun_config['make.test']  = {"command": "make", "cmdopt": "test",  "outputter": "error:buffer:quickfix"}
let g:quickrun_config['tex']        = {"command": "make", "exec" : "%c %o",  "outputter": "error:buffer:quickfix"}
let g:quickrun_config['php']        = {
\ 'hook/cd/directory'              : '/Users/sasaki/go/src/vcs00.timedia.co.jp/gitbucket/git/sasaki/kanagawa-moodle/tmp',
\ 'command'                        : 'sh',
\ 'exec'                           : '%c quickrun.sh',
\ 'outputter/quickfix/errorformat' : '%f:%l',
\}


" Enable omni completion.
augroup omnifunc
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType php setlocal omnifunc=phpactor#Complete
augroup END

" Plugins Settings {{{2
"" endwise.vim

let g:endwise_no_mappings=1

"" emmet.vim

let g:user_emmet_leader_key='<C-z>'

" textobj
let g:textobj_between_no_default_key_mappings = 1

omap iB <Plug>(textobj-between-i)
omap aB <Plug>(textobj-between-a)
vmap iB <Plug>(textobj-between-i)
vmap aB <Plug>(textobj-between-a)

" quickrun.vim

" <Space>q でquickrunする
silent! map <Space>q <Plug>(quickrun)

"" vim-ref

let g:ref_open                    = 'split'
let g:ref_refe_cmd                = expand('~/vimfiles/ref/ruby-ref1.9.2/refe-1_9_2')

"" vim-altr

if dein#tap('vim-altr')
  nmap <Space>a <Plug>(altr-forward)
  call altr#define('%.xaml', '%.xaml.cs')
endif

"" QFixHowm

let QFixHowm_Key            = 'g'                             " キーマップリーダー ex.'g,c'
let QFixMRU_Filename        = '~/.qfixmru'                    " MRUリスト
let howm_fileencoding       = 'utf-8'
let howm_fileformat         = 'unix'
let howm_filename           = '%Y/%m/%Y-%m-%d-%H%M%S.mkd'
let QFixHowm_FileType       = 'markdown'
let QFixHowm_Title          = '#'                             " タイトル記号
let QFixHowm_FoldingPattern = '^[#[]'                         " 折りたたみのパターン

let QFixHowm_ChDir = '~/Dropbox/Files/howm'
let QFixHowm_RootDir = '~/Dropbox/Files/howm'

nnoremap <silent> g,hh :echo howm_dir<CR>
nnoremap <silent> g,ha :call HowmChEnv('',            'time', '#')<CR>
nnoremap <silent> g,hp :call HowmChEnv('private-mkd', 'time', '#')<CR>
nnoremap <silent> g,hw :call HowmChEnv('work-mkd',    'day',  '#')<CR>

"" vim-easymotion

let g:EasyMotion_do_mapping = 0

nmap s <Plug>(easymotion-overwin-f2)

nmap <Space>s <Plug>(easymotion-bd-f2)
vmap <Space>s <Plug>(easymotion-bd-f2)
nmap <Space>S <Plug>(easymotion-overwin-f2)
vmap <Space>S <Plug>(easymotion-bd-f2)

map <Space>L <Plug>(easymotion-bd-jk)
nmap <Space>L <Plug>(easymotion-overwin-line)

map  <Space>w <Plug>(easymotion-bd-w)
nmap <Space>w <Plug>(easymotion-overwin-w)

let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_migemo = 1

"" vim-easy-align'

vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"" vim-asterisk vim-anzu

nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)

vmap *   <Plug>(asterisk-*)<Plug>(anzu-update-search-status-with-echo)
vmap #   <Plug>(asterisk-#)<Plug>(anzu-update-search-status-with-echo)
vmap g*  <Plug>(asterisk-g*)<Plug>(anzu-update-search-status-with-echo)
vmap g#  <Plug>(asterisk-g#)<Plug>(anzu-update-search-status-with-echo)

nmap *   <Plug>(anzu-star-with-echo)
nmap #   <Plug>(anzu-sharp-with-echo)
nmap g*  <Plug>(anzu-star-with-echo)
nmap g#  <Plug>(anzu-sharp-with-echo)

map z*  <Plug>(asterisk-z*)<Plug>(anzu-update-search-status-with-echo)
map gz* <Plug>(asterisk-gz*)<Plug>(anzu-update-search-status-with-echo)
map z#  <Plug>(asterisk-z#)<Plug>(anzu-update-search-status-with-echo)
map gz# <Plug>(asterisk-gz#)<Plug>(anzu-update-search-status-with-echo)

"" fzf

if dein#tap('fzf.vim')
  command! -nargs=* -complete=dir Fq call fzf#run(fzf#wrap(
    \ {'source': 'ghq list --full-path',
    \  'sink': 'cd' }))
endif
nnoremap <silent> <Space>F :<C-u>Fq<CR>

"" clever-f.vim

let g:clever_f_use_migemo = 1

"" vim-surround

let g:surround_{char2nr("-")} = "<% \r %>"
let g:surround_{char2nr("=")} = "<%= \r %>"
let g:surround_{char2nr("#")} = "<%# \r %>"

" OS Type "{{{1

if has('mac')
  set clipboard=unnamed " クリップボード利用設定
  if has('gui_running')
    set macmeta
  endif
endif

" Functions "{{{1

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

if s:is_windows
  function! GitBash()
      let l:oldlang = $LANG
      let $LANG = systemlist('"C:/Program Files/Git/usr/bin/locale.exe" -iU')[0]

      let l:oldgvim = $GVIM
      let l:oldvimserver = $VIM_SERVERNAME
      let $GVIM = $VIMRUNTIME
      let $VIM_SERVERNAME = v:servername

      let l:oldvim = $VIM
      let l:oldvimruntime = $VIMRUNTIME
      let l:oldmyvimrc = $MYVIMRC
      let l:oldmygvimrc = $MYGVIMRC
      let $VIM = ''
      let $VIMRUNTIME = ''
      let $MYVIMRC = ''
      let $MYGVIMRC = ''

      if has('clientserver')
          let $VIM_SERVERNAME = v:servername
      endif

      terminal ++close ++curwin C:/Program Files/Git/bin/bash.exe -l

      let $LANG = l:oldlang
      let $GVIM = l:oldgvim
      let $VIM_SERVERNAME = l:oldvimserver
      let $VIM = l:oldvim
      let $VIMRUNTIME = l:oldvimruntime
      let $MYVIMRC = l:oldmyvimrc
      let $MYGVIMRC = l:oldmygvimrc
  endfunction
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
if dein#tap('fzf.vim')
  nnoremap <Space>b :<C-u>Buffers<CR>
  nnoremap <Space>h :<C-u>History<CR>
  nnoremap <Space>r :<C-u>Rg 
  nnoremap <Space>f :<C-u>GFiles<CR>
endif

" UTF-8 として読み込む
nnoremap <Space>e  :<C-u>e ++enc=utf-8<CR>
nnoremap <Space>E  :<C-u>e! ++enc=utf-8<CR>

" gitコマンドのショートカット
nnoremap <Space>g :<C-u>Git! 
nnoremap <Space>G :<C-u>Git 

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

" Generals "{{{1

filetype plugin indent on "プラグインをオンにする

" ファイル処理関連
set confirm
set hidden

if executable("rg")
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

syntax on                                "シンタックスハイライト
set nu                                   "行番号表示
set expandtab                            "タブにスペースを使う
set tabstop=2 shiftwidth=2 softtabstop=2 "インデント幅を2文字に
set helplang=ja,en                       "helpを日本語化, helptags ~/vimfiles/doc/

"ファイル情報の表示
set laststatus=2
set statusline=%F%m%r%h%w\ [TYPE=%Y]\ [FORMAT=%{&ff}]\ [ENC=%{&fileencoding}]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

set showtabline=2

if dein#tap('vital.vim')
  " from :help setting-tabline
  function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
      " 強調表示グループの選択
      if i + 1 == tabpagenr()
        let s .= '%#TabLineSel#'
      else
        let s .= '%#TabLine#'
      endif

      " タブページ番号の設定 (マウスクリック用)
      let s .= '%' . (i + 1) . 'T'

      " ラベルは MyTabLabel() で作成する
      let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
    endfor

    " 最後のタブページの後は TabLineFill で埋め、タブページ番号をリセッ
    " トする
    let s .= '%#TabLineFill#%T'

    " カレントタブページを閉じるボタンのラベルを右添えで作成
    if tabpagenr('$') > 1
      let s .= '%=%#TabLine#%999Xclose'
    endif

    return s
  endfunction

  function! s:displayLabelName(path)
    let l:f = vital#vital#import('System.Filepath')
    let l:current = l:f.basename(a:path)
    let l:parent = l:f.basename(f.dirname(a:path))
    return l:f.join(l:parent, l:current)
  endfunction

  function! MyTabLabel(n)
    let l:f = vital#vital#import('System.Filepath')
    let l:buflist = tabpagebuflist(a:n)
    let l:winnr = tabpagewinnr(a:n)
    let l:name = l:f.abspath(bufname(l:buflist[l:winnr - 1]))

    let l:n = l:name
    while l:f.dirname(l:n) != l:n
      if isdirectory(l:f.join(l:n, '.git'))
        return s:displayLabelName(l:n)
      endif
      let l:n = l:f.dirname(l:n)
    endwhile
    return s:displayLabelName(l:name)
  endfunction

  set tabline=%!MyTabLine()
endif

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

" undofile
set undofile
set undodir='~/tmp/vim-undofile'

let g:tex_flavor = "latex"

" 拡張子設定
augroup filetype
  autocmd!

  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
  autocmd BufNewFile,BufRead *.{aspx,ascx} set filetype=html
  autocmd BufNewFile,BufRead *.{xaml} set filetype=xml
  autocmd BufNewFile,BufRead *.ts set filetype=typescript
augroup END

augroup php
  autocmd!
  autocmd BufNewFile,BufRead *.php setlocal tabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.php setlocal expandtab softtabstop=4
augroup END

augroup html
  autocmd!
  autocmd BufNewFile,BufRead *.html setlocal tabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.html setlocal noexpandtab softtabstop=4
  autocmd BufNewFile,BufRead *.html setlocal foldmethod=syntax
augroup END

augroup vim
  autocmd!
  autocmd BufWritePost .vimrc source $MYVIMRC
  autocmd BufWritePost .gvimrc source $MYGVIMRC
augroup END

augroup vue
  autocmd!
  autocmd FileType vue syntax sync fromstart
augroup END

autocmd FileType *
\   if &l:omnifunc == ''
\ |   setlocal omnifunc=syntaxcomplete#Complete
\ | endif

"スペルチェックを有効にする(ただし日本語は除外する)
set spelllang+=cjk
" set spell

if !has('gui_running') && &t_Co == 256
  colorscheme iceberg
end

" __END__  "{{{1
" vim: expandtab softtabstop=2 shiftwidth=2
" vim: foldmethod=marker
