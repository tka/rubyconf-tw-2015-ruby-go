package main

import (
	"C"
	"fmt"
	"time"
)

// 這邊要特別指定
//export printTime
func printTime(prefix *C.char) {
	ticker := time.NewTicker(time.Millisecond * 500)
	go func() {
		for t := range ticker.C {
			fmt.Println(C.GoString(prefix), "Tick at", t)
		}
	}()
}

func main() {}
