# JUC并发



## 1、心灵鸡汤

~~~C
你一次可以学会并且精通这个东西，加油！！！
~~~



## 2、生产者消费者问题



> synchronized的解决方法

```java
public class Text {
    public static void main(String[] args) {
        Data data = new Data();
        new Thread(()->{
            for (int i = 0; i < 5; i++) {
                try {
                    data.increment();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        },"A").start();

        new Thread(()->{
            for (int i = 0; i < 5; i++) {
                try {
                    data.increment();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        },"B").start();

        new Thread(()->{
            for (int i = 0; i < 5; i++) {
                try {
                    data.decrement();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        },"C").start();

        new Thread(()->{
            for (int i = 0; i < 5; i++) {
                try {
                    data.decrement();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        },"D").start();
    }
}
class Data{
    private int number =0;
    public synchronized void increment() throws InterruptedException {
        while(number!=0){    //用while不用if的原因是防止虚假唤醒，while
            this.wait();     //使线程不满足条件是一直等待
        }
        number++;
        System.out.println(Thread.currentThread().getName()+"=>"+number);
        this.notifyAll();
    }
    public synchronized void decrement() throws InterruptedException {
        while (number==0){
            this.wait();
        }
        number--;
        System.out.println(Thread.currentThread().getName()+"=>"+number);
        this.notifyAll();
    }
}
```



> lock锁解决办法

```java
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class Text {
    public static void main(String[] args) {
        Data data = new Data();
        new Thread(()->{
            for (int i = 0; i < 5; i++) {
                    data.increment();
            }
        },"A").start();

        new Thread(()->{
            for (int i = 0; i < 5; i++) {
                    data.increment();
            }
        },"B").start();

        new Thread(()->{
            for (int i = 0; i < 5; i++) {
                    data.decrement();
            }
        },"C").start();

        new Thread(()->{
            for (int i = 0; i < 5; i++) {
                    data.decrement();
            }
        },"D").start();
    }
}
class Data{
    private int number =0;
    private Lock lock=new ReentrantLock();
    private Condition condition =lock.newCondition();

    public  void increment()  {
        lock.lock();
            try {
                while(number!=0) {
                    condition.await(); //线程进行等待 await()方法
                }
                number++;
                System.out.println(Thread.currentThread().getName()+"=>"+number);
                condition.signalAll();   //线程通知其他线程可以唤醒了 signalAll()方法
            } catch (InterruptedException e) {
                e.printStackTrace();
            }finally {
                lock.unlock();
            }
    }
    public  void decrement()  {
        lock.lock();
        try {
            while(number==0) {
                condition.await();
            }
            number--;
            System.out.println(Thread.currentThread().getName()+"=>"+number);
            condition.signalAll();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }finally {
            lock.unlock();
        }
    }
}
```



>Condition实现精准唤醒

```java
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class Text {
    public static void main(String[] args) {
        Data data = new Data();
        new Thread(()->{
            for (int i = 0; i < 5; i++)
            data.printA();
        },"A").start();
        new Thread(()->{
            for (int i = 0; i < 5; i++)
            data.printB();
        },"B").start();
        new Thread(()-> {
            for (int i = 0; i < 5; i++)
            data.printC();
        },"C").start();
    }
}
class Data{
    private Lock lock=new ReentrantLock();
    private Condition condition1=lock.newCondition();
    private Condition condition2=lock.newCondition();
    private Condition condition3=lock.newCondition();
    private int number=1;
    public void printA(){
        lock.lock();
        try {
            while(number!=1){
                condition1.await();
            }
            System.out.println(Thread.currentThread().getName()+"=>AAAA");
            number=2;
            condition2.signal();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }finally {
            lock.unlock();
        }
    }
    public void printB(){
        lock.lock();
        try {
            while(number!=2){
                condition2.await();
            }
            System.out.println(Thread.currentThread().getName()+"=>BBBB");
            number=3;
            condition3.signal();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }finally {
            lock.unlock();
        }
    }
    public void printC(){
        lock.lock();
        try {
            while(number!=3){
                condition3.await();
            }
            System.out.println(Thread.currentThread().getName()+"=>CCCC");
            number=1;
            condition1.signal();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }finally {
            lock.unlock();
        }
    }
}
```





