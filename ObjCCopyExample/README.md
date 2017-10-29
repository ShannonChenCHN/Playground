# Objective-C 对象的拷贝

[相关文章](https://github.com/ShannonChenCHN/iOSLevelingUp/issues/61)

这个 demo 主要是对以下问题的一些试验：
- [] 如何让自定义对象支持 copy 操作？NSCopying 协议是什么？如何实现 NSCopying 协议？
- [x] copy 与 mutableCopy 的区别
- [x] 深拷贝与浅拷贝的区别
- [] 为什么我们一般会用关键字 copy 来声明 NSString 类型的属性？用 strong 会怎么样？
- [] 为什么我们会用关键字 strong 来声明 block 类型的属性？