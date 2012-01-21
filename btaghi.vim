function! HiTag()
	" save cursor position
	let l:saved_cursor_pos = getpos(".")

	let l:start_tag = []
	execute("normal! yat")
	call add(start_tag, getpos(".")[2])
	call add(start_tag, getpos(".")[1])

	execute("normal! f>")
	call add(start_tag, getpos(".")[2])
	call add(start_tag, getpos(".")[1])


	let l:end_tag = []
	execute("normal! vat\e")

	execute("normal! F<")
	call add(end_tag, getpos(".")[2])
	call add(end_tag, getpos(".")[1])

	execute("normal! f>")
	call add(end_tag, getpos(".")[2])
	call add(end_tag, getpos(".")[1])

	"echo start_tag
	"echo end_tag

	call clearmatches()
	highlight TagHi guifg=#ffff00 
	call matchadd("TagHi", "\\%" . start_tag[1] . "l\\%>" . (start_tag[0]-1) . "c\\%<" . (start_tag[2]+1) . "c")
	call matchadd("TagHi", "\\%" . end_tag[1] . "l\\%>" . (end_tag[0]-1) . "c\\%<" . (end_tag[2]+1) . "c")

	" restore cursor position
	call setpos(".", l:saved_cursor_pos)

endfunction