## 3、多线程中安全的集合类



>多线程线性数组（Copy On Write Array List）

```java
import java.util.*;
import java.util.concurrent.CopyOnWriteArrayList;

public class ListTest {
    public static void main(String[] args) {
        //1.List<String> list=new Vector<>();
        //2.List<String> list= Collections.synchronizedList(new ArrayList<>());
        //CopyOnWrite 写入时复制  COM
        //在写入的时候避免覆盖，造成数据问题
        //读写分离   （不明白，有机会百度）
        List<String> list =new CopyOnWriteArrayList<>();
        for (int i = 1; i <= 10; i++) {
            new Thread(()->{
                list.add(UUID.randomUUID().toString().substring(0,5));
                System.out.println(list);
            },String.valueOf(i)).start();
        }
    }
}

```



>多线程集合（Copy On Write Array Set）

```java
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.CopyOnWriteArraySet;

public class SetTest {
    public static void main(String[] args) {
        //另一个解决办法：Set<String>set= Collections.synchronizedSet(new HashSet<>());
        Set<String> set = new CopyOnWriteArraySet<>();
        for(int i=1;i<=30;i++){
            new Thread(()->{
                set.add(UUID.randomUUID().toString().substring(0,5));
                System.out.println(set);
            },String.valueOf(i)).start();
        }
    }
}

```



> 多线程哈希表（Concurrent Hash Map）

```java
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

public class MapTest {
    public static void main(String[] args) {
        Map<String,String>map = new ConcurrentHashMap<>();
        for (int i = 1; i <=30 ; i++) {
            new Thread(()->{
                map.put(Thread.currentThread().getName(), UUID.randomUUID().toString().substring(0,5));
                System.out.println(map);
            },String.valueOf(i)).start();
        }
    }
}
```



## 4、Callable



```java
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.FutureTask;

public class CallableDemo {
    public static void main(String[] args) throws ExecutionException, InterruptedException {
        My thread=new My();
        FutureTask futureTask=new FutureTask(thread); //适配器
        new Thread(futureTask,"A").start(); //Thread无法直接调用Callable，所以需要适配器
        Integer o = (Integer) futureTask.get();//会发生堵塞
        //或者使用异步通讯来处理
        System.out.println(o);
    }
}
class My implements Callable<Integer> {

    @Override
    public Integer call()  {
        System.out.println("call()");//如果call()内方法过复杂，调用get()会堵塞
        return 1024;
    }
}
```

## 5、常见的辅助类



> 多线程减（Count Down Latch）

```java
import java.util.concurrent.CountDownLatch;

public class CountDownLatchDemo {
    public static void main(String[] args) {
        CountDownLatch countDownLatch=new CountDownLatch(6);  //初始数量为6
        for (int i = 1; i <=6; i++) {
            new Thread(()->{
                System.out.println(Thread.currentThread().getName()+"Go out");
                countDownLatch.countDown();  //数量减一
            },String.valueOf(i)).start();
        }
        try {
            countDownLatch.await();    //等待countDownLatch减为零执行下面代码
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("Close Door");
    }
}

```

> 栅栏（Cyclic Barrier）

```java
import java.util.concurrent.BrokenBarrierException;
import java.util.concurrent.CyclicBarrier;

public class CyclicBarrierDemo {
    public static void main(String[] args) {
        CyclicBarrier cyclicBarrier =new CyclicBarrier(7,()->{
            System.out.println("召唤神龙成功");//所有线程达到一个条件之后，开启新线程执行代码
        });
        for (int i = 1; i <= 7 ; i++) {
            int temp=i;//其实temp是final int temp ,系统自动补上
            new Thread(()->{
                System.out.println(Thread.currentThread().getName()+"收集第"+temp+"个龙珠");
                try {
                    cyclicBarrier.await(); //等待所有线程达到一个条件之后执行下面代码
                } catch (InterruptedException e) {
                    e.printStackTrace();
                } catch (BrokenBarrierException e) {
                    e.printStackTrace();
                }
                System.out.println(1);  //所有线程达到一个条件之后执行这个代码
            }).start();
        }
    }
}

```

