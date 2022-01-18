package main

import (
	"github.com/jinzhu/gorm"
	"github.com/micro/go-micro"
	log "github.com/micro/go-micro/logger"
	"github.com/micro/go-micro/plugins/registry/consul"
	"github.com/micro/go-micro/registry"
	"imooc.com/category/common"
	"imooc.com/category/domain/repository"
	service2 "imooc.com/category/domain/service"
	"imooc.com/category/handler"

	_ "github.com/jinzhu/gorm/dialects/mysql"

	category "imooc.com/category/proto/category"
)

func main() {
	//配置中心
	consulConfig,err := common.GetConsulConfig("127.0.0.1",8500,"/micro/config")
	if err !=nil {
		log.Error(err)
	}
	//注册中心
	consulRegistry := consul.NewRegistry(func(options *registry.Options) {
		options.Addrs = []string{
			"127.0.0.1:8500",
		}
	})

	// New Service
	service := micro.NewService(
		micro.Name("imooc.com/category"),
		micro.Version("latest"),
		//这里设置地址和需要暴露的端口
		micro.Address("127.0.0.1:8082"),
		//添加consul 作为注册中心
		micro.Registry(consulRegistry),
	)

	//获取mysql配置,路径中不带前缀
	mysqlInfo := common.GetMysqlFromConsul(consulConfig,"mysql")

	//连接数据库
	//db,err :=gorm.Open("mysql","root:13628@/micro?charset=utf8&parseTime=True&loc=Local")
	db,err := gorm.Open("mysql",mysqlInfo.User+":"+mysqlInfo.Pwd+"@/"+mysqlInfo.Database+"?charset=utf8&parseTime=True&loc=Local")
	if err !=nil {
		log.Error(err)
	}
	defer db.Close()
	//禁止复表
	db.SingularTable(true)


	rp := repository.NewCategoryRepository(db)
	rp.InitTable()
	// Initialise service
	service.Init()

	categoryDataService := service2.NewCategoryDataService(repository.NewCategoryRepository(db))

	 err = category.RegisterCategoryHandler(service.Server(),&handler.Category{CategoryDataService:categoryDataService})
	 if  err != nil {
	 	log.Error(err)
	 }

	// Run service
	if err := service.Run(); err != nil {
		log.Fatal(err)
	}
}
