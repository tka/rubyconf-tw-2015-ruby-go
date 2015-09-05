package main

import (
	"C"
	"golang.org/x/text/language"
	"log"
)

var (
	mather = language.NewMatcher([]language.Tag{language.Make("en"), language.Make("ja"), language.Make("zh-TW"), language.Make("zh-CN")})
)

//export preferredLanguageFrom
func preferredLanguageFrom(httpAcceptLanguage *string) *string {

	tag, _, _ := language.ParseAcceptLanguage(*httpAcceptLanguage)
	t, _, _ := mather.Match(tag...)
	l := t.String()
	return &l
}

//export preferredLanguageFromUseCString
func preferredLanguageFromUseCString(cHttpAcceptLanguage *C.char) *C.char {
	httpAcceptLanguage := C.GoString(cHttpAcceptLanguage)

	tag, _, _ := language.ParseAcceptLanguage(httpAcceptLanguage)
	t, _, _ := mather.Match(tag...)
	return C.CString(t.String())
}

func init() {
	log.Println("Loaded!!")
}

func main() {
}
