FROM opensuse/leap:15.2 AS builder

RUN zypper --non-interactive addrepo --no-gpgcheck \
    https://download.opensuse.org/repositories/devel:languages:go/openSUSE_Leap_15.2/devel:languages:go.repo
RUN zypper --non-interactive refresh
RUN zypper --non-interactive install git go1.15
RUN GOPATH=/opt/go go get -v github.com/google/go-jsonnet/cmd/jsonnetfmt

FROM opensuse/leap:latest AS runner

COPY --from=builder /opt/go/bin/jsonnetfmt /usr/local/bin/jsonnetfmt

COPY entrypoint.bash /entrypoint.bash

ENTRYPOINT ["bash", "/entrypoint.bash"]