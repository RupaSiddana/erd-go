all: build

build_no_peg: depend bindata
	go build

build: depend peg bindata
	go build -mod=readonly

peg:
	peg erd.peg

run: build
	cat examples/nfldb.er | ./erd-go -o nfldb.dot

depend:
	go mod download

bindata:
	go-bindata -o=templates_bindata.go ./templates/...

examples: build
	cat examples/simple.er | ./erd-go -o examples/outputs/simple.dot
	cat examples/simple.er | ./erd-go | dot -Tpng -o examples/outputs/simple.png
	cat examples/nfldb.er | ./erd-go -o examples/outputs/nfldb.dot
	cat examples/nfldb.er | ./erd-go | dot -Tpng -o examples/outputs/nfldb.png
