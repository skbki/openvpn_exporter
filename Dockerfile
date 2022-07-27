FROM golang:1.18 as build

WORKDIR /go/src/openvpn_exporter
COPY . .

RUN go mod download
RUN CGO_ENABLED=0 go build -i -v -o /go/bin/openvpn_exporter ./cmd/openvpn_exporter

FROM gcr.io/distroless/static-debian11
COPY --from=build /go/bin/openvpn_exporter /
EXPOSE 9176
CMD ["/openvpn_exporter"]