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

  call dein#add('Konfekt/FastFold')
  call dein#add('PProvost/vim-ps1')
  call dein#add('Rip-Rip/clang_complete')
  call dein#add('Shougo/neocomplete.vim')
  call dein#add('Shougo/neomru.vim')           " :Unite file_mru
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/tabpagebuffer.vim')
  call dein#add('Shougo/unite.vim')
  call dein#add('altercation/vim-colors-solarized') " solarized.vim
  call dein#add('cespare/vim-toml')
  call dein#add('cocopon/iceberg.vim')
  call dein#add('digitaltoad/vim-jade')
  call dein#add('easymotion/vim-easymotion') " <Space>f
  call dein#add('fatih/vim-go')
  call dein#add('fuenor/qfixgrep')
  call dein#add('fuenor/qfixhowm')             " QFixHowm - hitori otegaru wiki modoki
  call dein#add('gregsexton/gitv')             " :Gitv, 要fugitive
  call dein#add('h1mesuke/unite-outline')      " :Unite outline
  call dein#add('hallison/vim-markdown')
  call dein#add('haya14busa/vim-asterisk')
  call dein#add('haya14busa/vim-edgemotion')
  call dein#add('haya14busa/vim-migemo')
  call dein#add('honza/vim-snippets')
  call dein#add('jelera/vim-javascript-syntax')
  call dein#add('jiangmiao/simple-javascript-indenter')
  call dein#add('junegunn/vim-easy-align')
  call dein#add('justinmk/vim-dirvish')
  call dein#add('kana/vim-altr')               " <Space>a
  call dein#add('kana/vim-smartinput')
  call dein#add('kana/vim-tabpagecd')
  call dein#add('kana/vim-textobj-datetime')  " ada, ida
  call dein#add('kana/vim-textobj-diff')  " adf, idf
  call dein#add('kana/vim-textobj-entire')   " ae, ie
  call dein#add('kana/vim-textobj-fold')  " az, iz
  call dein#add('kana/vim-textobj-function') " af, if, aF, iF
  call dein#add('kana/vim-textobj-indent')  " ai, ii
  call dein#add('kana/vim-textobj-jabraces') " ajb, ijb
  call dein#add('kana/vim-textobj-lastpat')  " a/, i/
  call dein#add('kana/vim-textobj-line')     " al, il
  call dein#add('kana/vim-textobj-syntax')   " ay, iy
  call dein#add('kana/vim-textobj-underscore') " a_, i_
  call dein#add('kana/vim-textobj-user')
  call dein#add('kmnk/vim-unite-giti')
  call dein#add('lambdalisue/gina.vim')
  call dein#add('leafgarland/typescript-vim')
  call dein#add('majutsushi/tagbar')           " <Space>t ctags汎用
  call dein#add('mattn/emmet-vim')              " <C-z>, old: zencoding-vim
  call dein#add('msanders/cocoa.vim')
  call dein#add('osyo-manga/vim-anzu')
  call dein#add('osyo-manga/vim-over')
  call dein#add('pangloss/vim-javascript')
  call dein#add('posva/vim-vue')
  call dein#add('prabirshrestha/async.vim')
  call dein#add('prabirshrestha/vim-lsp')
  call dein#add('rking/ag.vim')
  call dein#add('sjl/gundo.vim')
  call dein#add('sorah/unite-ghq')
  call dein#add('taichouchou2/vim-endwise.git', {'on_event': 'InsertEnter'})
  call dein#add('thinca/vim-quickrun')         " <Space>qでmakeなど
  call dein#add('thinca/vim-tabrecent')         " <[TABCMD]r 
  call dein#add('thinca/vim-textobj-comment') " ac, ic
  call dein#add('tpope/vim-commentary')         " gc{motion}, gcc でコメントのトグル
  call dein#add('tpope/vim-dispatch')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-surround')          " <オペレータ>s<デリミタ> or ビジュアルモードでS<デリミタ>
  call dein#add('tpope/vim-unimpaired')        " [q, ]qなど
  call dein#add('tyru/open-browser.vim')
  call dein#add('vim-scripts/VimCoder.jar')    " topcoder
  call dein#add('vim-scripts/errormarker.vim') " flymakeっぽいこと 実態確認 ':autocmd QuickFixCmdPost'
  call dein#add('vim-scripts/jQuery')
  call dein#add('vim-scripts/matchit.zip')
  call dein#add('vim-scripts/project.tar.gz')
  call dein#add('vim-scripts/sudo.vim')
  call dein#add('vim-scripts/vim-niji')
  call dein#add('w0ng/vim-hybrid') " :colorscheme hybrid

  " ファイルの構文エラーチェック
  if has('job') && has('channel') && has('timers')
    call dein#add('w0rp/ale')
  else
    call dein#add('scrooloose/syntastic')
  endif

  call dein#add('Shougo/vimproc', {
  \ 'build' :
  \   has('mac') ? 'make -f make_mac.mak' :
  \   has('unix') ? 'make' : ''
  \ })

  if has('mac')
    call dein#add('kana/vim-fakeclip')
  endif

  call dein#add('OmniSharp/omnisharp-vim', {
  \   'on_ft' : [ 'cs', 'csi', 'csx' ],
  \   'build' :
  \     has('mac') ? 'xbuild server/OmniSharp.sln' :
  \     has('unix') ? 'xbuild server/OmniSharp.sln' :
  \     'msbuild server/OmniSharp.sln',
  \ })

  call dein#end()
  call dein#save_state()
