FROM golang:1.11 as builder

RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

WORKDIR  /go/src/github.com/horis233/kubelet-server-csr-approver

# Add dependency graph and vendor it in
ADD Gopkg.* /go/src/github.com/horis233/kubelet-server-csr-approver/
RUN dep ensure -v -vendor-only

# Add source and compile
ADD . /go/src/github.com/horis233/kubelet-server-csr-approver/
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o csr-approver cmd/manager/main.go


FROM scratch

COPY --from=builder /go/src/github.com/horis233/kubelet-server-csr-approver/csr-approver /csr-approver

ENTRYPOINT ["/csr-approver", "-logtostderr"]