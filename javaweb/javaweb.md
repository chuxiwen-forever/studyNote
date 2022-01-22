

# JavaWeb



## 1、Tomcat服务器

### 1.1、下载Tomcat

~~~sh
https://tomcat.apache.org/download-90.cgi //官网
~~~

![](C:\学习\javaweb\picture\1.png)

==**注意：10版本与maven不兼容，巨坑爹！！！**==

### 1.2、配置Tomcat

#### 1.2.1、打开Tomcat根目录-->选择conf目录（文件夹)

![](C:\学习\javaweb\picture\2.png)

#### 1.2.2、打开logging.properties

![](C:\学习\javaweb\picture\3.png)

#### 1.2.3、修改编码类型将默认的UTF-8改为GBK

![](C:\学习\javaweb\picture\4.png)

**可以避免出现乱码情况**

#### 1.2.4、退回conf目录，打开server.xml

![](C:\学习\javaweb\picture\5.png)

#### 1.2.5、修改Tomcat管理配置

> 修改连接端口

![](C:\学习\javaweb\picture\6.png)

> 修改连接本地ip映射名

![](C:\学习\javaweb\picture\7.png)

#### 1.2.6、好玩的！！修改本机域名

**System32-->hosts**

![](C:\学习\javaweb\picture\8.png)

![](C:\学习\javaweb\picture\9.png)

**添加本机ip的映射名**

![](C:\学习\javaweb\picture\10.png)

> Tomcat和本机ip映射名调好后

![](C:\学习\javaweb\picture\11.png)

==**强烈建议把Tomcat配置到环境变量中**==

### 1.3、在idea中使用Tomcat

![](C:\学习\javaweb\picture\12.png)

![](C:\学习\javaweb\picture\13.png)

![](C:\学习\javaweb\picture\14.png)

**如果是web项目，点Fix就好了，加入执行类名**





## 2、maven(重点，巨好用)



## 1、下载maven

~~~shell
https://maven.apache.org/    //官网
~~~

![](C:\学习\javaweb\picture\15.png)

~~~shell
maven仓库网址：https://mvnrepository.com/
~~~

**maven仓库可以提供jar包**



## 2、配置maven



> 在根目录创建maven-repo文件夹

**目的：jar包的下载位置**

![](C:\学习\javaweb\picture\19.png)



> 和Tomcat一样，打开conf

![](C:\学习\javaweb\picture\16.png)

> 配置setting.xml文件

**主要两个点**

1.jar包下载位置

![](C:\学习\javaweb\picture\17.png)

~~~xml
 <localRepository>D:\work\apache-maven-3.8.1\maven-repo</localRepository>
~~~



2.更改镜像仓库，可以下载jar包更快，通常为阿里云

![](C:\学习\javaweb\picture\18.png)

```xml
<mirrors>
    <mirror>  
	  <id>alimaven</id>  
	  <mirrorOf>central</mirrorOf>
	  <name>aliyun maven</name>  
	  <url>http://maven.aliyun.com/nexus/content/groups/public</url>;         
	</mirror>
  </mirrors>
```

