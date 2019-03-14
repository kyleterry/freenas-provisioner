ARG GOLANG_BASE=${GOLANG_BASE:-golang:1.12-alpine}
ARG TARGET=${TARGET:-alpine}
FROM ${GOLANG_BASE} as builder
ARG ARCH=${ARCH:-amd64}
ARG OS=${OS:-linux}
RUN apk --no-cache add make git gcc bind-dev musl-dev 
WORKDIR /go/src/freenas-provisioner
COPY . .
ENV GO111MODULE on
RUN go get ./...
RUN echo ${ARCH}
RUN GOOS=${OS} GOARCH=${ARCH} CGO_ENABLED=0 go build -a --installsuffix cgo --ldflags="-s" ./cmd/freenas-provisioner

FROM ${TARGET}
COPY --from=builder /go/src/freenas-provisioner/freenas-provisioner /freenas-provisioner
ENTRYPOINT ["/freenas-provisioner"]
