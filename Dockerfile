FROM golang:latest AS builder

RUN go get -d -v github.com/google/go-jsonnet/cmd/jsonnetfmt
RUN go install -v github.com/google/go-jsonnet/cmd/jsonnetfmt

FROM opensuse/leap:latest AS runner

RUN zypper --non-interactive install git-core

COPY --from=builder /go/bin/jsonnetfmt /usr/local/bin/jsonnetfmt
COPY entrypoint.bash /entrypoint.bash

ENTRYPOINT ["bash", "/entrypoint.bash"]