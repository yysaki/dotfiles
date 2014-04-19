"if has('kaoriya')
set t_Co=256
colorscheme zenburn "カラースキーマを設定
set antialias
set showtabline=2 "常にタブ表示
"透明度の変更
if has('win32') || has('win64')
  gui "おまじない
"  set transparency=245
elseif has('gui_macvim')
  set transparency=10
endif
"endif

""起動時全画面化
"if has('gui_running')
"  set fuoptions=maxvert,maxhorz
"  au GUIEnter * set fullscreen
"endif
"
" タブの表示設定
function! GuiTabLabel()
  let l:label = ''
  let l:bufnrlist = tabpagebuflist(v:lnum)
  let l:bufname = fnamemodify(bufname(l:bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
  let l:label .= l:bufname == '' ? 'No title' : l:bufname
  let l:wincount = tabpagewinnr(v:lnum, '$')
  if l:wincount > 1
    let l:label .= '[' . l:wincount . ']'
  endif
  for bufnr in l:bufnrlist
    if getbufvar(bufnr, "&modified")
      let l:label .= '[+]'
      break
    endif
  endfor
  return l:label
endfunction
set guitablabel=%N:\ %{GuiTabLabel()}

