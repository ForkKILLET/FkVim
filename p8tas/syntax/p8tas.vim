if exists("b:current_syntax")
	finish
end

syn keyword	p8tasIns ins log keydown keyup wait
syn match	p8tasNum "\<\d\+\>"
syn keyword p8tasKey Dash Jump Up Down Left Right

hi link p8tasIns Keyword
hi link p8tasNum Number
hi link p8tasKey String
