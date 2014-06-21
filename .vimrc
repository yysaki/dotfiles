" Basics "{{{1
set nocompatible

" Encoding "{{{2

if has('kaoriya') && !has('unix')
  set encoding=utf8
  scriptencoding cp932
elseif !has('unix')
  set encoding=cp932
else
  set encoding=utf8
endif

" NeoBundle "{{{1
" Bundles "{{{2
if has('vim_starting')
  if !has('unix') " if $mingw
    set runtimepath+=~/vimfiles/bundle/neobundle.vim/
    call neobundle#rc(expand('~/vimfiles/bundle/'))
  else
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand('~/.vim/bundle/'))
  endif
endif

NeoBundle 'Shougo/neobundle.vim'

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'           " :Unite file_mru
NeoBundle 'h1mesuke/unite-outline'      " :Unite outline
NeoBundle 'fuenor/qfixhowm'             " QFixHowm - hitori otegaru wiki modoki
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
NeoBundle 'tpope/vim-surround'          " <オペレータ>s<デリミタ> or ビジュアルモードでS<デリミタ>
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'vim-scripts/VimCoder.jar'    " topcoder
NeoBundle 'vim-scripts/errormarker.vim' " flymakeっぽいこと 実態確認 ':autocmd QuickFixCmdPost'
NeoBundle 'altercation/vim-colors-solarized' " solarized.vim
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

"" perl
NeoBundle 'petdance/vim-perl'
NeoBundle 'hotchpotch/perldoc-vim'

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


augroup MyNeobundle
  au!
  au Syntax vim syntax keyword vimCommand NeoBundle NeoBundleLazy NeoBundleSource NeoBundleFetch
augroup END

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

function! Neo_al(ft) "{{{
  return { 'autoload' : {
      \ 'filetype' : a:ft
      \ }}
endfunction
function! Neo_operator(mappings)
  return {
        \ 'depends' : 'kana/vim-textobj-user',
        \ 'autoload' : {
        \   'mappings' : a:mappings
        \ }}
endfunction
function! BundleLoadDepends(bundle_names)
  if !exists('g:loaded_bundles')
    let g:loaded_bundles = {}
  endif

  " bundleの読み込み
  if !has_key( g:loaded_bundles, a:bundle_names )
    execute 'NeoBundleSource '.a:bundle_names
    let g:loaded_bundles[a:bundle_names] = 1
  endif
endfunction

" コマンドを伴うやつの遅延読み込み
function! BundleWithCmd(bundle_names, cmd)
  call BundleLoadDepends(a:bundle_names)

  " コマンドの実行
  if !empty(a:cmd)
    execute a:cmd
  endif
endfunction

NeoBundle 'Shougo/vimproc', {
      \ 'build' : {
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }
NeoBundleLazy 'taichouchou2/vim-endwise.git', {
      \ 'autoload' : {
      \   'insert' : 1,
      \ } }

" ruby/rails
NeoBundle 'Shougo/neocomplcache-rsense', { 'autoload' : { 'filetypes' : ['ruby'], }, 'depends': 'Shougo/neocomplcache'}
NeoBundle 'taichouchou2/rsense-0.3', {
      \ 'build' : {
      \    'mac': 'ruby etc/config.rb > ~/.rsense',
      \    'unix': 'ruby etc/config.rb > ~/.rsense',
      \ } }
NeoBundle 'tpope/vim-rails'

function! s:bundleLoadDepends(bundle_names) "{{{
  " bundleの読み込み
  execute 'NeoBundleSource '.a:bundle_names
  au! MyAutoCmd
endfunction
aug MyAutoCmd
  au User Rails call <SID>bundleLoadDepends(s:bundle_rails)
aug END

" reference環境
NeoBundleLazy 'vim-ruby/vim-ruby', {
    \ 'autoload' : { 'filetypes': ['ruby', 'eruby', 'haml'] } }
NeoBundleLazy 'taka84u9/vim-ref-ri', {
      \ 'depends': ['Shougo/unite.vim', 'thinca/vim-ref'],
      \ 'autoload': { 'filetypes': ['ruby', 'eruby', 'haml'] } }
NeoBundleLazy 'skwp/vim-rspec', {
      \ 'autoload': { 'filetypes': ['ruby', 'eruby', 'haml'] } }
NeoBundleLazy 'ruby-matchit', {
    \ 'autoload' : { 'filetypes': ['ruby', 'eruby', 'haml'] } }

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

" <Space>q でquickrunする
silent! map <Space>q <Plug>(quickrun)

" neocomplcache "{{{2

let g:neocomplcache_enable_at_startup = 1

let g:neocomplcache_force_overwrite_completefunc = 1
let g:neocomplcache#sources#rsense#home_directory = expand('~/vimfiles/bundle/rsense-0.3')
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_skip_auto_completion_time = '0.3'

imap <expr><C-g>     neocomplcache#undo_completion()
imap <expr><CR>      neocomplcache#smart_close_popup() . "<CR>" . "<Plug>DiscretionaryEnd"
imap <silent><expr><S-TAB> pumvisible() ? "\<C-P>" : "\<S-TAB>"
" imap <silent><expr><TAB>   pumvisible() ? "\<C-N>" : "\<TAB>"
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

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

" neocomplcache向け
let g:neocomplcache_force_overwrite_completefunc=1
if !exists("g:neocomplcache_force_omni_patterns")
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|::'

" neosnippet "{{{2

let g:neosnippet#snippets_directory = "~/vimfiles/snippets,~/vimfiles/bundle/vim-snippets/"
imap <silent><C-F>                <Plug>(neosnippet_expand_or_jump)
inoremap <silent><C-U>            <ESC>:<C-U>Unite snippet<CR>
nnoremap <silent><Space>e         :<C-U>NeoSnippetEdit -split<CR>
smap <silent><C-F>                <Plug>(neosnippet_expand_or_jump)
" xmap <silent>o                    <Plug>(neosnippet_register_oneshot_snippet)

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

" Omnisharp "{{{2

if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.cs = '[^.]\.\%(\u\{2,}\)\?'

" vim-rails "{{{2
"有効化
let g:rails_default_file='config/database.yml'
let g:rails_level = 4
let g:rails_mappings=1
let g:rails_modelines=0
" let g:rails_some_option = 1
" let g:rails_statusline = 1
" let g:rails_subversion=0
" let g:rails_syntax = 1
" let g:rails_url='http://localhost:3000'
" let g:rails_ctags_arguments='--languages=-javascript'
" let g:rails_ctags_arguments = ''
function! SetUpRailsSetting()
  nnoremap <buffer><Space>r :R<CR>
  nnoremap <buffer><Space>a :A<CR>
  nnoremap <buffer><Space>m :Rmodel<Space>
  nnoremap <buffer><Space>c :Rcontroller<Space>
  nnoremap <buffer><Space>v :Rview<Space>
  nnoremap <buffer><Space>p :Rpreview<CR>
endfunction

aug MyAutoCmd
  au User Rails call SetUpRailsSetting()
aug END

aug RailsDictSetting
  au!
aug END

" vim-ref "{{{2
"
let g:ref_open                    = 'split'
let g:ref_refe_cmd                = expand('~/vimfiles/ref/ruby-ref1.9.2/refe-1_9_2')

aug MyAutoCmd
  au FileType ruby,eruby,ruby.rspec nnoremap <silent><buffer>KK :<C-U>Unite -no-start-insert ref/ri   -input=<C-R><C-W><CR>
  au FileType ruby,eruby,ruby.rspec nnoremap <silent><buffer>K  :<C-U>Unite -no-start-insert ref/refe -input=<C-R><C-W><CR>
aug END

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

" Other Neobundle Plugins' Setting "{{{2

" RSense
let g:rsenseUseOmniFunc = 1

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
let howm_dir                = '~/Dropbox/Files/howm/dir'      " ファイルを保存したいディレクトリ
let howm_fileencoding       = 'utf-8'
let howm_fileformat         = 'unix'
let howm_filename           = '%Y/%m/%Y-%m-%d-%H%M%S.mkd'
let QFixHowm_FileType       = 'markdown'
let QFixHowm_Title          = '#'                             " タイトル記号
let QFixHowm_FoldingPattern = '^[#[]'                         " 折りたたみのパターン

" OS Type "{{{1

let OSTYPE = system('uname')

if OSTYPE == "Darwin\n" " Mac
  set clipboard=unnamed " クリップボード利用設定
  NeoBundle 'kana/vim-fakeclip'
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

" <M-{x}> => <Esc>x
function! s:emulate_meta_esc_behavior_in_terminal()

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
nmap <Esc>  <C-w>

" <M-{x}> => <Esc>x if has('gui_running')
call s:emulate_meta_esc_behavior_in_terminal()

" vimrcをオープン, リロード
nnoremap <Space>.  :<C-u>edit $MYVIMRC<CR>
if has('gui_running')
  nnoremap <Space>g.  :<C-u>edit $MYGVIMRC<CR>
  nnoremap <Space>s. :<C-u>source $MYVIMRC<CR> :<C-u>source $MYGVIMRC<CR>
else
  nnoremap <Space>s. :<C-u>source $MYVIMRC<CR>
endif

" バッファ操作
nnoremap <Space>b :<C-u>ls<CR>:buf

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
nmap cc <Plug>(ToggleColorColumn)
set pastetoggle=<F5> " <F5>でペーストモードのトグル

nnoremap <F5>  :!ctags -R<CR>

" &コマンドの修正
nnoremap &  :&&<CR>
xnoremap &  :&&<CR>

" Generals "{{{1

filetype plugin indent on "プラグインをオンにする

set ignorecase
set infercase

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

set t_Co=256 " 256色モード
set hlsearch " 検索結果をハイライト

" 拡張子設定
au BufRead,BufNewFile *.red set filetype=reduce
au BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
let g:tex_flavor = "latex"

au BufNewFile,BufRead *.{aspx,ascx,cs} setlocal tabstop=4 shiftwidth=4
au BufNewFile,BufRead *.{aspx,ascx,cs} setlocal noexpandtab softtabstop=4
au BufNewFile,BufRead *.{aspx,ascx,cs} setlocal foldmethod=syntax

autocmd FileType *
\   if &l:omnifunc == ''
\ |   setlocal omnifunc=syntaxcomplete#Complete
\ | endif

" __END__  "{{{1
" vim: expandtab softtabstop=2 shiftwidth=2
" vim: foldmethod=marker
