package com.xienng.test;

import org.openjdk.jol.vm.VM;

/**
 * @author xujianxing@sensetime.com
 * @date 2023年10月22日 16:32
 */
public class Test {

    public static void main(String[] args) {
        User i = new User("ZHAN",1);

        System.out.println("原始的对象地址：" + VM.current().addressOf(i));
        test(i);
        System.out.println(i);

        //因为栈的引用地址是复制的，所以这里的i不会指向"efg"的地址
        System.out.println("函数调用以后原始的对象地址：" + VM.current().addressOf(i));
    }


    /**
     * @param i
     */
    public static void test(User i) {

        //复制一份引用（所谓的钥匙），因此这个时候对象i对应的堆内存是没有变化的
        System.out.println("赋值前的对象地址：" + VM.current().addressOf(i));
        i.setAge(3);
        //新的i的栈上的引用，指向了新的堆空间的地址（而不是将原来的i对应的空间重新设置值）
        System.out.println("赋值以后的对象地址：" + VM.current().addressOf(i));
    }


}
