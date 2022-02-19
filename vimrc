" Basic
	set		nocompatible
	set		mouse=a
	nnor	<silent> <ESC>m :if&mouse=="a"<Bar>set mouse=<Bar>else<Bar>set mouse=a<Bar>endif<CR>

	set		backspace=2

	set		number
	nnor	<ESC>n :set nu!<CR>

	set		cursorline

	nnor	ve :vnew $VIMRC<CR> 
	nnor	vs :source $VIMRC<CR>

	nnor	vl :vnew .eslintrc.js<CR>

	set		hlsearch
	set		incsearch
	nnor	<silent> <ESC>f :set hlsearch!<CR>
	nnor	fiw yiw/\<<C-R>"\><CR>
	nnor	siw yiw:%s/\<<C-R>"\>/
	vnor	/ y<ESC>/\<<C-R>"\><CR>
	vnor	s y<ESC>:%s/\<<C-R>"\>/
	vnor	<C-S> y<ESC>:%s/<C-R>"/

	nnor	?? :h 
	nnor	S :w<CR>
	nnor	Sq :wq<CR>

	set		undodir=$VIMFILES/undodir

	nnor	Sg :w<CR>:!gulp<CR>
	nnor	Sgg :w<CR>:!gulp 

	nnor	Sr :w<CR>:!rustc % -o ~/src/rust/tmp.out && ~/src/rust/tmp.out<CR>
	nnor	Sn :w<CR>:!node %<CR>
	nnor	Se :w<CR>:!node esbuild.cjs<CR><CR>

	nnor	Sy :w<CR>:!xclip -selection c %<CR>

	nnor	St :w<CR>:!tsc<CR>

	set		shiftwidth=4
	set		tabstop=4
	set		softtabstop=4
	set		foldmethod=indent

    let space_indented = [ 'extend-luogu.user.js', 'exlg-setting/novogui.js', 'novogui.js' ]
    if index(space_indented, expand('%')) >= 0
		inor <TAB> <SPACE><SPACE><SPACE><SPACE>
	end

	set		nowrap
	nnor	<silent> <ESC>w :set wrap!<CR>

	nnor	c'	mqF"r'f"r'`q
	nnor	c"	mqF'r"f'r"`q
	nnor	c`	mqF"r`f"r``q

	nnor	cx' mqF'xf'x`ql
	nnor	cx"	mqF"xf"x`ql

    nnor    'iw mQbi'<ESC>Ea'<ESC>`Ql
    nnor    "iw mQbi"<ESC>Ea"<ESC>`Ql

	nnor	c$	F`dt+df<SPACE>i${<ESC>f`xdT+dF<SPACE>i}<ESC>
	nmap	c$'	mTF'c"c`f'lc"c``Tc$`T
	nmap	c$"	mTF"c`f"lc``Tc$`T

" Learner
	map <Left>	<Nop>
	map <Right>	<Nop>
	map <Up>	<Nop>
	map <Down>	<Nop>

" Highlight " Vim
	set		t_Co=256
	sy on
	
	hi LineNr								ctermfg=White
	hi CursorLine													cterm=underline
	hi CursorLineNr													cterm=bold
	
	hi qfLineNr								ctermfg=DarkGreen
	
	hi Folded								ctermfg=Black			ctermbg=Grey

	hi Pmenu														ctermbg=LightGrey

" Highlight " Via
	hi Annotation							ctermfg=Blue
	hi AnnotationBracket					ctermfg=Grey
	hi AnnotationSymbol						ctermfg=Red
	hi AnnotationComma						ctermfg=Grey
	hi AnnotationType						ctermfg=DarkBlue		cterm=underline
	hi AnnotationNote						ctermfg=DarkGrey

" FtDetect
aug FtDetect | au!
	au BufRead,BufNewFile	*.via			setf via			" VIm Annotated
	au BufRead,BufNewFile	*.tico			setf tico			" Text ICOn
	au BufRead,BufNewFile	*.mcmeta		setf json
	au BufRead,BufNewFile	*.styl			setf stylus
	au BufRead,BufNewFile	log-port		setf log_port
	au FileType				via				cal VimAnn()
	au FileType				tico			cal TIco()
	au FileType				javascript		cal JS()
	au FileType				gitcommit		cal GitCommit()
	au FileType				log_port		cal L_Port()
