package main

import (
	"C"
	"reflect"
	"unsafe"
)

//export sum
func sum(cArray unsafe.Pointer, length int) int {
	hdr := reflect.SliceHeader{Data: uintptr(cArray), Len: length, Cap: length}
	data := *(*[]int)(unsafe.Pointer(&hdr))
	s := 0
	for _, i := range data {
		s = s + i
	}
	return s
}

func main() {
}
