" todo kaoriya-vimのみ.vim => vimfilesと判断する変数？を導入する
"if has('kaoriya') && (has('win32')||has('win64')||has('win95')||has('win16'))
"  let VIMFILES='~/vimfiles'
"else
"  let VIMFILES='~/.vim'
"endif

filetype off

let OSTYPE = system('uname')

if OSTYPE == "Darwin\n"
  ""ここにMac向けの設定
elseif OSTYPE == "Linux\n"
  ""ここにLinux向けの設定
endif

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

"""""  20130410
" https://gist.github.com/taichouchou2/4521542
" neobundle"{{{
"filetype plugin indent off     " required!

" initialize"{{{
"if has('vim_starting')
"  let bundle_dir = '~/.bundle'
"  if !isdirectory(bundle_dir.'/neobundle.vim')
"    call system( 'git clone https://github.com/Shougo/neobundle.vim.git '.bundle_dir.'/neobundle.vim')
"  endif
"
"  exe 'set runtimepath+='.bundle_dir.'/neobundle.vim'
"  call neobundle#rc(bundle_dir)
"endif

augroup MyNeobundle
  au!
  au Syntax vim syntax keyword vimCommand NeoBundle NeoBundleLazy NeoBundleSource NeoBundleFetch
augroup END
"}}}

" 暫定customize {{{
function! Neo_al(ft) "{{{
  return { 'autoload' : {
      \ 'filetype' : a:ft
      \ }}
endfunction"}}}
function! Neo_operator(mappings) "{{{
  return {
        \ 'depends' : 'kana/vim-textobj-user',
        \ 'autoload' : {
        \   'mappings' : a:mappings
        \ }}
endfunction"}}}
function! BundleLoadDepends(bundle_names) "{{{
  if !exists('g:loaded_bundles')
    let g:loaded_bundles = {}
  endif

  " bundleの読み込み
  if !has_key( g:loaded_bundles, a:bundle_names )
    execute 'NeoBundleSource '.a:bundle_names
    let g:loaded_bundles[a:bundle_names] = 1
  endif
endfunction"}}}
"}}}

" コマンドを伴うやつの遅延読み込み
function! BundleWithCmd(bundle_names, cmd) "{{{
  call BundleLoadDepends(a:bundle_names)

  " コマンドの実行
  if !empty(a:cmd)
    execute a:cmd
  endif
endfunction "}}}
"bundle"{{{
" その他 {{{
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
" }}}

" 補完 {{{
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'

NeoBundle 'Shougo/neocomplcache-rsense', { 'autoload' : { 'filetypes' : ['ruby'], }, }
"NeoBundleLazy 'Shougo/neocomplcache-rsense', {
"      \ 'depends': 'Shougo/neocomplcache',
"      \ 'autoload': { 'filetypes': 'ruby' }}
NeoBundle 'taichouchou2/rsense-0.3', {
      \ 'build' : {
      \    'mac': 'ruby etc/config.rb > ~/.rsense',
      \    'unix': 'ruby etc/config.rb > ~/.rsense',
      \ } }
" }}}

" 便利 {{{
" 範囲指定のコマンドが使えないので、tcommentのLazy化はNeoBundleのアップデートを待ちましょう...
NeoBundle 'tomtom/tcomment_vim'
NeoBundleLazy 'tpope/vim-surround', {
      \ 'autoload' : {
      \   'mappings' : [
      \     ['nx', '<Plug>Dsurround'], ['nx', '<Plug>Csurround'],
      \     ['nx', '<Plug>Ysurround'], ['nx', '<Plug>YSurround'],
      \     ['nx', '<Plug>Yssurround'], ['nx', '<Plug>YSsurround'],
      \     ['nx', '<Plug>YSsurround'], ['vx', '<Plug>VgSurround'],
      \     ['vx', '<Plug>VSurround']
      \ ]}}
" }}}

" ruby / railsサポート {{{
NeoBundle 'tpope/vim-rails'
NeoBundleLazy 'ujihisa/unite-rake', {
      \ 'depends' : 'Shougo/unite.vim' }
NeoBundleLazy 'basyura/unite-rails', {
      \ 'depends' : 'Shjkougo/unite.vim' }
NeoBundleLazy 'taichouchou2/unite-rails_best_practices', {
      \ 'depends' : 'Shougo/unite.vim',
      \ 'build' : {
      \    'mac': 'gem install rails_best_practices',
      \    'unix': 'gem install rails_best_practices',
      \   }
      \ }
NeoBundleLazy 'taichouchou2/unite-reek', {
      \ 'build' : {
      \    'mac': 'gem install reek',
      \    'unix': 'gem install reek',
      \ },
      \ 'autoload': { 'filetypes': ['ruby', 'eruby', 'haml'] },
      \ 'depends' : 'Shougo/unite.vim' }
NeoBundleLazy 'taichouchou2/alpaca_complete', {
      \ 'depends' : 'tpope/vim-rails',
      \ 'build' : {
      \    'mac':  'gem install alpaca_complete',
      \    'unix': 'gem install alpaca_complete',
      \   }
      \ }

let s:bundle_rails = 'unite-rails unite-rails_best_practices unite-rake alpaca_complete'

function! s:bundleLoadDepends(bundle_names) "{{{
  " bundleの読み込み
  execute 'NeoBundleSource '.a:bundle_names
  au! MyAutoCmd
endfunction"}}}
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
" }}}

" }}}

" Installation check. "{{{
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Install Plugins'
  NeoBundleInstall
endif
"}}}
filetype plugin indent on
"}}}
" plugin settings"{{{
"------------------------------------
" endwise.vim
"------------------------------------
"{{{
let g:endwise_no_mappings=1
"}}}

"------------------------------------
" vim-surround
"------------------------------------
" {{{
nmap ds  <Plug>Dsurround
nmap cs  <Plug>Csurround
nmap ys  <Plug>Ysurround
nmap yS  <Plug>YSurround
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround
nmap ySS <Plug>YSsurround
xmap S   <Plug>VSurround
xmap gS  <Plug>VgSurround
vmap s   <Plug>VSurround

" surround_custom_mappings.vim"{{{
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
"}}}
"}}}

"------------------------------------
" neocomplcache
"------------------------------------
" 補完・履歴 neocomplcache "{{{
set infercase

"----------------------------------------
" neocomplcache
let g:neocomplcache_enable_at_startup = 1

" default config"{{{
let g:neocomplcache_force_overwrite_completefunc = 1
let g:neocomplcache#sources#rsense#home_directory = expand('~/vimfiles/bundle/rsense-0.3')
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_skip_auto_completion_time = '0.3'
"}}}

" keymap {{{
imap <expr><C-g>     neocomplcache#undo_completion()
imap <expr><CR>      neocomplcache#smart_close_popup() . "<CR>" . "<Plug>DiscretionaryEnd"
imap <silent><expr><S-TAB> pumvisible() ? "\<C-P>" : "\<S-TAB>"
" imap <silent><expr><TAB>   pumvisible() ? "\<C-N>" : "\<TAB>"
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_jump_or_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
" }}}
"}}}

"------------------------------------
" neosnippet
"------------------------------------
" neosnippet "{{{

" snippetを保存するディレクトリを設定してください
" example
" let s:default_snippet = neobundle#get_neobundle_dir() . '/neosnippet/autoload/neosnippet/snippets' " 本体に入っているsnippet
" let s:my_snippet = '~/snippet' " 自分のsnippet
" let g:neosnippet#snippets_directory = s:my_snippet
" let g:neosnippet#snippets_directory = s:default_snippet . ',' . s:my_snippet
imap <silent><C-F>                <Plug>(neosnippet_expand_or_jump)
inoremap <silent><C-U>            <ESC>:<C-U>Unite snippet<CR>
nnoremap <silent><Space>e         :<C-U>NeoSnippetEdit -split<CR>
smap <silent><C-F>                <Plug>(neosnippet_expand_or_jump)
" xmap <silent>o                    <Plug>(neosnippet_register_oneshot_snippet)
"}}}

"------------------------------------
" vim-rails
"------------------------------------
""{{{
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
"}}}

"------------------------------------
" Unite-rails.vim
"------------------------------------
"{{{
function! UniteRailsSetting()
  nnoremap <buffer><C-H><C-H><C-H>  :<C-U>Unite rails/view<CR>
  nnoremap <buffer><C-H><C-H>       :<C-U>Unite rails/model<CR>
  nnoremap <buffer><C-H>            :<C-U>Unite rails/controller<CR>

  nnoremap <buffer><C-H>c           :<C-U>Unite rails/config<CR>
  nnoremap <buffer><C-H>s           :<C-U>Unite rails/spec<CR>
  nnoremap <buffer><C-H>m           :<C-U>Unite rails/db -input=migrate<CR>
  nnoremap <buffer><C-H>l           :<C-U>Unite rails/lib<CR>
  nnoremap <buffer><expr><C-H>g     ':e '.b:rails_root.'/Gemfile<CR>'
  nnoremap <buffer><expr><C-H>r     ':e '.b:rails_root.'/config/routes.rb<CR>'
  nnoremap <buffer><expr><C-H>se    ':e '.b:rails_root.'/db/seeds.rb<CR>'
  nnoremap <buffer><C-H>ra          :<C-U>Unite rails/rake<CR>
  nnoremap <buffer><C-H>h           :<C-U>Unite rails/heroku<CR>
endfunction
aug MyAutoCmd
  au User Rails call UniteRailsSetting()
aug END
"}}}

"----------------------------------------
" vim-ref
"----------------------------------------
"{{{
let g:ref_open                    = 'split'
let g:ref_refe_cmd                = expand('~/vimfiles/ref/ruby-ref1.9.2/refe-1_9_2')

nnoremap rr :<C-U>Unite ref/refe     -default-action=split -input=
nnoremap ri :<C-U>Unite ref/ri       -default-action=split -input=

aug MyAutoCmd
  au FileType ruby,eruby,ruby.rspec nnoremap <silent><buffer>KK :<C-U>Unite -no-start-insert ref/ri   -input=<C-R><C-W><CR>
  au FileType ruby,eruby,ruby.rspec nnoremap <silent><buffer>K  :<C-U>Unite -no-start-insert ref/refe -input=<C-R><C-W><CR>
aug END
"}}}

"------------------------------------
" Unite-reek, Unite-rails_best_practices
"------------------------------------
" {{{
nnoremap <silent> [unite]<C-R>      :<C-u>Unite -no-quit reek<CR>
nnoremap <silent> [unite]<C-R><C-R> :<C-u>Unite -no-quit rails_best_practices<CR>
" }}}
"}}}
""""" /20130410

