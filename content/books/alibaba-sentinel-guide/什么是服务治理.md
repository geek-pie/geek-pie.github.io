
https://github.com/alibaba/Sentinel/wiki/%E6%B5%81%E9%87%8F%E6%8E%A7%E5%88%B6


| Field | 说明 | 
| :----: | :----| 
|CONTROL_BEHAVIOR_DEFAULT||
|CONTROL_BEHAVIOR_WARM_UP|预热/冷启动方式。当系统长期处于低水位的情况下，当流量突然增加时，直接把系统拉升到高水位可能瞬间把系统压垮。通过"冷启动"，让通过的流量缓慢增加，在一定时间内逐渐增加到阈值上限，给冷系统一个预热的时间，避免冷系统被压垮。|




warmUpPeriodSec 代表期待系统进入稳定状态的时间（即预热时长）。

# 预热/冷启动方式

https://github.com/alibaba/Sentinel/wiki/%E9%99%90%E6%B5%81---%E5%86%B7%E5%90%AF%E5%8A%A8
https://blog.csdn.net/xiongxianze/article/details/87580917



## 开启

```shell
$ echo $JAVA_HOME
/Library/Java/JavaVirtualMachines/jdk1.8.0_291.jdk/Contents/Home
$ cd /Library/Java/JavaVirtualMachines/jdk1.8.0_291.jdk/Contents/Home
$ cd bin
$ ls
```
就能看到`jvisualvm`存在。



我们可以看到如下的日志：
```java
2023-11-03 15:14:10.615  INFO 7400 --- [nio-8080-exec-4] com.xienng.DownloadUtils                 : 文件下载完成，字节数：221266
2023-11-03 15:14:10.616  INFO 7400 --- [nio-8080-exec-4] com.xienng.DownloadService               : passed!,pass  count=22
2023-11-03 15:14:10.616  INFO 7400 --- [nio-8080-exec-4] com.xienng.DownloadService               : total  count=100
```

总数100，通过的数量为22.

使用`jvisualvm`可以观察其内存占用。