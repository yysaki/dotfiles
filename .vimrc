" Basics "{{{1
set nocompatible

let OSTYPE = system('uname')

" Encoding "{{{2

if has('kaoriya') && !has('unix')
  set encoding=utf-8
  scriptencoding cp932
elseif !has('unix')
  set encoding=cp932
  set termencoding=cp932
else
  set encoding=utf-8
endif

" NeoBundle "{{{1
let $BUNDLE_PATH =
  \ (has("win32unix") || has ("win64unix") || has("win32") || has ("win64"))
  \ ? '~/vimfiles/bundle/'
  \ : '~/.vim/bundle/'

if has('vim_starting')
  set runtimepath+=$BUNDLE_PATH/neobundle.vim/
endif

call neobundle#begin(expand($BUNDLE_PATH))

NeoBundleFetch 'Shougo/neobundle.vim'

" Bundles "{{{2
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/tabpagebuffer.vim'
NeoBundle 'Shougo/neomru.vim'           " :Unite file_mru
NeoBundle 'h1mesuke/unite-outline'      " :Unite outline
NeoBundle 'fuenor/qfixhowm'             " QFixHowm - hitori otegaru wiki modoki
NeoBundle 'fuenor/qfixgrep'
NeoBundle 'gregsexton/gitv'             " :Gitv, 要fugitive
NeoBundle 'honza/vim-snippets'
NeoBundle 'kana/vim-altr'               " <Space>a
NeoBundle 'kana/vim-tabpagecd'
NeoBundle 'majutsushi/tagbar'           " <Space>t ctags汎用
NeoBundle 'scrooloose/syntastic'        " ファイルの構文エラーチェック
NeoBundle 'sudo.vim'
NeoBundle 'thinca/vim-quickrun'         " <Space>qでmakeなど
NeoBundle 'thinca/vim-tabrecent'         " <[TABCMD]r 
NeoBundle 'tpope/vim-commentary'         " gc{motion}, gcc でコメントのトグル
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'kmnk/vim-unite-giti'
NeoBundle 'tpope/vim-surround'          " <オペレータ>s<デリミタ> or ビジュアルモードでS<デリミタ>
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'vim-scripts/VimCoder.jar'    " topcoder
NeoBundle 'vim-scripts/errormarker.vim' " flymakeっぽいこと 実態確認 ':autocmd QuickFixCmdPost'
NeoBundle 'vim-scripts/matchit.zip'
NeoBundle 'altercation/vim-colors-solarized' " solarized.vim
NeoBundle 'w0ng/vim-hybrid' " :colorscheme hybrid
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-unimpaired'        " [q, ]qなど
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-datetime'  " ada, ida
NeoBundle 'kana/vim-textobj-diff'  " adf, idf
NeoBundle 'kana/vim-textobj-entire'   " ae, ie
NeoBundle 'kana/vim-textobj-fold'  " az, iz
NeoBundle 'kana/vim-textobj-function' " af, if, aF, iF
NeoBundle 'kana/vim-textobj-indent'  " ai, ii
NeoBundle 'kana/vim-textobj-jabraces' " ajb, ijb
NeoBundle 'kana/vim-textobj-lastpat'  " a/, i/
NeoBundle 'kana/vim-textobj-line'     " al, il
NeoBundle 'kana/vim-textobj-syntax'   " ay, iy
NeoBundle 'kana/vim-textobj-underscore' " a_, i_
NeoBundle 'thinca/vim-textobj-comment' " ac, ic
NeoBundle 'Lokaltog/vim-easymotion' " <Space>f
NeoBundle 'kana/vim-smartinput'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'rking/ag.vim'
NeoBundle 'haya14busa/vim-asterisk'
NeoBundle 'sjl/gundo.vim'
NeoBundle 'digitaltoad/vim-jade'

"" objective-c/iOS
NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'msanders/cocoa.vim'

"" javascript/HTML
" NeoBundle 'marijnh/tern_for_vim' " そのうち使うかも
NeoBundle 'jQuery'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'jiangmiao/simple-javascript-indenter'
NeoBundle 'mattn/emmet-vim'              " <C-z>, old: zencoding-vim

" other specific situation
NeoBundle 'project.tar.gz'
NeoBundle 'hallison/vim-markdown'

if !(has("win32unix") || has ("win64unix") || has("win32") || has ("win64"))
  NeoBundle 'Shougo/vimproc', {
        \ 'build' : {
        \     'mac' : 'make -f make_mac.mak',
        \     'unix' : 'make -f make_unix.mak',
        \    },
        \ }
endif

NeoBundleLazy 'taichouchou2/vim-endwise.git', {
      \ 'autoload' : {
      \   'insert' : 1,
      \ } }

if has('kaoriya') && !has('unix')
  NeoBundleLazy 'nosami/Omnisharp', {
  \   'autoload': {'filetypes': ['cs']},
  \   'build': {
  \     'windows': 'MSBuild.exe server/OmniSharp.sln /p:Platform="Any CPU"',
  \     'mac': 'xbuild server/OmniSharp.sln',
  \     'unix': 'xbuild server/OmniSharp.sln',
  \   }
  \ }
endif

if OSTYPE == "Darwin\n" " Mac
  NeoBundle 'kana/vim-fakeclip'
endif

call neobundle#end()

if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Install Plugins'
  NeoBundleInstall
endif
"
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

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#lock_iminsert = 1
let g:neocomplete#smart_case = 1

inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

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

" Omnisharp "{{{2

if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.cs = '[^.]\.\%(\u\{2,}\)\?'

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
nnoremap <silent> [Unite]f  :<C-u>Unite file<CR>
nnoremap <silent> [Unite]m  :<C-u>Unite file_mru<CR>
nnoremap <silent> [Unite]o  :<C-u>Unite outline<CR>
nnoremap <silent> [Unite]r  :<C-u>Unite file_rec<CR>
nnoremap <silent> [Unite]t  :<C-u>Unite buffer_tab<CR>
nnoremap <silent> [Unite]u  :<C-u>UniteWithCurrentDir file_mru<CR>

call unite#custom#substitute('file', '\$\w\+', '\=eval(submatch(0))', 200)
call unite#custom#substitute('file', '[^~.]\zs/', '*/*', 20)
call unite#custom#substitute('file', '/\ze[^*]', '/*', 10)
call unite#custom#substitute('file', '^@@', '\=fnamemodify(expand("#"), ":p:h")."/*"', 2)
call unite#custom#substitute('file', '^@', '\=getcwd()."/*"', 1)
call unite#custom#substitute('file', '^\\', '~/*')
call unite#custom#substitute('file', '^;v', '~/.vim/*')
call unite#custom#substitute('file', '^;r', '\=$VIMRUNTIME."/*"')
if has('win32') || has('win64')
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


" Other Neobundle Plugins' Setting "{{{2

"" clang_complete
let g:clang_complete_auto=0
let g:clang_use_library=1

"" vim-altr
nmap <Space>a <Plug>(altr-forward)

"" open browser
nnoremap <Leader>o <Plug>(openbrowser-smart-search) 

""" javascript
"" simple-javascript-indenter
" この設定入れるとshiftwidthを1にしてインデントしてくれる
let g:SimpleJsIndenter_BriefMode = 1
" この設定入れるとswitchのインデントがいくらかマシに
let g:SimpleJsIndenter_CaseIndentLevel = -1
"" jQuery
" au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

"" syntastic
" このようにするとjshintを必ず使ってチェックしてくれるようになる
let g:syntastic_javascript_checker = "jshint"
"" http://www.daisaru11.jp/blog/2011/09/vimsyntastic%E3%81%A7%E6%96%87%E6%B3%95%E3%83%81%E3%82%A7%E3%83%83%E3%82%AF%E3%82%92%E8%87%AA%E5%8B%95%E3%81%A7%E8%A1%8C%E3%81%86/
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_mode_map = { 'mode': 'active',
                             \ 'active_filetypes': [],
                             \ 'passive_filetypes': ['tex'] } 

if executable("clang++")
  let g:syntastic_cpp_compiler = 'clang++'
  let g:syntastic_cpp_compiler_options = '--std=c++11 --stdlib=libc++'
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
" set runtimepath                                             " NeoBundleの場合不要
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

" 現メモディレクトリ表示
nnoremap <silent> g,hh :echo howm_dir<CR>
" 環境変更コマンド
nnoremap <silent> g,ha :call HowmChEnv('',            'time', '#')<CR>
nnoremap <silent> g,hp :call HowmChEnv('private-mkd', 'time', '#')<CR>
nnoremap <silent> g,hw :call HowmChEnv('work-mkd',    'day',  '#')<CR>

"" gitv
" prevent folding when first dispaying gitv
augroup git
    au!
    autocmd FileType git :setlocal foldlevel=99
augroup END

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
nmap <Space>f <Plug>(easymotion-s2)
let g:EasyMotion_smartcase = 1

"" vim-easy-align'

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

"" vim-asterisk
vmap *   <Plug>(asterisk-*)
vmap #   <Plug>(asterisk-#)
vmap g*  <Plug>(asterisk-g*)
vmap g#  <Plug>(asterisk-g#)
map z*  <Plug>(asterisk-z*)
map gz* <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)

" OS Type "{{{1

if OSTYPE == "Darwin\n" " Mac
  set clipboard=unnamed " クリップボード利用設定
  if has('gui_running')
    set macmeta
  endif
elseif OSTYPE == "Linux\n" " Linux
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
elseif has('unix')
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
  nnoremap <Space>s. :<C-u>source $MYVIMRC<CR> :<C-u>source $MYGVIMRC<CR>
else
  nnoremap <Space>s. :<C-u>source $MYVIMRC<CR>
endif

" バッファ操作
nnoremap <Space>b :<C-u>ls<CR>:buf

" UTF-8 として読み込む
nnoremap <Space>e  :<C-u>e ++enc=utf-8<CR>
nnoremap <Space>E  :<C-u>e! ++enc=utf-8<CR>

" gitコマンドのショートカット
nnoremap <Space>g :<C-u>Git! 
nnoremap <Space>G :<C-u>Git 

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

" undofile
set undofile
set undodir='~/tmp/vim-undofile'

" 拡張子設定
au BufRead,BufNewFile *.red set filetype=reduce
au BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
let g:tex_flavor = "latex"

" au BufNewFile,BufRead *.{aspx,ascx} set filetype=html
" au BufNewFile,BufRead *.{aspx,ascx,cs,html,master} setlocal tabstop=4 shiftwidth=4
" au BufNewFile,BufRead *.{aspx,ascx,cs,html,master} setlocal noexpandtab softtabstop=4
" au BufNewFile,BufRead *.{aspx,ascx,cs,html,master} setlocal foldmethod=syntax

autocmd FileType *
\   if &l:omnifunc == ''
\ |   setlocal omnifunc=syntaxcomplete#Complete
\ | endif

" __END__  "{{{1
" vim: expandtab softtabstop=2 shiftwidth=2
" vim: foldmethod=marker
