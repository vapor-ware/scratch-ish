

.PHONY: build
build:
	rm bin/*
	GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -a -installsuffix cgo -ldflags "-w -s" -o bin/exists-pre ./cmd/exists
	docker run --rm -w $$PWD -v $$PWD:$$PWD gruebel/upx:latest --best --lzma -o bin/exists bin/exists-pre
	rm bin/exists-pre

.PHONY: docker
docker: build
	docker build -f Dockerfile -t vaporio/scratch-ish:latest .