aug END

" Via

let g:via_map = 'English'
fun! VimAnn()
	setl	nofoldenable

	" Syntax
	fun! SynAnn()
		if exists('b:via_syn') | retu | endif
		let b:via_syn = 1
		" echom '[via] Syn: ' . (&ft == 'via' ? 'main' : 'loc') . '.'

		sy match	Annotation			/(.\{-})/				contains=
			\AnnotationBracket,AnnotationSymbol,AnnotationComma,
			\AnnotationType,AnnotationNote
		sy match	AnnotationBracket	/[()]/					contained
		sy match	AnnotationSymbol	/[@*!=<>#\-|:]/			contained
		sy match	AnnotationComma		/,/						contained
		sy match	AnnotationType		/#[^()@*!=<>#\-|:]\+\./	contained
		sy match	AnnotationNote		/\(:\)\@<=[^)]\+/		contained
	endfun
	cal SynAnn()

	" Map

	let s:umap_dict = g:via_map
	if s:umap_dict == 'English'
		let s:umap_dict = #{
		\ InsertAnn: '<C-A>a',
		\ OpenAnnWin: '<C-A>o',
		\ UpdOpenAnnWin: '<C-A>p',
		\ CloseAnnWin: '<C-A>q',
		\ NextAnnWin: '<C-A>]',
		\ PrevAnnWin: '<C-A>[',
		\ }
	elseif s:umap_dict == 'Chinese'
		let s:umap_dict = #{
		\ InsertAnn: '；',
		\ NextAnnInl: '】',
		\ PrevAnnInl: '【',
		\ EscBang: '！',
		\ EscComma: '，',
		\ EscAngleL: '《',
		\ EscAngleR: '》',
		\ OpenAnnWin: '。',
		\ UpdOpenAnnWin: '。。',
		\ CloseAnnWin: '。，',
		\ NextAnnWin: '｝',
		\ PrevAnnWin: '｛',
		\ CopyCurWord: '、'
		\ }
	endif

	cal _umap('InsertAnn', '<Right>()<Left>', 'i', { 'necessary': 1 })
	cal _umap('InsertAnn', 'a()<Left>', 'n')
	cal _umap('NextAnnInl', 'f(', 'ni')
	cal _umap('PrevAnnInl', 'F(', 'ni')

  	cal _umap('EscBang', '!', 'i')
  	cal _umap('EscBang', ',', 'i')
  	cal _umap('EscBang', '<', 'i')
  	cal _umap('EscBang', '>', 'i')
	
	cal _umap('OpenAnnWin', ':lop<CR><C-W>k', 'ni', { 'silent': 1 })
	cal _umap('UpdOpenAnnWin', ':cal UpdAnn()<CR>:lop<CR>:cal SynAnn()<CR><C-W>k', 'ni', { 'silent': 1 })
	cal _umap('CloseAnnWin', ':lclose<CR>', 'ni')

	cal _umap('NextAnnWin', ':lnext<CR>', 'ni', { 'silent': 1 })
	cal _umap('PrevAnnWin', ':lprev<CR>', 'ni', { 'silent': 1 })

	cal _umap('CopyCurWord', '<ESC>mUyiw`Ua', 'i')

	setl	iskeyword+=-
	iabb	via-h 
		\(Title         @)<CR>
		\(LocaleTitle   @)<CR>
		\(Author        @)<CR>

	" Annotation location window
	fun! GetAnn(fmt)
		let ls = getline(1, '$')
		let a = []
		let i = 0 | whi i < len(ls)
			let aR = { 'R': i, 'ann': [] }
			let j = 0 | whi 1
				let r = matchstrpos(ls[i], '[A-Za-z\-]\{-}(.\{-})', j)
				let j = r[2]
				if j == -1 | brea | endif
				let aC = { 'C': r[1], 'txt': r[0] }
				if type(a:fmt) == 2
					let f = a:fmt(r[0])
					for k in keys(f)
						let aC[k] = f[k]
					endfor
				endif
				cal add(aR.ann, aC)
			endwhi
			if len(aR.ann) > 0
				cal add(a, aR)
			endif
		let i += 1 | endwhi
		retu a
	endfun

	fun! UpdAnn()
		fun! EngAnn(t)
			let r = split(a:t[:-2], '(')
			if len(r) == 1 | let r = [ "" ] + r | endif
			let n = { 'tar': r[0], 'ann': r[1] }
			if match(r[1], '@') != -1
				let n.meta = split(r[1], '\s\?@')
			endif
			retu n
		endfun

		fun! TxtAnn(d)
			let is = getloclist(0, { 'id': a:d.id, 'items': 1 }).items
			let ls = []
			for i in range(a:d.start_idx - 1, a:d.end_idx - 1)
				let it = is[i]
				cal add(ls,
					\ it.type . '|' .
					\ _space(it.lnum, 4) . ', ' .
					\ _space(it.col, 5) . '| ' .
					\ it.text)
			endfor
			retu ls
		endfun

		cal setloclist(0, [])
		" echom '[via] Clr.'
		
		let a = GetAnn(funcref('EngAnn'))
		let is = []
		for aR in a
			for aC in aR.ann
				let m = aC.tar == "" && exists("aC.meta")
				let it = {
					\ 'lnum': (aR.R + 1), 'col': (aC.C + 1),
					\ 'type': (m ? 'M' : 'A'),
					\ 'text': (m ? aC.meta[0] . ' @ ' . aC.meta[1]
					\			 : aC.txt),
					\ 'bufnr': bufnr() }
				cal add(is, it)
			endfor
		endfor
		
		cal setloclist(0, [], 'r', {
			\ 'title': 'Annotations', 'items': is,
			\ 'quickfixtextfunc': 'TxtAnn' })
		" echom '[via] Upd.'
		if exists("b:via_syn") | unlet b:via_syn | endif
	endfun
