module imooc.com/category

go 1.16

require (
	github.com/golang/protobuf v1.5.2
	github.com/jinzhu/gorm v1.9.16
	github.com/micro/go-micro v1.18.0
	github.com/micro/go-plugins/config/source/consul v2.0.0
	github.com/micro/go-plugins/registry/consul v2.0.0 // indirect
	github.com/prometheus/common v0.6.0
)

replace github.com/micro/go-micro => github.com/Lofanmi/go-micro v1.16.1-0.20210804063523-68bbf601cfa4

//replace (
//	github.com/micro/go-plugins/config/source/consul  => github.com/micro/go-plugins/config/source/consul v2.19.1
//	github.com/micro/go-plugins/registry/consul => github.com/micro/go-plugins/registry/consul v2.19.1
//)