> 信号量(Semaphore)     作用：多个共享资源互斥的使用！并发限流，控制最大的线程数

```java
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;

public class SemaphoreDemo {
    public static void main(String[] args) {
        Semaphore semaphore=new Semaphore(3);//指定线程数
        for (int i = 1; i <= 6 ; i++) {
            new Thread(()->{
                //acquire 得到
                try {
                    semaphore.acquire();
                    System.out.println(Thread.currentThread().getName()+"抢到车位");
                    TimeUnit.SECONDS.sleep(2);//线程休息两秒
                    System.out.println(Thread.currentThread().getName()+"离开车位");
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }finally {
                    //release()释放
                    semaphore.release();
                }
            },String.valueOf(i)).start();
        }
    }
}

```

**Cyclic Barrier:指定个数线程执行完毕再执行操作**

**Semaphore:同一时间只能有指定数量得到线程**

## 6、读写锁（ReadWriteLock）



```java
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

public class ReadWriteLockDemo {
    public static void main(String[] args) {
        MyLock myLock =new MyLock();
        for (int i = 1; i <= 3 ; i++) {
            final int temp=i;
            new Thread(()->{
                myLock.put(temp+"",temp+"");
            },String.valueOf(i)).start();
        }
        for (int i = 1; i <= 3 ; i++) {
            final int temp=i;
            new Thread(()->{
                myLock.get(temp+"");
            },String.valueOf(i)).start();
        }
    }
}
class MyLock{
    private volatile Map<String,Object> map =new HashMap<>();
    private ReadWriteLock readWriteLock =new ReentrantReadWriteLock();
    //一个独占锁（写入时），一个共享锁（读取时）
    public void put(String key,Object value){
        readWriteLock.writeLock().lock();  //写入时上锁，是一个独占锁
        try{
            System.out.println(Thread.currentThread().getName()+"写入"+key);
            map.put(key, value);
            System.out.println(Thread.currentThread().getName()+"写入OK");
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            readWriteLock.writeLock().unlock();//写入锁解锁
        }
    }

    public void get(String key){
        readWriteLock.readLock().lock();//读取时上锁，是一个共享锁
        try {
            System.out.println(Thread.currentThread().getName()+"读取"+key);
            Object o=map.get(key);
            System.out.println(Thread.currentThread().getName()+"读取成功");
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            readWriteLock.readLock().unlock();//读取锁解锁
        }
    }
}
```

~~~less
上面代码可能会有人理解为，put用synchronized，get不用修饰字不就行了？
其实不然，可能会造成写入进程进行一半时读取进程运行,不符合业务逻辑。
而读写锁不会产生这种问题，这也是读写锁的优势
但是读写锁会造成幻读的情况，即先读取再写入的情况，可以用Condition进行解决，见上述（三）。
~~~

## 6、阻塞队列



> BlockingQueue

**四组API**

| 方式       | 抛出异常(1) | 有返回值(2) | 阻塞等待(3) | 超时等待(4) |
| ---------- | ----------- | ----------- | ----------- | ----------- |
| 添加       | add()       | offer()     | put()       | offer()     |
| 移除       | remove()    | poll()      | take()      | poll()      |
| 判断队列首 | element()   | peek()      | null        | null        |

