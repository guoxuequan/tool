""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" 一般设定 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 设定默认解码 
set fenc=utf-8 
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936 
" 不要使用vi的键盘模式，而是vim自己的 
set nocompatible 
" history文件中需要记录的行数 
set history=1000 
" 在处理未保存或只读文件的时候，弹出确认 
set confirm 
" 侦测文件类型 
filetype on 
" 载入文件类型插件 
filetype plugin on 
" 为特定文件类型载入相关缩进文件 
filetype indent on 
" 保存全局变量 
set viminfo+=! 
" 带有如下符号的单词不要被换行分割 
set iskeyword+=_,$,@,%,#,- 
" 语法高亮 
"syntax on 
" 设置行号
"set number
" 高亮字符，让其不受100列限制 
":highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white 
":match OverLength '\%101v.*' 
" 状态行颜色 
"highlight StatusLine guifg=SlateBlue guibg=Yellow 
"highlight StatusLineNC guifg=Gray guibg=White 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" 文本格式和排版 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" 自动格式化 
set formatoptions=tcrqn 

" 继承前一行的缩进方式，特别适用于多行注释 
set autoindent 

" 为C程序提供自动缩进 
set smartindent 

" 使用C样式的缩进 
"set cindent 

" 不要用空格代替制表符 
"set noexpandtab 
" 设置Tab为空格
set expandtab

" 制表符为4 
set tabstop=4 

" 统一缩进为4 
set softtabstop=4 
set shiftwidth=4 

" 不要换行 
set nowrap 

" 在行和段开始处使用制表符 
set smarttab 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"小功能
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"自动将光标移到配对的括号或引号中间
imap () ()<Left>
imap [] []<Left>
imap {} {}<Left>
imap "" ""<Left>
imap '' ''<Left>
imap <> <><Left>
"窗口跳转
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "normal g`\"" |
\ endif


"取消自动注释
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


set background=dark

syntax on

set autoindent
set smartindent
set showmatch
set guioptions-=T
set vb t_vb=
set ruler
set nocp
set backspace=indent,eol,start
set incsearch

if has("vms")
  set backup
else
  set nobackup
endif

"helptags ~/.vim/doc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Doxygen配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"doxygen toolkit
"let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
"let g:DoxygenToolkit_paramTag_pre="@Param "
"let g:DoxygenToolkit_returnTag="@Returns   "
"let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
"let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
"let g:DoxygenToolkit_authorName="Xuequan Guo"
"let g:DoxygenToolkit_authorName="xguo@ubiquant.com"
"let s:licenseTag="Copyright(C) $YEAR$ Ubiquant Investment\ All right reserved\ "
"let g:DoxygenToolkit_licenseTag = s:licenseTag
"let g:DoxygenToolkit_briefTag_funcName="yes"
"let g:doxygen_enhanced_color=1

map <C-i> <Esc>:DoxyHead
map <C-p> <Esc>:DoxyPyHead
map <C-a> <Esc>:DoxyAuthor

"添加只包含一次文件的宏#ifndef ..#define #endif
"使用方法：在普通模式下击键zho
function InsertPragmaOnceTag()
"let CurTime = strftime("%Y_%m_%d_%H_%M")
let DATE = strftime("%Y-%m-%d")
""将当前时间格式化后存入到CurTime当中去
let CurFilePath = toupper(expand("%")) "expand(/"%/")获取当前编辑的文件路径
let LastSlash = strridx(CurFilePath, "/") "找出路径中最后一个/
let HeadTag1 = "#ifndef "
let HeadTag2 = "#define "
let HeadTag3 = "#endif //"
"将非数字、字母替换为_
let Suffix = substitute(strpart(CurFilePath, LastSlash + 1), "[^a-zA-Z0-9]", "_", "g")
let HeadTag1 = HeadTag1."__".Suffix."__"
let HeadTag2 = HeadTag2."__".Suffix."__"
let HeadTag3 = HeadTag3."__".Suffix."__"

"跳转到第一行并输入#ifndef ..
exe "normal ggO".HeadTag1 
exe "normal O".HeadTag2
exe "normal Go".HeadTag3
""添加一个空白行
exe "normal o"
"添加两行空白行并将光标停在第四行
normal 4GO
normal 5GO
endfunction

"nmap <C-i> <Esc>:call InsertPragmaOnceTag()<CR>i

" Go crazy!
if filereadable(expand("~/.vimrc.local"))
  " In your .vimrc.local, you might like:
  "
  " set autowrite
  " set nocursorline
  " set nowritebackup
  " set whichwrap+=<,>,h,l,[,] " Wrap arrow keys between lines
  "
  " autocmd! bufwritepost .vimrc source ~/.vimrc
  " noremap! jj <ESC>
  source ~/.vimrc.local
endif
