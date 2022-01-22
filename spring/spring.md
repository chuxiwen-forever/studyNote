# Spring



## 1、配置maven



> 父项目

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.xi</groupId>
    <artifactId>spring</artifactId>
    <packaging>pom</packaging>
    <version>1.0-SNAPSHOT</version>
    <modules>
        <module>spring-01</module>
    </modules>

    <properties>
        <maven.compiler.source>8</maven.compiler.source>
        <maven.compiler.target>8</maven.compiler.target>
    </properties>

    <dependencies>
        <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-webmvc</artifactId>
            <version>5.3.5</version>
        </dependency>
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <version>1.18.20</version>
        </dependency>
    </dependencies>
</project>
```

> 子项目

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <artifactId>spring</artifactId>
        <groupId>com.xi</groupId>
        <version>1.0-SNAPSHOT</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>

    <artifactId>spring-01</artifactId>

    <properties>
        <maven.compiler.source>8</maven.compiler.source>
        <maven.compiler.target>8</maven.compiler.target>
    </properties>

</project>
```

## 2、创建项目文件



> 在resources包中创建beans.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:p="http://www.springframework.org/schema/p"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
    http://www.springframework.org/schema/beans/spring-beans-3.2.xsd">
    <!-- 由 Spring容器创建该类的实例对象 -->

    <beans>
        <!--id 为调用方法的字符串 class为具体类-->
        <bean id="user" class="com.xi.pojo.User">
            <!--name 为成员变量   value为传入普通变量 ref为传入一个类-->
            <property name="name" value="xi" />
        </bean>
    </beans>
</beans>
```



> 在java包中创建具体类

**使用Lombok插件**

```java
package com.xi.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private String name;
    public void print(){
        System.out.println("666");
    }
}
```

==注:在idea中开启Annotation服务（注解服务)：==

Setting-->搜索Annotation-->开启Enable annotation processing

> 在text文件夹下的java中测试

**可以使用junit 或者直接main方法执行**

```java
import com.xi.pojo.User;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Mytext {
    public static void main(String[] args) {
        //加载资源文件
       ApplicationContext context = new ClassPathXmlApplicationContext("beans.xml");
        //在beans中获取对象
        User name = (User) context.getBean("user");
        //使用对象执行方法
        name.print();
    }
}

```











## Spring中的注解



> @Autowired :自动装配 通过类型 然后是名字(set后面字母，全小写) setName-->寻找name
>
> 如果不能唯一自动匹配装配这个属性，需要通过@Qualifier(value="xxx")





> @Resource  javax包下的注解  先通过名字进行匹配，再通过类型装配
>
> 如果有多个相同的类型，且没有set后的名字，就会无法装配







> @Component  放在实体类上，说明这个类已经被管理了
>
> 等同于   <bean id="user" class="全称类名"/>

~~~shell
@Component的衍生注解   在mvc三层架构中分层
dao 层 ： @Repository
service 层 : @Service
Controller 层 ： @Controller
~~~







> @Value("xxxx")  放在成员变量上 ，装配时给类赋值
>
> 等同于  <constructor-arg name="name" value="xxxx"/>  有参装配
>
> <property name = "name" value="xxxx"/>  无参构造











>@Scope("xx")  作用域   xx:  < singleton :单例模式  prototype:普通模式>