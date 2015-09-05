package main

import (
	"C"
)

// 這邊要特別指定
//export add
func add(x int, y int) int {
	return x + y
}

func init() {
}

func main() {
}
