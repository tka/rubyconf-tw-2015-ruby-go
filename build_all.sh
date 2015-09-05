#!/bin/bash

go build  -buildmode=c-shared -o libgo_example_1.so libgo_example_1.go
go build  -buildmode=c-shared -o libgo_example_2.so libgo_example_2.go
go build  -buildmode=c-shared -o libgo_example_3.so libgo_example_3.go
go build  -buildmode=c-shared -o libgo_example_gc.so libgo_example_gc.go
go build  -buildmode=c-shared -o libgo_example_gfm.so libgo_example_gfm.go
go build  -buildmode=c-shared -o libgo_example_array.so libgo_example_array.go

