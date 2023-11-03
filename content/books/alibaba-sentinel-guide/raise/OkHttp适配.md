---
title: "OKHttp适配"
weight: 1
---


# OkHttp下的熔断
https://sentinelguard.io/zh-cn/docs/open-source-framework-integrations.html

OkHttp 2.x非常过时
```xml
   <dependency>
            <groupId>com.squareup.okhttp3</groupId>
            <artifactId>okhttp</artifactId>
            <version>${okhttp-version}</version>
        </dependency>
        <dependency>
            <groupId>com.squareup.okhttp3</groupId>
            <artifactId>logging-interceptor</artifactId>
            <version>${okhttp-version}</version>
        </dependency>
        <dependency>
            <groupId>com.alibaba.csp</groupId>
            <artifactId>sentinel-okhttp-adapter</artifactId>
            <version>${sentinel-version}</version>
        </dependency>
```
因为某些实际的原因，使用的是2.7.5版本
```
 <okhttp-version>3.14.9</okhttp-version>
```

首先，定义一个Controller，用来模拟被调用的下游方法:
```java
@RestController
@RequestMapping("platform")
public class PlatformController {

    @GetMapping(value = "do")
    public String query() {
        System.out.println("platform/do开始执行");
        try {
            Thread.sleep(5000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return "OK";
    }
}
```



然后，我们需要配置一个熔断规则和初始化一个OkHttp的客户端

```java
@Component
public class SentinelConfig {


    @PostConstruct
    private void init() {
        initDegradeRule();
    }


    private void initDegradeRule() {
        List<DegradeRule> rules = new ArrayList<>();
        DegradeRule rule = new DegradeRule();
        rule.setResource("okhttp:GET:http://localhost:8080/platform/do");
        rule.setGrade(RuleConstant.DEGRADE_GRADE_EXCEPTION_COUNT)
                .setTimeWindow(60)
                .setCount(1)
                .setMinRequestAmount(1)
                .setStatIntervalMs(10 * 1000);
        rules.add(rule);
        DegradeRuleManager.loadRules(rules);
    }

}


```
这个`Resource`的定义可能有点奇怪，后面会讲到为什么要这么设置，并且如何改变。

```java
@Configuration
public class DefaultOkHttpConfig {


    @Bean
    public OkHttpClient okHttpClient() {
        OkHttpClient okHttpClient = new OkHttpClient.Builder()
                .addInterceptor(new SentinelOkHttpInterceptor(new SentinelOkHttpConfig()))
                .callTimeout(3000, TimeUnit.MILLISECONDS)
                .build();
        return okHttpClient;
    }

}
```


按照如下的配置，期望的情况是这样的：
在前面的几次中，由于timeout时间超过了时间，会先抛出OKhttp的异常。在几次运行以后（正如在前面几章提到的，Sentinel的限流并不是特别的准确）。
在超过一定次数以后，下游


现在运行(省略了一部分代码）:
```
platform/do开始执行
java.io.InterruptedIOException: timeout
```


在多次运行以后，出现了如下错误，并且没有调用再调用下游的的`/platform/do`方法：
```java
com.alibaba.csp.sentinel.slots.block.SentinelRpcException: 
com.alibaba.csp.sentinel.slots.block.degrade.DegradeException
Caused by: com.alibaba.csp.sentinel.slots.block.degrade.DegradeException
```


# OKHttp的原理
```java
@Override
    public Response intercept(Chain chain) throws IOException {
        Entry entry = null;
        try {
            Request request = chain.request();
            String name = config.getResourceExtractor().extract(request, chain.connection());
            if (StringUtil.isNotBlank(config.getResourcePrefix())) {
                name = config.getResourcePrefix() + name;
            }
            entry = SphU.entry(name, ResourceTypeConstants.COMMON_WEB, EntryType.OUT);
            return chain.proceed(request);
        } catch (BlockException e) {
            return config.getFallback().handle(chain.request(), chain.connection(), e);
        } catch (IOException ex) {
            Tracer.traceEntry(ex, entry);
            throw ex;
        } finally {
            if (entry != null) {
                entry.exit();
            }
        }
    }
```

name定义通过IDE的断点可以查询的到。

针对同步调用的限流场景，异步场景其实是用不到的。