" RSense
let g:rsenseUseOmniFunc = 1

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'hallison/vim-markdown'
NeoBundle 'msanders/cocoa.vim'
if has('python')
  NeoBundle 'kakkyz81/evervim'
endif

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'vim-scripts/errormarker.vim'

"" perl
NeoBundle 'petdance/vim-perl'
NeoBundle 'hotchpotch/perldoc-vim'

NeoBundle 'Rip-Rip/clang_complete'

"NeoBundle 'Shougo/vimproc'
"NeoBundle 'Shougo/vimshell'

NeoBundle 'project.tar.gz'

"" javascript http://layzie.hatenablog.com/entry/20130122/1358811539
NeoBundle 'jiangmiao/simple-javascript-indenter'
NeoBundle 'jQuery'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'teramako/jscomplete-vim'
NeoBundle 'scrooloose/syntastic'         " 汎用
NeoBundle 'majutsushi/tagbar'            " ctags汎用

"" HTML/CSS
" old NeoBundle 'mattn/zencoding-vim'
NeoBundle 'mattn/emmet-vim'


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

"" clang_complete
let g:clang_complete_auto=0
let g:clang_use_library=1

" neocomplcache向け
let g:neocomplcache_force_overwrite_completefunc=1
if !exists("g:neocomplcache_force_omni_patterns")
    let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|::'