```java
(1)
import java.util.concurrent.ArrayBlockingQueue;

public class BlockingQueueDemo {
    public static void main(String[] args) {
        ArrayBlockingQueue blockingQueue =new ArrayBlockingQueue<>(3);
        //capacity参数为队列的大小,队列大小为3
        System.out.println(blockingQueue.add("a"));//true
        System.out.println(blockingQueue.add("b"));//true
        System.out.println(blockingQueue.add("c"));//true
        //上面在队列中加了三组数据，队列满了不能再加数据，如果再加，会抛出异常
        //System.out.println(blockingQueue.add("d"));
        //java.lang.IllegalStateException: Queue full
        System.out.println(blockingQueue.remove());//"a"
        System.out.println(blockingQueue.remove());//"b"
        System.out.println(blockingQueue.remove());//"c"
        //队列中的数据已经完全取出，队列为空，不能再取数据，如果继续操作，会抛出异常
        //System.out.println(blockingQueue.remove());
        //java.util.NoSuchElementException
    }
}
```

```java
(2)
import java.util.concurrent.ArrayBlockingQueue;

public class BlockingQueueDemo {
    public static void main(String[] args) {
        ArrayBlockingQueue blockingQueue =new ArrayBlockingQueue<>(3);
        System.out.println(blockingQueue.offer("a"));//true
        System.out.println(blockingQueue.offer("b"));//true
        System.out.println(blockingQueue.offer("c"));//true
        //超过队列的储存量，不会报异常，会返回一个boolean值
        System.out.println(blockingQueue.offer("d"));//false
        System.out.println(blockingQueue.poll());//a
        System.out.println(blockingQueue.poll());//b
        System.out.println(blockingQueue.poll());//c
        //队列中已经为空，继续取数不会报异常，会返回null
        System.out.println(blockingQueue.poll());//null
    }
}

```

```java
(3)
import java.util.concurrent.ArrayBlockingQueue;

public class BlockingQueueDemo {
    public static void main(String[] args) throws InterruptedException {
        ArrayBlockingQueue blockingQueue =new ArrayBlockingQueue<>(3);
        blockingQueue.put("a");
        blockingQueue.put("b");
        blockingQueue.put("c");
        //超过队列的储存量，不会报异常，会阻塞，线程等待
        //blockingQueue.put("d");
        System.out.println(blockingQueue.take());//a
        System.out.println(blockingQueue.take());//b
        System.out.println(blockingQueue.take());//c
        //队列中已经为空，继续取数不会报异常，阻塞，线程等待
        //System.out.println(blockingQueue.take());
    }
}

```

```java
(4)
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.TimeUnit;

public class BlockingQueueDemo {
    public static void main(String[] args) throws InterruptedException {
        ArrayBlockingQueue blockingQueue =new ArrayBlockingQueue<>(3);
        blockingQueue.offer("a");
        blockingQueue.offer("b");
        blockingQueue.offer("c");
        //超过队列的储存量，不会报异常，会阻塞，线程等待,等待指定时间后结束线程
        blockingQueue.offer("d",2,TimeUnit.SECONDS);
        System.out.println(blockingQueue.poll());//a
        System.out.println(blockingQueue.poll());//b
        System.out.println(blockingQueue.poll());//c
        //队列中已经为空，继续取数不会报异常，阻塞，线程等待，等待指定时间后结束线程
        System.out.println(blockingQueue.poll(2, TimeUnit.SECONDS));
    }
}

```



> SynchronousQueue 同步队列

**容量为1，进去一个元素，必须等待取出来之后，才能再往里面放一个元素！**

