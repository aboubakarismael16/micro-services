### 课程中的 
git.imooc.com/`cap1573`/user 
需要更改为 
git.imooc.com/`coding-447`/user
# User Service

This is the User service

Generated with

```
micro new user
```

## Getting Started

- [Configuration](#configuration)
- [Dependencies](#dependencies)
- [Usage](#usage)

## Configuration

- Alias: user

## Dependencies

Micro services depend on service discovery. The default is multicast DNS, a zeroconf system.

In the event you need a resilient multi-host setup we recommend etcd.

```
# install etcd
brew install etcd

# run etcd
etcd
```

## Usage

A Makefile is included for convenience

Build the binary

```
make build
```

Run the service
```
./user
```

Build a docker image
```
make docker
```

## Debug

### 修复 go-micro 框架在高版本 Go 编译的运行时错误
公司大量使用微服务框架 go-micro，但框架作者已不再维护低版本（新版本已经商业化），只能自己动手了。

起因是我用 Go 1.16 编译，启动报错：
```go
panic: qtls.ConnectionState not compatible with tls.ConnectionState

goroutine 1 [running]:
github.com/lucas-clemente/quic-go/internal/handshake.init.0()
        /go/pkg/mod/github.com/lucas-clemente/quic-go@v0.12.1/internal/handshake/unsafe.go:17 +0x118
```

跟进去看：
```go
func init() {
    if !structsEqual(&tls.ConnectionState{}, &qtls.ConnectionState{}) {
        panic("qtls.ConnectionState not compatible with tls.ConnectionState")
    }
    if !structsEqual(&tls.ClientSessionState{}, &qtls.ClientSessionState{}) {
        panic("qtls.ClientSessionState not compatible with tls.ClientSessionState")
    }
}
```

发现 tls.ConnectionState 在是标准库的包 crypto/tls，也就是说，新版本的 Go 标准库的定义，和 github.com/marten-seemann/qtls 不兼容。
公司使用 Go 1.14 编译，程序是正常运行的。


[https://github.com/Lofanmi/go-micro/commit/68bbf601cfa46b0c49c67f51e4e38e6a6f029f42](https://github.com/Lofanmi/go-micro/commit/68bbf601cfa46b0c49c67f51e4e38e6a6f029f42)
[https://blog.csdn.net/Xiang_lhh/article/details/113814742](https://blog.csdn.net/Xiang_lhh/article/details/113814742)
[https://www.jianshu.com/p/253d08c50c44](https://www.jianshu.com/p/253d08c50c44)
[https://imlht.com/archives/239/](https://imlht.com/archives/239/)


### 用法很简单，直接 replace 掉就 OK 了！

```go
replace (
    github.com/micro/go-micro => github.com/Lofanmi/go-micro v1.16.1-0.20210804063523-68bbf601cfa4
)
```

如果还不行，再 replace 掉下面的包：
```go
replace (
    github.com/golang/protobuf => github.com/golang/protobuf v1.3.2
    google.golang.org/genproto => google.golang.org/genproto v0.0.0-20191216164720-4f79533eabd1
    google.golang.org/grpc v1.30.0 => google.golang.org/grpc v1.26.0
    google.golang.org/protobuf => google.golang.org/protobuf v1.25.0
)
```
上面四个 replace 是工程内其他依赖的，我没办法测试只替换 go-micro 是否可以解决问题，所以也贴在这里，需要请自取哈。

