#!/bin/bash

# Kill all gocode servers before updating or emacs may have a weird
# hanging issue when you try to autocomplete
kill -9 $(ps ax | grep gocode | awk '{print $1}') > /dev/null 2>&1
echo -n '.'

go get -u golang.org/x/tools/cmd/goimports
echo -n '.'
go get -u golang.org/x/tools/cmd/gorename
echo -n '.'
go get -u github.com/sqs/goreturns
echo -n '.'
go get -u github.com/nsf/gocode
echo -n '.'
go get -u github.com/alecthomas/gometalinter
echo -n '.'
go get -u github.com/zmb3/gogetdoc
echo -n '.'
go get -u github.com/rogpeppe/godef
echo -n '.'
go get -u golang.org/x/tools/cmd/guru
echo -n '.'
go get -u github.com/golang/lint/golint
echo -n '.'