```java
import java.util.concurrent.SynchronousQueue;
import java.util.concurrent.TimeUnit;

public class SynchronousQueueDemo {
    public static void main(String[] args) {
        SynchronousQueue synchronousQueue=new SynchronousQueue();
        new Thread(()->{
            try {
                synchronousQueue.put("a");//放入元素，等待元素被取出后执行下面代码
                System.out.println(Thread.currentThread().getName()+"put a");
                synchronousQueue.put("b");
                System.out.println(Thread.currentThread().getName()+"put b");
                synchronousQueue.put("c");
                System.out.println(Thread.currentThread().getName()+"put c");
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        },"T1").start();

        new Thread(()->{
            try {
                TimeUnit.SECONDS.sleep(2);//模拟延时
                System.out.println(Thread.currentThread().getName()+"=>"+synchronousQueue.take());
                //取出队列中的元素
                TimeUnit.SECONDS.sleep(2);
                System.out.println(Thread.currentThread().getName()+"=>"+synchronousQueue.take());
                TimeUnit.SECONDS.sleep(2);
                System.out.println(Thread.currentThread().getName()+"=>"+synchronousQueue.take());
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        },"T2").start();
    }
}

```

## 7、线程池（重点）



> 池化技术 --优化资源的使用

**线程创建，销毁，十分浪费资源，所以事先准备一些资源，用的时候拿走，不用时归还**

**优势：**

1.降低资源的消耗

2.提高响应的速度

3.方便管理

==**线程复用，可以控制最大并发数，管理线程**==



> 线程池：三大方法

```java
(1)//单一线程 Executors.newSingleThreadExecutor();
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class TheadPool {
    public static void main(String[] args) {
        ExecutorService service= Executors.newSingleThreadExecutor();
        try {
            for (int i = 0; i < 10; i++) {
                service.execute(()->{
                    System.out.println(Thread.currentThread().getName()+"启动");
                }); //调用线程
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            service.shutdown(); //关闭线程池
        }
    }
}

结果：
pool-1-thread-1启动
pool-1-thread-1启动
pool-1-thread-1启动
pool-1-thread-1启动
pool-1-thread-1启动
pool-1-thread-1启动
pool-1-thread-1启动
pool-1-thread-1启动
pool-1-thread-1启动
pool-1-thread-1启动
```

```java
(2)//创建一个指定大小的线程池 Executors.newFixedThreadPool(5);
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class TheadPool {
    public static void main(String[] args) {
        ExecutorService service= Executors.newFixedThreadPool(5);
        try {
            for (int i = 0; i < 10; i++) {
                service.execute(()->{
                    System.out.println(Thread.currentThread().getName()+"启动");
                }); //调用线程
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            service.shutdown(); //关闭线程池
        }
    }
}

结果：
pool-1-thread-2启动
pool-1-thread-1启动
pool-1-thread-3启动
pool-1-thread-5启动
pool-1-thread-4启动
pool-1-thread-5启动
pool-1-thread-3启动
pool-1-thread-1启动
pool-1-thread-2启动
pool-1-thread-4启动
```

```java
(3)//可伸缩线程池，和cpu调度有关 Executors.newCachedThreadPool();
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class TheadPool {
    public static void main(String[] args) {
        ExecutorService service= Executors.newCachedThreadPool();
        try {
            for (int i = 0; i < 10; i++) {
                service.execute(()->{
                    System.out.println(Thread.currentThread().getName()+"启动");
                }); //调用线程
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            service.shutdown(); //关闭线程池
        }
    }
}

结果：
pool-1-thread-10启动
pool-1-thread-6启动
pool-1-thread-4启动
pool-1-thread-8启动
pool-1-thread-9启动
pool-1-thread-1启动
pool-1-thread-2启动
pool-1-thread-3启动
pool-1-thread-5启动
pool-1-thread-7启动
```

> 线程池：七大参数