endf

" TIco

fun! TIco()
	" Syntax & Highlight

	sy clear

	sy region	TIcoMain		start=/<<</ end=/>>>/ contains=
		\TIcoBg,TIcoFg,TIcoRed,TIcoRedL,TIcoBlue,TIcoBlueL,TIcoMagenta,TIcoMagentaL,TIcoGrey
	sy match	TIcoBg			/#/ contained
	sy match	TIcoFg			/ / contained
	sy match	TIcoRed			/R/ contained
	sy match	TIcoRedL		/r/ contained
	sy match	TIcoBlue		/B/ contained
	sy match	TIcoBlueL		/b/ contained
	sy match	TIcoMagenta		/M/ contained
	sy match	TIcoMagentaL	/m/ contained
	sy match	TIcoGrey		/G/ contained

	hi TIcoBg				ctermfg=Black
	hi TIcoFg				ctermbg=White
	hi TIcoRed				ctermfg=Red
	hi TIcoRedL				ctermfg=LightRed
	hi TIcoBlue				ctermfg=Blue
	hi TIcoBlueL			ctermfg=LightBlue
	hi TIcoMagenta			ctermfg=Magenta
	hi TIcoMagentaL			ctermfg=LightMagenta
	hi TIcoGrey				ctermfg=Grey

	hi TIcoConfig			ctermfg=White
endf

" JS

