# MySql



## 1、下载和配置mysql



> 下载mysql-8.0.24.zip

**下载zip不下载exe版本是因为exe过于麻烦**

~~~sh
下载网址：https://dev.mysql.com/downloads/mysql/
~~~

![download.png](C:\study\mysql\picture\download.png)

> 下载压缩包后，解压到一个定义好的文件夹中

![pas.png](C:\study\mysql\picture\pas.PNG)



> 定义mysql环境变量

1.复制mysql目录bin的路径

![](C:\study\mysql\picture\lujin.png)

2.此电脑-->属性-->高级系统配置-->环境变量-->path

![](C:\study\mysql\picture\ppp.png)

1（添加）-->2(将bin路径添加到系统变量中)-->3(确定)

![](C:\study\mysql\picture\ppp2.png)



> 配置ini文件

1、在根目录下新建一个txt文件，把名字改成my，再将.txt文件名改成.ini

2、配置ini文件

~~~sh
[mysqld]
port=3306   //端口号
basedir=D:\Mysql\mysql-8.0.24-winx64   //根目录路径
datadir=D:\Mysql\mysql-8.0.24-winx64\data  //数据库存放路径，data是根据ini文件生成的
~~~

![](C:\study\mysql\picture\223552.png)

![](C:\study\mysql\picture\223801.png)

**注：date是执行下面过程出来生成的，一开始没有**



> 在命令行 (用管理员身份打开cmd) 执行以下代码      配置数据库

1、cd /d D:\Mysql\mysql-8.0.24-winx64\bin

![](C:\study\mysql\picture\0.PNG)

2、mysqld -install

![](C:\study\mysql\picture\1.PNG)

**注：如果出现以上问题，说明已经注册过数据库，可以执行2.2进行解决**

**2.2 没错误不用执行**

sc query mysql

sc delete mysql

![](C:\study\mysql\picture\2.PNG)

![](C:\study\mysql\picture\3.PNG)

然后重新执行2 mysqld -install

![](C:\study\mysql\picture\4.PNG)

**注：如果一开始就报Service successfully installed,就不用执行2.2**

3、mysqld --initialize-insecure --user=mysql（根据my.ini配置文件）

**前面的data文件夹就是这一步生成的**

4、net start mysql (启动mysql服务)

![](C:\study\mysql\picture\5.PNG)

5、mysql -u root -p （配置用户名）

![](C:\study\mysql\picture\6.PNG)

6、set password ='123456'; （sql语句设定密码）

![](C:\study\mysql\picture\7.PNG)

7、flush privileges; （刷新权限）

![](C:\study\mysql\picture\8.PNG)

8、重启mysql：

exit

net stop mysql

net start mysql

![](C:\study\mysql\picture\9.PNG)

9、再次登录就可以用用户名和密码登录了！

![](C:\study\mysql\picture\10.PNG)



> 图形化界面设计(SQLyog)

~~~sh
下载网站：(破解版)https://www.cr173.com/soft/126913.html
~~~

1、

![](C:\study\mysql\picture\5736.png)

![](C:\study\mysql\picture\5813.png)

**注：已经踩坑！没有恶意绑定软件**

==因为是exe文件，剩下的是一路next，不说了==

2、连接本地数据库会出现

**plugin 'caching_sha2_password' cannot be loaded**的问题

![](C:\study\mysql\picture\230423.png)

**解决办法：**

（1）在cmd中操作登录数据库

![](C:\study\mysql\picture\10.PNG)

（2）

~~~sh
1.ALTER USER 'root'@'localhost' IDENTIFIED BY 'password' PASSWORD EXPIRE NEVER; #修改加密规则

2.ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password'; #更新一下用户的密码  2中'password'中的password是自己自定义的密码

~~~

（3）刷新权限

```sh
flush privileges;
```

（4）重新打开SQLyog就可以正常连接了！！！



## 2、连接数据库



~~~sql
mysql -uroot -p123456  --123456是我的密码，输入自己的密码

show databases;  --查看所有的数据库

use 数据库名字;   --切换数据库
例如：use db3;

show tables;  --查看数据库中所有的表

desc 表名;  --查询表结构

create database 数据库名字;  --创建数据库

exit; --退出连接
~~~

## 3、SQL语句



==**注：下面所有的[ ]里的都是可选操作，不加可能会报warning，但不影响操作**==

### 3.1、 操作数据库

> 创建数据库

```sql
create database [if not exists] 数据库名称; --[如果不存在（这个数据库）]就创建数据库
```

> 删除数据库

```sql
drop database [if exists] 数据库名称;  --[如果存在（这个数据库）]就删除数据库
```

> 使用数据库

```sql
use 数据库名称; 
```

> 查看所有的数据库

```sql
show databases;
```