```java
//源码：
(1)
public static ExecutorService newSingleThreadExecutor() {
        return new FinalizableDelegatedExecutorService
            (new ThreadPoolExecutor(1, 1,
                                    0L, TimeUnit.MILLISECONDS,
                                    new LinkedBlockingQueue<Runnable>()));
    }
(2)
public static ExecutorService newFixedThreadPool(int nThreads) {
        return new ThreadPoolExecutor(nThreads, nThreads,
                                      0L, TimeUnit.MILLISECONDS,
                                      new LinkedBlockingQueue<Runnable>());
    }
(3)
public static ExecutorService newCachedThreadPool() {
        return new ThreadPoolExecutor(0, Integer.MAX_VALUE,
                                      60L, TimeUnit.SECONDS,
                                      new SynchronousQueue<Runnable>());
    }

由上面可知：本质调度一个ThreadPoolExecutor()对象
//ThreadPoolExecutor()
public ThreadPoolExecutor(int corePoolSize,//核心线程池大小
                          int maximumPoolSize,//最大核心线程池大小
                          long keepAliveTime,//最大等待调度时间
                          TimeUnit unit,//超时单位
                          BlockingQueue<Runnable> workQueue,//阻塞队列
                          ThreadFactory threadFactory,//线程工厂，创建线程
                          RejectedExecutionHandler handler/*拒绝策略*/) {
        if (corePoolSize < 0 ||
            maximumPoolSize <= 0 ||
            maximumPoolSize < corePoolSize ||
            keepAliveTime < 0)
            throw new IllegalArgumentException();
        if (workQueue == null || threadFactory == null || handler == null)
            throw new NullPointerException();
        this.corePoolSize = corePoolSize;
        this.maximumPoolSize = maximumPoolSize;
        this.workQueue = workQueue;
        this.keepAliveTime = unit.toNanos(keepAliveTime);
        this.threadFactory = threadFactory;
        this.handler = handler;
    }
```

> 手写一个线程池

```java
import java.util.concurrent.*;

public class TheadPool {
    public static void main(String[] args) {
        ExecutorService service= new ThreadPoolExecutor(2,
                5,
                3,
                TimeUnit.SECONDS,
                new LinkedBlockingQueue<>(3),
                Executors.defaultThreadFactory(),
                new ThreadPoolExecutor.AbortPolicy()/*四大拒绝策略，见下*/
        );
        try {
            for (int i = 0; i < 10; i++) {
                service.execute(()->{
                    System.out.println(Thread.currentThread().getName()+"启动");
                }); //调用线程
            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            service.shutdown(); //关闭线程池
        }
    }
}
```



> 四种拒绝策略

~~~shell
//当线程池满了，再进来一个线程时，
new ThreadPoolExecutor.AbortPolicy() //不再执行，抛出异常
new ThreadPoolExecutor.CallerRunsPolicy()//不再执行，多时由main线程执行(上一级线程)
new ThreadPoolExecutor.DiscardPolicy()//丢掉任务，不会抛出异常
new ThreadPoolExecutor.DiscardOldestPolicy()//尝试与最早的线程竞争，不会抛出异常
~~~

> 拓展    线程池最大线程如何设置

**了解：IO密集型，cpu密集型(调优)**

~~~sh
Runtime.getRuntime().availableProcessors();//获取当前电脑cpu核数
1.cpu密集型  几核就是几，可以保持cpu的效率最高
2.IO密集型    >判断你程序中十分消耗IO的线程
~~~

## 8、四大函数式接口(必须掌握)



> Function

~~~sh
Function 函数型接口，有一个输入参数，有一个输出
只要是 函数型接口 就可以用lambda表达式简化
~~~



```java
import java.util.function.Function;

public class Demo {
    public static void main(String[] args) {
//        Function<String,String> function=new Function<String, String>() {
//            @Override
//            public String apply(String s) {
//                return s;
//            }
//        };
//        System.out.println(function.apply("aaa"));
        //lambda表达式简化
        Function<String,String>function=(str)->str;
        System.out.println(function.apply("aaa"));
    }
}

```

> Predicate

~~~sh
Predicate 断定型接口 有一个输入参数，返回值为boolean值
~~~



```java
import java.util.function.Predicate;

public class Demo {
    public static void main(String[] args) {
        //判断字符串是否为空
//        Predicate<String> predicate =new Predicate<String>() {
//            @Override
//            public boolean test(String s) {
//                return s.isEmpty();
//            }
//        };
        //lambda简化
//        Predicate<String> predicate =(str)->{
//            return str.isEmpty();
//        };
        //再简化
        Predicate<String> predicate =(str)->str.isEmpty();
        System.out.println(predicate.test(""));
    }
}
```