fun! JS()
	" Indent
	set foldmethod=syntax

	" Highlight

	hi jsComment				ctermfg=21		cterm=italic
	hi jsEnvComment				ctermfg=21		cterm=italic,underline
	" hi jsParensIfElse			
	" hi jsParensRepeat
	" hi jsParensSwitch
	" hi jsParensCatch
	" hi jsCommentTodo
	hi jsString					ctermfg=129
	hi jsObjectKeyString		ctermfg=129
	hi jsTemplateString			ctermfg=129
	hi jsObjectStringKey		ctermfg=129
	hi jsClassStringKey			ctermfg=129
	hi jsTaggedTemplate			ctermfg=20
	hi jsTernaryIfOperator		ctermfg=247
	hi jsRegexpString			ctermfg=129
	hi jsRegexpBoundary			ctermfg=129
	hi jsRegexpQuantifier		ctermfg=46
	hi jsRegexpOr				ctermfg=190
	hi jsRegexpMod				ctermfg=129
	hi jsRegexpBackRef			ctermfg=202
	hi jsRegexpGroup			ctermfg=74
	hi jsRegexpCharClass		ctermfg=74
	hi jsCharacter				ctermfg=129
	hi jsPrototype				ctermfg=205
	hi jsConditional			ctermfg=37		cterm=bold
	hi jsBranch					ctermfg=37
	hi jsLabel					ctermfg=202
	hi jsReturn					ctermfg=27		cterm=bold
	hi jsRepeat					ctermfg=41		cterm=bold
	hi jsDo						ctermfg=41		cterm=bold
	hi jsStatement				ctermfg=27		cterm=bold
	hi jsException				ctermfg=196		cterm=bold
	hi jsTry					ctermfg=196		cterm=bold
	hi jsFinally				ctermfg=196		cterm=bold
	hi jsCatch					ctermfg=196		cterm=bold
	hi jsAsyncKeyword			ctermfg=208		cterm=bold
	hi jsForAwait				ctermfg=208		cterm=bold
	hi jsArrowFunction			ctermfg=74
	hi jsFunction				ctermfg=69		cterm=bold
	hi jsGenerator				ctermfg=208		cterm=bold
	hi jsArrowFuncArgs			ctermfg=254
	hi jsFuncName				ctermfg=254
	hi jsFuncCall				ctermfg=254
	hi jsClassFuncName			ctermfg=254
	hi jsObjectFuncName			ctermfg=254
	hi jsArguments				ctermfg=254
	hi jsError					ctermbg=197
	hi jsParensError			ctermbg=197
	hi jsOperatorKeyword		ctermfg=247		cterm=bold
	hi jsOperator				ctermfg=247
	hi jsOf						ctermfg=14		cterm=none
	hi jsStorageClass			ctermfg=69		cterm=bold
	hi jsClassKeyword			ctermfg=205		cterm=bold
	hi jsExtendsKeyword			ctermfg=247		cterm=bold
	hi jsThis					ctermfg=205
	hi jsSuper					ctermfg=205
	hi jsNan					ctermfg=46
	hi jsNull					ctermfg=46
	hi jsUndefined				ctermfg=49
	hi jsNumber					ctermfg=46
	hi jsFloat					ctermfg=46
	hi jsBooleanTrue			ctermfg=49
	hi jsBooleanFalse			ctermfg=49
	hi jsObjectColon			ctermfg=247
	hi jsNoise					ctermfg=247
	hi jsDot					ctermfg=247
	hi jsBrackets				ctermfg=74
	hi jsParens					ctermfg=74
	hi jsBraces					ctermfg=74
	hi jsFuncBraces				ctermfg=74
	hi jsFuncParens				ctermfg=74
	hi jsClassBraces			ctermfg=74
	hi jsClassNoise				ctermfg=247
	hi jsIfElseBraces			ctermfg=74
	hi jsTryCatchBraces			ctermfg=74
	hi jsModuleBraces			ctermfg=74
	hi jsObjectBraces			ctermfg=247
	hi jsObjectSeparator		ctermfg=247
	hi jsFinallyBraces			ctermfg=74
	hi jsRepeatBraces			ctermfg=74
	hi jsSwitchBraces			ctermfg=74
	hi jsSpecial				ctermfg=99
	hi jsTemplateBraces			ctermfg=99
	hi jsGlobalObjects			ctermfg=118		cterm=underline
	hi jsGlobalNodeObjects		ctermfg=14		cterm=bold
	hi jsExceptions				ctermfg=196
	hi jsBuiltins				ctermfg=118		cterm=underline
	hi jsImport					ctermfg=14		cterm=bold
	hi jsExport					ctermfg=14		cterm=bold
	hi jsExportDefault			ctermfg=208
	hi jsExportDefaultGroup		ctermfg=208
	hi jsModuleAs				ctermfg=247
	hi jsModuleComma			ctermfg=247
	hi jsModuleAsterisk			ctermfg=208
	hi jsFrom					ctermfg=14
	hi jsDecorator				ctermfg=172
	hi jsDecoratorFunction		ctermfg=172
	hi jsParensDecorator		ctermfg=172
	hi jsFuncArgOperator		ctermfg=247
	hi jsFuncArgCommas			ctermfg=247
	hi jsClassProperty			ctermfg=247
	hi jsObjectShorthandProp	ctermfg=247
	hi jsSpreadOperator			ctermfg=247
	hi jsRestOperator			ctermfg=247
	hi jsRestExpression			ctermfg=254
	hi jsSwitchColon			ctermfg=247
	hi jsClassMethodType		ctermfg=208		cterm=bold
	hi jsObjectMethodType		ctermfg=208		cterm=bold
	hi jsClassDefinition		ctermfg=205		cterm=bold
	hi jsBlockLabel				ctermfg=202
	hi jsBlockLabelKey			ctermfg=202

	hi jsDestructuringBraces		ctermfg=74
	hi jsDestructuringProperty		ctermfg=254
	hi jsDestructuringAssignment	ctermfg=254
	hi jsDestructuringNoise			ctermfg=247

	" hi jsCommentFunction
	" hi jsCommentClass
	" hi jsCommentIfElse
	" hi jsCommentRepeat

	" hi jsDomErrNo
	" hi jsDomNodeConsts
	" hi jsDomElemAttrs
	" hi jsDomElemFuncs

	" hi jsHtmlEvents
	" hi jsHtmlElemAttrs
	" hi jsHtmlElemFuncs

	" hi jsCssStyles

	" Snip

	inor <C-\>cl console.log()<Left>
	
	" Coc
	
	nnor <F2> :CocCommand document.renameCurrentWord<CR>
