## Perfect-QNSDK


因为最近在使用七牛的OSS上传，但是没提供基于Perfect服务端使用的SDK，所以自己造了一个出来。  

需要依赖[Perfect-Crypto](https://github.com/PerfectlySoft/Perfect-Crypto)



目前只提供了构建上传token的方法  
```
//初始化对象
QNAuth.shared(accessKey: "accessKey", secretKey: "secretKey")


let putPolicy = ["scope": "my-bucket:sunflower.jpg",
"deadline":1451491200,
"returnBody":["name":"$(fname)",
"size":"$(fsize)",
"w":"$(imageInfo.width)",
"h":"$(imageInfo.height)",
"hash":"$(etag)"]] as [String : Any]

//具体putPolicy传什么参数，可以参考七牛的文档https://developer.qiniu.com/kodo/manual/1206/put-policy
let token = QNAuth.token(putPolicy: putPolicy)
```