> Consumer

~~~sh
Consumer 消费型接口 有一个输入参数，无返回值
~~~



```java
import java.util.function.Consumer;

public class Demo {
    public static void main(String[] args) {
        //打印输入
//        Consumer<String> consumer=new Consumer<String>() {
//            @Override
//            public void accept(String s) {
//                System.out.println(s);
//            }
//        };
        //lambda 简化
//        Consumer<String> consumer=(str)->{
//            System.out.println(str);
//        };
        //再简化
        Consumer<String> consumer=(str)-> System.out.println(str);
        consumer.accept("a");
    }
}
```

> Supplier

~~~sh
Supplier 供给型接口 没有输入参数 只有返回值
~~~



```java
import java.util.function.Supplier;

public class Demo {
    public static void main(String[] args) {
//        Supplier<Integer> supplier =new Supplier<Integer>() {
//            @Override
//            public Integer get() {
//                System.out.println("get()");
//                return 1024;
//            }
//        };
        //使用lambda简化
//        Supplier<Integer> supplier =()->{
//            System.out.println("get()");
//            return 1024;
//        };
        //继续简化 不能多行了
        Supplier<Integer> supplier =()-> 1024;
        System.out.println(supplier.get());
    }
}
```

**函数型接口，看需求进行灵活运用，lambda表达式简化程度都需要合理，否则会达不到目的**

## 9、Stream流式计算



```java
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Arrays;
import java.util.List;
import java.util.Locale;

public class Test {
    public static void main(String[] args) {
        User u1=new User(1,"a",21);
        User u2=new User(2,"b",22);
        User u3=new User(3,"c",23);
        User u4=new User(4,"d",24);
        User u5=new User(5,"e",25);
        List<User> list=Arrays.asList(u1,u2,u3,u4,u5);
        //lambda表达式，链式编程，函数式接口，Stream流式计算
        list.stream()
                .filter(u->{return u.getId()%2==0;}) //ID必须是偶数
                .filter(u->{return u.getAge()>23;})  //年龄大于23岁
                .map(u->{return u1.getName().toUpperCase(Locale.ROOT);})//用户名转化成大写
                .sorted((uu1,uu2)->{return uu2.compareTo(uu1);})//用户名字母倒叙
                .limit(1)  //只输出一个用户
                .forEach(System.out::println); //迭代输出符合要求的数
    }
}
@Data
@NoArgsConstructor
@AllArgsConstructor
class User{
    private int id;
    private String name;
    private int age;

}
```

~~~
*关于lombok(注解，具体使用方法百度)的使用
1.百度下载lombok jar包 网址：https://projectlombok.org/
2.在idea里添加依赖 如下图 1：
3.在idea中配置允许使用注解的选项 如下图 2：
4.运行即可！
注：idea需要下载lombok插件
~~~

1.![在idea中添加依赖](C:\学习\juc\picture\依赖.PNG)

2.

<img src="C:\学习\juc\picture\添加注解选项.png" alt="配置idea的允许项" style="zoom:80%;" />

## 10、ForkJoin



>ForkJoin  分治的思想，把任务派别成小任务，再将结果进行合并   

**特点：工作窃取    即：先完成工作的线程将未完成任务的线程的任务拿来处理**

~~~shell
了解即可，主要是没听懂
~~~

> Stream并行流  //提高运行计算效率   （最好百度+看源码 好好了解）

```java
import java.util.stream.LongStream;

public class Stream {
    public static void main(String[] args) {
        long start=System.currentTimeMillis();//程序(业务)开始时间
        Long sum= LongStream.rangeClosed(0L,10_0000_0000L).parallel().reduce(0,Long::sum);
        long end=System.currentTimeMillis();//程序(业务)结束时间
        System.out.println("sum="+sum+"时间："+(end-start));
    }
}
```

## 11、


