module imooc.com/user

go 1.16

require (
	github.com/golang/protobuf v1.5.2
	github.com/jinzhu/gorm v1.9.16
	github.com/micro/go-micro v1.18.0
	golang.org/x/crypto v0.0.0-20200728195943-123391ffb6de
)

replace github.com/micro/go-micro => github.com/Lofanmi/go-micro v1.16.1-0.20210804063523-68bbf601cfa4

replace (
	github.com/golang/protobuf => github.com/golang/protobuf v1.3.2
	google.golang.org/genproto => google.golang.org/genproto v0.0.0-20191216164720-4f79533eabd1
	google.golang.org/grpc v1.30.0 => google.golang.org/grpc v1.26.0
	google.golang.org/protobuf => google.golang.org/protobuf v1.25.0
)

require (
	github.com/coreos/etcd v3.3.18+incompatible // indirect
	github.com/golang/groupcache v0.0.0-20200121045136-8c9f03a8e57e // indirect
	github.com/google/btree v1.0.0 // indirect
	github.com/grpc-ecosystem/grpc-gateway v1.9.5 // indirect
	github.com/json-iterator/go v1.1.9 // indirect
	github.com/lib/pq v1.3.0 // indirect
	github.com/lucas-clemente/quic-go v0.25.0 // indirect
	github.com/miekg/dns v1.1.27 // indirect
	github.com/nats-io/nats-server/v2 v2.1.6 // indirect
	github.com/pkg/errors v0.9.1 // indirect
	github.com/tmc/grpc-websocket-proxy v0.0.0-20200122045848-3419fae592fc // indirect
	go.uber.org/zap v1.13.0 // indirect
	golang.org/x/lint v0.0.0-20191125180803-fdd1cda4f05f // indirect
	golang.org/x/time v0.0.0-20191024005414-555d28b269f0 // indirect
	google.golang.org/genproto v0.0.0-20191216164720-4f79533eabd1 // indirect
	google.golang.org/grpc v1.26.0 // indirect
)
