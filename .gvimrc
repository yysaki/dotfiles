" エラー音とビジュアルベルの抑制
set noerrorbells
set novisualbell
set visualbell t_vb=

set t_Co=256
set antialias
set showtabline=2 "常にタブ表示

set guioptions='grLtT' " default: 'egmrLtT'

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

set background=dark
colorscheme hybrid

set guifont=Ricty:h13