"" Evervim
let g:evervim_devtoken='S=s14:U=19a7f1:E=1437499124e:C=13c1ce7e64f:P=1cd:A=en-devtoken:H=9c2cea93a3de758b41d2a699bc55920d'

nnoremap <Leader>l :EvervimNotebookList<CR>
nnoremap <Leader>s :EvervimSearchByQuery<Space>
nnoremap <Leader>c :EvervimCreateNote<CR>
nnoremap <Leader>b :EvervimOpenBrowser<CR>

"" open browser
nnoremap <Leader>o <Plug>(openbrowser-smart-search) 

""" javascript
"" simple-javascript-indenter
" この設定入れるとshiftwidthを1にしてインデントしてくれる
let g:SimpleJsIndenter_BriefMode = 1
" この設定入れるとswitchのインデントがいくらかマシに
let g:SimpleJsIndenter_CaseIndentLevel = -1
"" jQuery
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

"" jscomplete-vim
" DOMとMozilla関連とES6のメソッドを補完
 let g:jscomplete_use = ['dom', 'moz', 'es6th']

"" syntastic
" このようにするとjshintを必ず使ってチェックしてくれるようになる
let g:syntastic_javascript_checker = "jshint"
"" http://www.daisaru11.jp/blog/2011/09/vimsyntastic%E3%81%A7%E6%96%87%E6%B3%95%E3%83%81%E3%82%A7%E3%83%83%E3%82%AF%E3%82%92%E8%87%AA%E5%8B%95%E3%81%A7%E8%A1%8C%E3%81%86/
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

"" tagbar
nnoremap <silent> <F7> :TagbarToggle<CR>
 let g:tagbar_type_javascript = {
     \ 'ctagsbin' : '/usr/local/share/npm/bin/jsctags'
     \ }

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
"helptags ~/vimfiles/doc/
set helplang=ja,en                 

"ファイル情報の表示
set laststatus=2 
set statusline=%F%m%r%h%w\=[TYPE=%Y]\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[LOW=%l/%L]

if has('win32') || has('win64') || has('win95') || has('win16')
  "/User/yysaki/に移動(win)
  cd $HOME
endif

if OSTYPE == "Darwin\n"
  " クリップボード利用設定
  set clipboard=unnamed
  NeoBundle 'kana/vim-fakeclip'
endif

if has('gui_macvim') || has('win32') || has('win64') || has('win95') || has('win16')
  source ~/.gvimrc  " GVimの時 .gvimrcを適用 
endif

"TODO 文字数カウント
"vnoremap <C-C> :s/./&/gn<Enter>

" バッファ操作
" http://kaworu.jpn.org/kaworu/2007-07-26-1.php
nnoremap bb :ls<CR>:buf

" 256色モード
set t_Co=256

" 検索結果をハイライト
set hlsearch

