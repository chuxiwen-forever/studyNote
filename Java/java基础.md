# 类和面向对象

简单理解：把复杂的事情分成简单的模块进行处理，每个类处理一个业务

例如：做一个转盘，观察获得几等奖。

分析，首先需要一个转盘(图像界面)，一个根据得到的数字判断几等奖的类，

一个随机生成数字的类，然后组合就可以了！

因为图形界面按钮触发**事件**，所以先完成业务，再嵌入图形界面中

> 随机生成数字类

~~~java
import java.util.Random;

public class Number {
    private static Random random=new Random();
    //将num定义成静态变量
    private static int num;
    //空参构造
    public Number(){

    }
    //静态代码块   给静态变量赋值
    static {
        num=random.nextInt(10);
    }

    /**
     * set 方法 给成员变量赋值
     * get 方法 得到成员变量的值
     */
    public static void setNum(int number){
        Number.num=number;
    }

    public static int getNum(){
        return num;
    }
}
~~~

**注**：成员变量是定义在类中的变量，不加static关键字

​        类变量也是定义在类中的变量，加static关键字(类变量只能类方法(加static)进行调用)

​        局部变量是定义在方法中的变量，大多数情况在方法结束时被gc回收

> 判断几等奖

~~~java
public class WhatNum {
    public static String judge(int num){
        String forOut = "";
        if (num>=0&&num<1) forOut="恭喜你获得一等奖";
        else if(num>=1&&num<3) forOut="恭喜你获得二等奖";
        else if (num>=3&&num<5) forOut="恭喜你获得三等奖";
        else forOut="对不起，你没有获奖";
        
        return forOut;
    }
}
~~~

> 图形局面类

~~~java
import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;

public class Picture {
    private JFrame jFrame = new JFrame();
    private JPanel jPanel=new JPanel(new BorderLayout());
    private JButton jButton=new JButton("获取数字");
    private TextArea area=new TextArea();
    public Picture(){
        jFrame.setBounds(300,300,200,300);
        jFrame.add(jPanel);
        jFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        jFrame.setVisible(true);
        jPanel.add(jButton,BorderLayout.NORTH);
        jPanel.add(area,BorderLayout.CENTER);
        action();
    }

    private void action(){
        jButton.addActionListener(new AbstractAction() {
            @Override
            public void actionPerformed(ActionEvent e) {
                int num = Number.getNum();
                String judge = WhatNum.judge(num);
                area.setText("您得到的数字是"+num+"\n"+judge);
            }
        });
    }
}

~~~

![](C:\学习\Java\picture\1.png)

把所有业务拆开，调用相应的方法。下面测试

> Main (测试类)

~~~java
public class Main {
    public static void main(String[] args) {
        new Picture();
    }
}
~~~

==测试结果==

![](C:\学习\Java\picture\2.png)







# 异常

相关关键字：throw ，throws，try-catch

Exception和Error都继承于Throwable

![](C:\学习\Java\picture\3.png)

![](C:\学习\Java\picture\4.png)

Error是比较严重的错误，涉及java虚拟机jvm调优，不用管，关键是不一定听懂，考试不考，这里就不说了。

主要是Exception,异常分为运行时异常(RuntimeException)和检查时异常。

检查时异常时程序还没有编译成字节码文件时就声明的异常，

运行时异常时在运行时逻辑错误出现的异常。

![](C:\学习\Java\picture\5.png)

![](C:\学习\Java\picture\6.png)

## 运行时异常不能由编译器进行警告，在程序运行时出现进而终止程序：（如下图）

1、不处理运行时异常会出现的情况：

![](C:\学习\Java\picture\7.png)

2、使用try-catch处理异常后：

![](C:\学习\Java\picture\8.png)

由上图可见：运行时异常不处理会终止程序，需要格外注意！需要用try进行抓异常，catch进行处理异常。

## 检查时异常由编译器进行警告，不处理就无法编译

![](C:\学习\Java\picture\9.png)

![](C:\学习\Java\picture\10.png)

解决办法：（两种）

![](C:\学习\Java\picture\11.png)

![](C:\学习\Java\picture\12.png)

关于异常的基础就讲完了，下面写一个异常demo

**业务需求：** 定义一个People类，判断他的年龄和学号是否违法，对异常进行处理

年龄大于100或者小于0违法，学号大于1000或者小于0违法



> 自定义异常类

~~~java
public class MyException extends Exception{
    public MyException(){
        super();//调用父类的无参构造
    }
    public MyException(String msg){
        super(msg);//调用父类的有参构造
    }
}
~~~

> 定义people类

~~~java
public class People {
    private int age;
    private int num;

    //在有参构造中对年龄和学号异常进行处理
    /**
    throws 为向调用者声明异常
    throw 对异常进行详细的解说
    **/
    public People(int age,int num) throws MyException{
        if (age>100||age<0)
            throw new MyException("年龄有误");
        else
            this.age=age;

        if (num>1000||num<0)
            throw new MyException("学号有误");
        else
             this.num=num;
    }
}
~~~

> Main(测试类)

~~~java
public class Main {
    public static void main(String[] args) {
        try {
            new People(10,3000);
        }catch (MyException e){
            System.out.println("异常是:"+e);
        }finally {
            System.out.println("无论如何都执行");
        }
    }
}
~~~

结果：

![](C:\学习\Java\picture\13.png)



**再点一下：** 对比着people类进行观看![](C:\学习\Java\picture\14.png)

![](C:\学习\Java\picture\15.png)





# 图形界面

这个玩意没啥意思(都1202年了，谁还用swing图形界面啊，**学校)



记住几个常见的就行：

JFrame  窗口

​         setDefaultCloseOperation();  //设置图形界面和程序的关系

​         setVisible();  //设置图形界面是否可视(能不能看见)

​         setBounds();  //前两个参数是设置在电脑距离左上角的位置，后两个的长宽

JPanel   窗口

JButton  按钮

JLabel  标签

JTextArea  文本域

JPasswordField  密码框

JTextField  文本框



本来想把所有的方法体也码一边.......一看....自闭了。

你自己看看吧，有一个博客，一会发给你。

![](C:\学习\Java\picture\16.png)
