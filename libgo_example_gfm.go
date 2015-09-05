package main

import (
	"C"
	"github.com/russross/blackfriday"
	"github.com/shurcooL/github_flavored_markdown"
)

//export gfm
func gfm(text *C.char) *C.char {
	mdString := C.GoString(text)
	result := github_flavored_markdown.Markdown([]byte(mdString))
	return C.CString(string(result))
}

//export md
func md(text *C.char) *C.char {
	mdString := C.GoString(text)
	result := blackfriday.MarkdownCommon([]byte(mdString))
	return C.CString(string(result))
}
func main() {}