endf

" Git Commit

fun! GitCommit()
	" Snip

	inor \vt VER <C-R>=strftime("%y%m%d")<CR>
endf

" Log Port

fun! L_Port()
	" Syntax & Highlight
	sy clear
	sy match PortType	/\(^\[\)\@<=[\/>*]\(]\)\@=/
	sy match PortNo		/\(^\[[\/>*]] \)\@<=\d\+/

	hi PortType			ctermfg=Yellow
	hi PortNo			ctermfg=LightGreen
endf

" Vundle

set rtp+=$VIMFILES/bundle/Vundle.vim
cal vundle#begin(expand('$VIMFILES/bundle'))

Plugin 'VundleVim/Vundle.vim'

Plugin 'Shougo/vimproc.vim'

Plugin 'rust-lang/rust.vim'
Plugin 'wavded/vim-stylus'
Plugin 'pangloss/vim-javascript'
" Plugin expand('file://$FK/_/FkVim'), { 'name': 'FkVim-javascript', 'rtp': 'javascript/' }
Plugin expand('file://$FK/_/FkVim'), { 'name': 'FkVim-sh', 'rtp': 'sh/' }

Plugin 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plugin 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 1

Plugin 'Chiel92/vim-autoformat'

Plugin 'congma/vim-fakeclip' " kana/~ doesn't work on x11
let g:fakeclip_provide_clipboard_key_mappings = 1

call vundle#end()

filetype plugin indent on

" Utility

fun! _space(s, n)
	retu a:s . repeat(' ', a:n - strlen(a:s))
endfun

fun! _umap(id, act, mode, opt = {})
	let o = a:opt
	
	if ! exists('s:umap_dict[a:id]')
		if exists('o.necessary')
			throw '_umap: map id `' . a:id . '` is empty.'
		endif
		retu
	endif

	let cmd = (exists('o.recusive') ? 'map' : 'nor') . ' ' .
			\ (exists('o.global') ? '' : '<buffer> ') .
			\ (exists('o.silent') ? '<silent> ' : '') .
			\ s:umap_dict[a:id] . ' '
	
	exe a:mode[0] . cmd . a:act

	if	a:mode == "ni"
		exe 'i' . cmd . '<ESC>' . a:act . 'a'
	endif
endfun

