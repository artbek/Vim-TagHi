function! HiTag()

	" save cursor position
	let l:saved_cursor_pos = getpos(".")

	let l:opening_tag = []
	" go to opening tag
	execute("normal! yat")
	" get position of brackets < >
	call add(opening_tag, getpos(".")[2])
	call add(opening_tag, getpos(".")[1])
	execute("normal! f>")
	call add(opening_tag, getpos(".")[2])
	call add(opening_tag, getpos(".")[1])

	let l:closing_tag = []
	" go to closing tag
	execute("normal! vat\e")
	" get position of bracket < >
	execute("normal! F<")
	call add(closing_tag, getpos(".")[2])
	call add(closing_tag, getpos(".")[1])
	execute("normal! f>")
	call add(closing_tag, getpos(".")[2])
	call add(closing_tag, getpos(".")[1])

	"echo opening_tag
	"echo closing_tag
	
	" clear previous highlights
	call clearmatches()
	" highlight using the brackets' position data
	highlight TagHi guifg=#ffff00 
	call matchadd("TagHi", "\\%" . opening_tag[1] . "l\\%>" . (opening_tag[0]-1) . "c\\%<" . (opening_tag[2]+1) . "c")
	call matchadd("TagHi", "\\%" . closing_tag[1] . "l\\%>" . (closing_tag[0]-1) . "c\\%<" . (closing_tag[2]+1) . "c")

	" restore cursor position
	call setpos(".", l:saved_cursor_pos)

endfunction