endif

" endwise.vim  {{{2

let g:endwise_no_mappings=1

" emmet.vim {{{2
let g:user_emmet_leader_key='<C-z>'

" vim-surround "{{{2

let g:surround_custom_mapping = {}
let g:surround_custom_mapping._ = {
      \ 'p':  "<pre> \r </pre>",
      \ 'w':  "%w(\r)",
      \ }
let g:surround_custom_mapping.help = {
      \ 'p':  "> \r <",
      \ }
let g:surround_custom_mapping.ruby = {
      \ '-':  "<% \r %>",
      \ '=':  "<%= \r %>",
      \ '9':  "(\r)",
      \ '5':  "%(\r)",
      \ '%':  "%(\r)",
      \ 'w':  "%w(\r)",
      \ '#':  "#{\r}",
      \ '3':  "#{\r}",
      \ 'e':  "begin \r end",
      \ 'E':  "<<EOS \r EOS",
      \ 'i':  "if \1if\1 \r end",
      \ 'u':  "unless \1unless\1 \r end",
      \ 'c':  "class \1class\1 \r end",
      \ 'm':  "module \1module\1 \r end",
      \ 'd':  "def \1def\1\2args\r..*\r(&)\2 \r end",
      \ 'p':  "\1method\1 do \2args\r..*\r|&| \2\r end",
      \ 'P':  "\1method\1 {\2args\r..*\r|&|\2 \r }",
      \ }
let g:surround_custom_mapping.javascript = {
      \ 'f':  "function(){ \r }"
      \ }
let g:surround_custom_mapping.lua = {
      \ 'f':  "function(){ \r }"
      \ }
let g:surround_custom_mapping.python = {
      \ 'p':  "print( \r)",
      \ '[':  "[\r]",
      \ }
let g:surround_custom_mapping.vim= {
      \'f':  "function! \r endfunction"
      \ }

" quickrun.vim "{{{2

let g:quickrun_config = {}
let g:quickrun_config['_'] = {"runner": "vimproc", "runner/vimproc/updatetime": 60, "split": "below"}

let g:quickrun_config['make']       = {"command": "make", "exec" : "%c %o",  "outputter": "error:buffer:quickfix"}
let g:quickrun_config['make.check'] = {"command": "make", "cmdopt": "check", "outputter": "error:buffer:quickfix"}
let g:quickrun_config['make.run']   = {"command": "make", "cmdopt": "run",   "outputter": "error:buffer:quickfix"}
let g:quickrun_config['make.test']  = {"command": "make", "cmdopt": "test",  "outputter": "error:buffer:quickfix"}
let g:quickrun_config['tex']        = {"command": "make", "exec" : "%c %o",  "outputter": "error:buffer:quickfix"}

if executable("clang++")
  let g:quickrun_config['cpp/clang++11'] = {'cmdopt': '--std=c++11 --stdlib=libc++', 'type': 'cpp/clang++'}
  let g:quickrun_config['cpp'] = {'type': 'cpp/clang++11'}
endif

" <Space>q でquickrunする
silent! map <Space>q <Plug>(quickrun)

" neocomplete "{{{2

" https://github.com/OmniSharp/omnisharp-vim/wiki/Example-NeoComplete-settings/3c2bcab59a7dc980829719070a8b4eb0991b1b5e
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
let g:acp_enableAtStartup = 0 " Disable AutoComplPop.
let g:neocomplete#enable_at_startup = 1 " Use neocomplete.
let g:neocomplete#enable_smart_case = 1 " Use smartcase.
let g:neocomplete#sources#syntax#min_keyword_length = 3 " Set minimum syntax keyword length.
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
  \ 'default' : '',
  \ 'vimshell' : $HOME.'/.vimshell_hist',
  \ 'scheme' : $HOME.'/.gosh_completions'
  \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'

" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
augroup omnifunc
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
augroup END

" neosnippet "{{{2

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

let g:neosnippet#snippets_directory = "~/vimfiles/snippets,~/vimfiles/bundle/vim-snippets/"

" vim-ref "{{{2
"
let g:ref_open                    = 'split'
let g:ref_refe_cmd                = expand('~/vimfiles/ref/ruby-ref1.9.2/refe-1_9_2')

" Unite.vim "{{{2

let g:unite_enable_start_insert=1

nnoremap [Unite]  <nop>
nmap <Space>u [Unite]
nnoremap [Unite]<Space>  :<C-u>Unite 
nnoremap <silent> [Unite]b  :<C-u>Unite buffer<CR>
nnoremap <silent> [Unite]d  :<C-u>Unite directory_mru -default-action=cd<CR>
nnoremap <silent> [Unite]f  :<C-u>Unite file<CR>
nnoremap <silent> [Unite]m  :<C-u>Unite file_mru<CR>
nnoremap <silent> [Unite]o  :<C-u>Unite outline<CR>
nnoremap <silent> [Unite]q  :<C-u>Unite ghq<CR>
nnoremap <silent> [Unite]r  :<C-u>Unite file_rec<CR>
nnoremap <silent> [Unite]t  :<C-u>Unite buffer_tab<CR>
nnoremap <silent> [Unite]u  :<C-u>UniteWithCurrentDir file_mru<CR>
nnoremap <silent> [Unite]g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> [Unite]cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
nnoremap <silent> [Unite]rg  :<C-u>UniteResume search-buffer<CR>

if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding = 'utf-8'
endif

call unite#custom#substitute('file', '\$\w\+', '\=eval(submatch(0))', 200)
call unite#custom#substitute('file', '[^~.]\zs/', '*/*', 20)
call unite#custom#substitute('file', '/\ze[^*]', '/*', 10)
call unite#custom#substitute('file', '^@@', '\=fnamemodify(expand("#"), ":p:h")."/*"', 2)
call unite#custom#substitute('file', '^@', '\=getcwd()."/*"', 1)
call unite#custom#substitute('file', '^\\', '~/*')
call unite#custom#substitute('file', '^;v', '~/.vim/*')
call unite#custom#substitute('file', '^;r', '\=$VIMRUNTIME."/*"')
if s:is_windows
  call unite#custom#substitute('file', '^;p', 'C:/Program Files/*')
endif

call unite#custom#substitute('file', '\*\*\+', '*', -1)
call unite#custom#substitute('file', '^\~', escape($HOME, '\'), -2)
call unite#custom#substitute('file', '\\\@<! ', '\\ ', -20)
call unite#custom#substitute('file', '\\ \@!', '/', -30)

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif


" Other dein.vim Plugins' Setting "{{{2

"" clang_complete
let g:clang_complete_auto=0
let g:clang_use_library=1

"" vim-altr
nmap <Space>a <Plug>(altr-forward)
call altr#define('%.xaml', '%.xaml.cs')

"" open browser
nnoremap <Leader>o <Plug>(openbrowser-smart-search) 

""" javascript
"" simple-javascript-indenter
" この設定入れるとshiftwidthを1にしてインデントしてくれる
let g:SimpleJsIndenter_BriefMode = 1
" この設定入れるとswitchのインデントがいくらかマシに
let g:SimpleJsIndenter_CaseIndentLevel = -1
"" jQuery
" autocmd BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

if dein#tap('ale')
  let g:ale_lint_on_enter = 0

  nmap <silent> [w <Plug>(ale_previous)
  nmap <silent> ]w <Plug>(ale_next)
  nmap <silent> [W <Plug>(ale_toggle)
  nmap <silent> ]W <Plug>(ale_toggle)
endif

if dein#tap('syntastic')
  let g:syntastic_cs_checkers = ['syntax']

  if executable("clang++")
    let g:syntastic_cpp_compiler = 'clang++'
    let g:syntastic_cpp_compiler_options = '--std=c++11 --stdlib=libc++'
  endif
endif

"" tagbar
nnoremap <Space>T :TagbarToggle<CR>
let g:tagbar_type_javascript = {
  \ 'ctagsbin' : '/usr/local/share/npm/bin/jsctags'
  \ }

"" tComment
if !exists('g:tcomment_types')
  let g:tcomment_types = {}
endif
let g:tcomment_types['reduce'] = '%% %s'


"" QFixHowm
" set runtimepath                                             " dein.vimの場合不要
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

if s:is_windows
  let mygrepprg = 'grep'
endif

" 現メモディレクトリ表示
nnoremap <silent> g,hh :echo howm_dir<CR>
" 環境変更コマンド
nnoremap <silent> g,ha :call HowmChEnv('',            'time', '#')<CR>
nnoremap <silent> g,hp :call HowmChEnv('private-mkd', 'time', '#')<CR>
nnoremap <silent> g,hw :call HowmChEnv('work-mkd',    'day',  '#')<CR>

" vim-edgemotion
map <C-j> <Plug>(edgemotion-j)
map <C-k> <Plug>(edgemotion-k)

" giti {{{3
"
" giti prefix key
nmap <Space>id <SID>(git-diff-cached)
nmap <Space>iD <SID>(git-diff)
nmap <Space>if <SID>(git-fetch-now)
nmap <Space>iF <SID>(git-fetch)
nmap <Space>ip <SID>(git-push-now)
nmap <Space>iP <SID>(git-pull-now)
nmap <Space>il <SID>(git-log-line)
nmap <Space>iL <SID>(git-log)

" unite prefix key
nmap [Unite]gg    <SID>(giti-sources)
nmap [Unite]gst   <SID>(git-status)
nmap [Unite]gb    <SID>(git-branch)
nmap [Unite]gB    <SID>(git-branch_all)
nmap [Unite]gc    <SID>(git-config)
nmap [Unite]gl    <SID>(git-log)
nmap [Unite]gL    <SID>(git-log-this-file)

let g:giti_log_default_line_count = 100
nnoremap <expr><silent> <SID>(git-diff)        ':<C-u>GitiDiff ' . expand('%:p') . '<CR>'
nnoremap <expr><silent> <SID>(git-diff-cached) ':<C-u>GitiDiffCached ' . expand('%:p') .  '<CR>'
nnoremap       <silent> <SID>(git-fetch-now)    :<C-u>GitiFetch<CR>
nnoremap       <silent> <SID>(git-fetch)        :<C-u>GitiFetch
nnoremap <expr><silent> <SID>(git-push-now)    ':<C-u>GitiPushWithSettingUpstream origin ' . giti#branch#current_name() . '<CR>'
nnoremap       <silent> <SID>(git-push)         :<C-u>GitiPush
nnoremap       <silent> <SID>(git-pull-now)     :<C-u>GitiPull<CR>
nnoremap       <silent> <SID>(git-pull)         :<C-u>GitiPull
nnoremap       <silent> <SID>(git-log-line)     :<C-u>GitiLogLine ' . expand('%:p') . '<CR>'
nnoremap       <silent> <SID>(git-log)          :<C-u>GitiLog ' . expand('%:p') . '<CR>'

nnoremap <silent> <SID>(giti-sources)   :<C-u>Unite giti<CR>
nnoremap <silent> <SID>(git-status)     :<C-u>Unite giti/status<CR>
nnoremap <silent> <SID>(git-branch)     :<C-u>Unite giti/branch<CR>
nnoremap <silent> <SID>(git-branch_all) :<C-u>Unite giti/branch_all<CR>
nnoremap <silent> <SID>(git-config)     :<C-u>Unite giti/config<CR>
nnoremap <silent> <SID>(git-log)        :<C-u>Unite giti/log<CR>

nnoremap <silent><expr> <SID>(git-log-this-file) ':<C-u>Unite giti/log:' . expand('%:p') . '<CR>'
" }}}

"" vim-easymotion
let g:EasyMotion_do_mapping = 0
map  <Space>f <Plug>(easymotion-bd-f)
nmap <Space>f <Plug>(easymotion-bd-f)
map  <Space>F <Plug>(easymotion-bd-f)
nmap <Space>F <Plug>(easymotion-overwin-f)

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

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
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

" vim-lsp
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

let g:lsp_async_completion = 1
autocmd FileType typescript setlocal omnifunc=lsp#complete

" OS Type "{{{1

if has('mac')
  set clipboard=unnamed " クリップボード利用設定
  if has('gui_running')
    set macmeta
  endif
endif

" Functions "{{{1
"
let s:FALSE = 0
let s:TRUE = !s:FALSE

function! s:combinations(pool, r)
  let n = len(a:pool)
  if n < a:r || a:r <= 0
    return []
  endif

  let result = []

  let indices = range(a:r)
  call add(result, join(map(copy(indices), 'a:pool[v:val]'), ''))

  while s:TRUE
    let broken_p = s:FALSE
    for i in reverse(range(a:r))
      if indices[i] != i + n - a:r
        let broken_p = s:TRUE
        break
      endif
    endfor
    if !broken_p
      break
    endif

    let indices[i] += 1
    for j in range(i + 1, a:r - 1)
      let indices[j] = indices[j-1] + 1
    endfor
    call add(result, join(map(copy(indices), 'a:pool[v:val]'), ''))
  endwhile

  return result
endfunction

function! s:all_combinations(xs)
  let cs = []

  for r in range(1, len(a:xs))
    call extend(cs, s:combinations(a:xs, r))
  endfor

  return cs
endfunction

function! s:modifier_combinations(modifiers)
  let prefixes = map(range(len(a:modifiers)), 'a:modifiers[v:val] . "-"')
  return s:all_combinations(prefixes)
endfunction

" git-diff-aware version of gf commands.
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

" <M-{x}> => <Esc>x
function! s:emulate_meta_esc_behavior_in_terminal()
  " [key, acceptable-modifiers-except-meta]  "{{{
  let keys = [
  \   ['!', ''],
  \   ['"', ''],
  \   ['#', ''],
  \   ['$', ''],
  \   ['%', ''],
  \   ['&', ''],
  \   ['''', ''],
  \   ['(', ''],
  \   [')', ''],
  \   ['*', ''],
  \   ['+', ''],
  \   [',', ''],
  \   ['-', ''],
  \   ['.', ''],
  \   ['0', ''],
  \   ['1', ''],
  \   ['2', ''],
  \   ['3', ''],
  \   ['4', ''],
  \   ['5', ''],
  \   ['6', ''],
  \   ['7', ''],
  \   ['8', ''],
  \   ['9', ''],
  \   [':', ''],
  \   [';', ''],
  \   ['<BS>', 'CS'],
  \   ['<Bar>', ''],
  \   ['<Bslash>', 'C'],
  \   ['<Del>', 'CS'],
  \   ['<Down>', 'CS'],
  \   ['<End>', 'CS'],
  \   ['<Esc>', 'CS'],
  \   ['<F10>', 'CS'],
  \   ['<F11>', 'CS'],
  \   ['<F12>', 'CS'],
  \   ['<F1>', 'CS'],
  \   ['<F2>', 'CS'],
  \   ['<F3>', 'CS'],
  \   ['<F4>', 'CS'],
  \   ['<F5>', 'CS'],
  \   ['<F6>', 'CS'],
  \   ['<F7>', 'CS'],
  \   ['<F9>', 'CS'],
  \   ['<F9>', 'CS'],
  \   ['<Home>', 'CS'],
  \   ['<LT>', ''],
  \   ['<Left>', 'CS'],
  \   ['<PageDown>', 'CS'],
  \   ['<PageUp>', 'CS'],
  \   ['<Return>', 'CS'],
  \   ['<Right>', 'CS'],
  \   ['<Space>', 'CS'],
  \   ['<Tab>', 'CS'],
  \   ['<Up>', 'CS'],
  \   ['=', ''],
  \   ['>', ''],
  \   ['@', 'C'],
  \   ['A', ''],
  \   ['B', ''],
  \   ['C', ''],
  \   ['D', ''],
  \   ['E', ''],
  \   ['F', ''],
  \   ['G', ''],
  \   ['H', ''],
  \   ['I', ''],
  \   ['J', ''],
  \   ['K', ''],
  \   ['L', ''],
  \   ['M', ''],
  \   ['N', ''],
  \   ['O', ''],
  \   ['P', ''],
  \   ['Q', ''],
  \   ['R', ''],
  \   ['S', ''],
  \   ['T', ''],
  \   ['U', ''],
  \   ['V', ''],
  \   ['W', ''],
  \   ['X', ''],
  \   ['Y', ''],
  \   ['Z', ''],
  \   ['[', 'C'],
  \   [']', 'C'],
  \   ['^', 'C'],
  \   ['_', 'C'],
  \   ['`', ''],
  \   ['a', 'C'],
  \   ['b', 'C'],
  \   ['c', 'C'],
  \   ['d', 'C'],
  \   ['e', 'C'],
  \   ['f', 'C'],
  \   ['g', 'C'],
  \   ['h', 'C'],
  \   ['i', 'C'],
  \   ['j', 'C'],
  \   ['k', 'C'],
  \   ['l', 'C'],
  \   ['m', 'C'],
  \   ['n', 'C'],
  \   ['o', 'C'],
  \   ['p', 'C'],
  \   ['q', 'C'],
  \   ['r', 'C'],
  \   ['s', 'C'],
  \   ['t', 'C'],
  \   ['u', 'C'],
  \   ['v', 'C'],
  \   ['w', 'C'],
  \   ['x', 'C'],
  \   ['y', 'C'],
  \   ['z', 'C'],
  \   ['{', ''],
  \   ['}', ''],
  \   ['~', ''],
  \ ]
  "}}}

  for [key, modifiers] in keys
    let k = substitute(key, '\v^\<(.*)\>$', '\1', '')

    execute 'Allmap' '<M-'.k.'>'  '<Esc>'.key
    for m in s:modifier_combinations(modifiers)
      execute 'Allmap' '<M-'.m.k.'>'  '<Esc><'.m.k.'>'
    endfor
  endfor
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

command! -nargs=+ Allmap
\   execute 'map' <q-args>
\ | execute 'map!' <q-args>

command! -nargs=+ Allnoremap
\   execute 'noremap' <q-args>
\ | execute 'noremap!' <q-args>

" <Esc>の代替
Allnoremap <C-@>  <Esc>
cnoremap <C-@>  <C-c>
Allmap <C-Space>  <C-@>

" <Esc>{x} to <C-w>{x}
if has('gui_running')
  nmap <Esc>  <C-w>
elseif has('unix') || s:is_windows
  " this function is imported from https://gist.github.com/thinca/1518874/
  " Use meta keys in console.
  function! s:use_meta_keys()
    for i in map(
    \   range(char2nr('a'), char2nr('z'))
    \ + range(char2nr('A'), char2nr('Z'))
    \ + range(char2nr('0'), char2nr('9'))
    \ , 'nr2char(v:val)')
      " <ESC>O do not map because used by arrow keys.
      if i !~# '[O]'
        execute 'nmap <ESC>' . i '<C-w>' . i
      endif
    endfor
  endfunction

  call s:use_meta_keys()
endif

" <M-{x}> to <Esc>{x}
call s:emulate_meta_esc_behavior_in_terminal()

" vimrcをオープン, リロード
nnoremap <Space>.  :<C-u>edit $MYVIMRC<CR>
if has('gui_running')
  nnoremap <Space>,  :<C-u>edit $MYGVIMRC<CR>
  nnoremap <Space>v. :<C-u>source $MYVIMRC<CR> :<C-u>source $MYGVIMRC<CR>
else
  nnoremap <Space>v. :<C-u>source $MYVIMRC<CR>
endif

" バッファ操作
nnoremap <Space>b :<C-u>ls<CR>:buf

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

nnoremap <C-h> :<C-u>help<Space>

" Generals "{{{1

filetype plugin indent on "プラグインをオンにする

" ファイル処理関連
set confirm
set hidden

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

set helplang=en,ja

" 拡張子設定
autocmd BufRead,BufNewFile *.red set filetype=reduce
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
let g:tex_flavor = "latex"

autocmd BufNewFile,BufRead *.{aspx,ascx} set filetype=html
autocmd BufNewFile,BufRead *.{aspx,ascx,cs,html,master} setlocal tabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.{aspx,ascx,cs,html,master} setlocal noexpandtab softtabstop=4
autocmd BufNewFile,BufRead *.{aspx,ascx,cs,html,master} setlocal foldmethod=syntax

autocmd BufNewFile,BufRead *.{xaml} set filetype=xml
autocmd BufNewFile,BufRead *.{xaml,ascx,cs,html,master} setlocal tabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.ts set filetype=typescript

augroup vue
  autocmd!
  autocmd FileType vue syntax sync fromstart
augroup END

autocmd FileType *
\   if &l:omnifunc == ''
\ |   setlocal omnifunc=syntaxcomplete#Complete
\ | endif

augroup git
    autocmd!
    autocmd FileType git :setlocal foldlevel=99 tabstop=8
augroup END

"スペルチェックを有効にする(ただし日本語は除外する)
set spelllang+=cjk
" set spell

if !has('gui_running') && &t_Co == 256
  colorscheme iceberg
end

" __END__  "{{{1
" vim: expandtab softtabstop=2 shiftwidth=2
" vim: foldmethod=marker
