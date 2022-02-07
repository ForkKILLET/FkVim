" Chore

if !exists("main_syntax")
  " quit when a syntax file was already loaded
  if exists("b:current_syntax")
    finish
  endif
  let main_syntax = 'javascript'
elseif exists("b:current_syntax") && b:current_syntax == "javascript"
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Syntax
setl iskeyword+=$

sy clear
sy sync fromstart

sy match	javaScriptShebang               "^#!.*"

sy keyword 	javaScriptModule                import export as from
sy keyword 	javaScriptCommonModule          module exports require

sy keyword 	javaScriptDefine                let const var
sy keyword 	javaScriptDefineOK		        resolve then res
sy keyword 	javaScriptDefineException       reject error err rej

sy keyword 	javaScriptAsync                 yield async await
sy keyword 	javaScriptClass                 class constructor get set static extends
sy keyword 	javaScriptScope                 this that super global window arguments prototype
sy keyword 	javaScriptGlobalObjects         Array Boolean Date Function Math JSON Number Object RegExp String Symbol Promise Reflect Proxy
sy keyword 	javaScriptGlobalLiteral         NaN Infinity

sy keyword 	javaScriptOperatorKeyword       delete new instanceof typeof void
sy match   	javaScriptOperatorSymbol        "[+\-*/%@#\^~|&.?:=<>,;]\+"

sy keyword 	javaScriptBoolean               true false
sy keyword 	javaScriptNull                  null undefined

sy keyword 	javaScriptConditional           if else switch
sy keyword 	javaScriptRepeat                do while for in of
sy keyword 	javaScriptControl               break continue return with
sy keyword 	javaScriptExceptions            try catch throw finally Error EvalError RangeError ReferenceError SyntaxError TypeError URIError
sy keyword 	javaScriptLabel                 case default

sy keyword 	javaScriptDebug                 console debugger

sy keyword 	javaScriptCommentTodo           TODO FIXME XXX contained
sy match   	javaScriptCommentLine           "\/\/.*" contains=@Spell,javaScriptCommentTodo
sy match   	javaScriptCommentSkip           "^[ \t]*\*\($\|[ \t]\+\)"
sy region  	javaScriptComment               start="/\*"  end="\*/" contains=@Spell,javaScriptCommentTodo

sy match   	javaScriptSpecial               "\\\d\d\d\|\\."
sy region  	javaScriptString                start=+"+  skip=+\\\\\|\\"+  end=+"\|$+	contains=javaScriptSpecial,@htmlPreproc
sy region  	javaScriptString                start=+'+  skip=+\\\\\|\\'+  end=+'\|$+	contains=javaScriptSpecial,@htmlPreproc
sy region  	javascriptTemplate              start=/`/  skip=/\\\\\|\\`\|\n/  end=/`\|$/ contains=javascriptTemplateSubstitution nextgroup=@javascriptComments,@javascriptSymbols skipwhite skipempty
sy region  	javascriptTemplateSubstitution  matchgroup=javascriptTemplateSB contained start=/\(\\\)\@<!\${/ end=/}/ contains=@javascriptExpression

sy match   	javaScriptSpecialCharacter      "'\\.'"
sy match   	javaScriptNumber                "-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>\|0[b]"
sy region  	javaScriptRegexpString          start=+/[^/*]+me=e-1 skip=+\\\\\|\\/+ end=+/[gim]\{0,2\}\s*$+ end=+/[gim]\{0,2\}\s*[;.,)\]}]+me=e-1 contains=@htmlPreproc oneline
sy match   	javaScriptFloat                 /[+-]\?\(\([1-9]\d*\|0\)\?\.\d\+\([Ee][+-]\?\d\+\)\?\|\([1-9]\d*\|0\)[Ee][+-]\?\d\+\)/
sy match   	javascriptDollar                "\$"

sy cluster 	javaScriptAll                   contains=javaScriptComment,javaScriptLineComment,javaScriptDocComment,javaScriptString,javaScriptRegexpString,javascriptTemplate,javaScriptNumber,javaScriptFloat,javascriptDollar,javaScriptLabel,javaScriptSource,javaScriptWebAPI,javaScriptOperator,javaScriptBoolean,javaScriptNull,javaScriptFuncKeyword,javaScriptConditional,javaScriptRepeat,javaScriptBranch,javaScriptStatement,javaScriptGlobalObjects,javaScriptMessage,javaScriptIdentifier,javaScriptExceptions,javaScriptReserved,javaScriptDeprecated,javaScriptDomErrNo,javaScriptDomNodeConsts,javaScriptHtmlEvents,javaScriptDotNotation,javaScriptBrowserObjects,javaScriptDOMObjects,javaScriptAjaxObjects,javaScriptPropietaryObjects,javaScriptDOMMethods,javaScriptHtmlElemProperties,javaScriptDOMProperties,javaScriptEventListenerKeywords,javaScriptEventListenerMethods,javaScriptAjaxProperties,javaScriptAjaxMethods,javaScriptFuncArg

sy keyword 	javaScriptFuncKeyword           function contained
sy region  	javaScriptFuncExp               start=/\w\+\s\==\s\=function\>/ end="\([^)]*\)" contains=javaScriptFuncEq,javaScriptFuncKeyword,javaScriptFuncArg keepend
sy match   	javaScriptFuncArg               "\(([^()]*)\)" contains=javaScriptParens,javaScriptFuncComma contained
sy match   	javaScriptFuncComma             /,/ contained
sy match   	javaScriptFuncEq                /=/ contained
sy region  	javaScriptFuncDef               start="\<function\>" end="\([^)]*\)" contains=javaScriptFuncKeyword,javaScriptFuncArg keepend

sy match   	javaScriptBraces                "[{}\[\]]"
sy match   	javaScriptParens                "[()]"
sy match   	javaScriptOperatorSymbolLogic   "\(&&\)\|\(||\)\|\(!\)"

sy keyword 	javaScriptFkUtilAPI				Is Cc ski exTemplate Logger serialize sleep ajax
sy keyword 	javaScriptFkUtilConst           EF

sy cluster  htmlJavaScript                  contains=@javaScriptAll,javaScriptBracket,javaScriptParen,javaScriptBlock,javaScriptParenError
sy cluster  javaScriptExpression            contains=@javaScriptAll,javaScriptBracket,javaScriptParen,javaScriptBlock,javaScriptParenError,@htmlPreproc

sy match	javascriptTrailingSpace			/[ \t]\+$/

let b:current_syntax = "javascript"
if main_syntax == 'javascript'
  unlet main_syntax
endif
let &cpo = s:cpo_save
unlet s:cpo_save


