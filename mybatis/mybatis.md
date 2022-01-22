# Mybatis



## 1、配置maven

> 父项目

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.xi</groupId>
    <artifactId>mybatis</artifactId>
    <packaging>pom</packaging>
    <version>1.0-SNAPSHOT</version>
    <modules>
        <module>mybatis-01</module>
    </modules>

    <properties>
        <maven.compiler.source>8</maven.compiler.source>
        <maven.compiler.target>8</maven.compiler.target>
    </properties>

    <dependencies>
        <dependency>
            <!---- 导入依赖，在maven仓库中找相关依赖--->
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <version>8.0.24</version>
        </dependency>
        <dependency>
            <groupId>org.mybatis</groupId>
            <artifactId>mybatis</artifactId>
            <version>3.5.2</version>
        </dependency>
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.11</version>
            <scope>test</scope>
        </dependency>
    </dependencies>

    <build>
        <resources>
       <!--加载相关资源文件，主要是src-java包下的资源文件，要不然不会产生class资源文件-->
            <resource>
                <directory>src/main/java</directory>
                <includes>
                    <include>**/*.xml</include>
                </includes>
            </resource>
            <resource>
                <directory>src/main/resources</directory>
                <includes>
                    <include>**/*.properties</include>
                    <include>**/*.xml</include>
                </includes>
            </resource>
        </resources>
    </build>
</project>
```

> 子项目

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <!--可以继承父项目中的依赖-->
        <artifactId>mybatis</artifactId>
        <groupId>com.xi</groupId>
        <version>1.0-SNAPSHOT</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>

    <artifactId>mybatis-01</artifactId>

    <properties>
        <maven.compiler.source>8</maven.compiler.source>
        <maven.compiler.target>8</maven.compiler.target>
    </properties>

</project>
```

## 2、配置配置文件



> 在resource目录下创建db.properties

```properties
driver=com.mysql.cj.jdbc.Driver
username=root
password=123456
url=jdbc:mysql://localhost:3306/db3
```

>在resource目录下创建mybatis-config.xml

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <properties resource="db.properties"/>

    <environments default="development">
        <environment id="development">
            <transactionManager type="JDBC"/>
            <dataSource type="POOLED">
                <property name="driver" value="${driver}"/>
                <property name="url" value="${url}"/>
                <property name="username" value="${username}"/>
                <property name="password" value="${password}"/>
            </dataSource>
        </environment>
    </environments>
    <mappers>
        <!--在mappers中注册下面dao包中的资源文件-->
        <mapper resource="com/xi/dao/UserMapper.xml"/>
    </mappers>
</configuration>
```

## 3、在java文件夹下创建dao包



> 在dao包中书写接口类

```java
package com.xi.dao;

import com.xi.pojo.Users;

import java.util.List;

public interface UserMapper {
    List<Users> getUserList(); //书写方法
    int setUser(Users user);
}

```

> 在dao包配置相关配置文件

==注意:配置文件名和接口类名必须一样==

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.xi.dao.UserMapper">
    <!--id为接口类中方法名,resultType为返回类型--->
    <select id="getUserList" resultType="com.xi.pojo.Users">
        select * from db3.users;
    </select>
    <!--parameterType 为形参类-->
    <insert id="setUser" parameterType="com.xi.pojo.Users">
        <!--#{!name!}为安全注入sql，!name!中为User中的关键字，成员变量名字-->
        insert into db3.users value (#{id},#{user},#{password});
    </insert>
</mapper>
```



## 4、在Java包下创建util包（工具类包）



> 在util包中书写MybatisUtil类



```java
package com.xi.util;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

public class MybatisUtil {
    private static SqlSessionFactory sqlSessionFactory;
    static {
        try {
            //从 XML 中构建 SqlSessionFactory
            String resource = "config.xml";
            InputStream inputStream= Resources.getResourceAsStream(resource);
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    public static SqlSession getSqlSession(){
        return sqlSessionFactory.openSession();
    }
}

```



## 5、在Java包下创建pojo包(存放实体类的包)



> 在pojo包中书写实体类



```java
package com.xi.pojo;

public class Users {
    private int id;
    private String user;
    private String password;

    public Users() {
    }

    public Users(int id, String name, String password) {
        this.id = id;
        this.user = name;
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return user;
    }

    public void setName(String name) {
        this.user = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "Users{" +
                "id=" + id +
                ", name='" + user + '\'' +
                ", password='" + password + '\'' +
                '}';
    }
}

```



> 配置完文件夹目录结构



![mybatis目录结构](C:\学习\mybatis\picture\1.png)



## 6、正片开始