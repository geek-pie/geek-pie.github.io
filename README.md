# [WhatStack](https://whatstack.tech/)

这个是[WhatStack](https://whatstack.tech/)的源仓库。包含了所有的开源书籍以及相关的代码。WhatStack 目前基于[Hugo](https://gohugo.io/)和[Netlify](https://www.netlify.com/) 。


# 如何提交书籍
通过fork仓库的方式提交`Pull Request`。为了更好的和他人协作，比较建议的方式是：每个书籍一个分支，避免受到其他作者的影响；基本流程

1.fork一个新的分支

2.提交相关的书籍内容

3.在本地使用Hugo服务器验证你的更改

4.提交并推送你的更改到该分支

5.向主仓库提交PR，通过一旦PR被合并，更改将会在网站上生效

## 如何组织书籍
1. 在`content/books`目录下新建文件夹（如`usage`），书籍的所有内容都放在该文件夹下。
2. 在`usage`中新建`_index.md`，格式如下:
   
```yaml
---
title: "书名" 

#固定值，文件夹u根目录中的_index.md里才需要
type: book

#优先级权重，书籍列表排序，越小越靠前
weight: 1

#书籍自定义分类标签，如"NodeJS" "Java" "大数据" 等热门标签,在书籍列表中展示
tags: ["安全","云原生","出版物","独家翻译"]

#分类，展示和分类筛选（开发中）
categories: ["前端","NodeJs"]

#作者信息
author:
  title: 卖报小书童
  logo: "/images/authors/shutong.jpg"
  description: 专注前端技术

description: "本书简短的描述内容，会在书籍列表中展示"
---
```
正文内容是标准的markdown语法。

### 章节目录组织
章节目录组织，在文件夹`usage`下新建任意子文件夹，用于存放不同的章节内容，同时子文件夹也是以同样的形式无限嵌套的，用于组织多层目录，当子目录中也需要新建`_index.md`文件，才在页面上才能展示出正确的章节目录结构。
反之，无论嵌套多少文件夹，页面上都是将所有章节展示到同一层级。`_index.md`格式如下：

```yaml
---
title: "章节名or标题"

#优先级权重，章节目录排序，越小越靠前
weight: 1
---
```

### 正文
4.章节内容书写，新建md文件如`a.md`,格式如下:

```yaml
---
title: "章节名or标题" 

#优先级权重，章节目录排序，越小越靠前
weight: 1

description: "本章简短的描述内容"
---
```
剩下的就是基于markdown语法的正文内容。




## 本地预览
### Setup
1. 安装

    ```sh
    # Install NPM dependencies
    npm install
    ```

2. 本地运行hugo预览效果

    ```sh
    $ hugo server
    Web Server is available at http://localhost:1313/ (bind address 127.0.0.1)
    Press Ctrl+C to stop
    ```

然后通过 [localhost:1313](http://localhost:1313/) 预览书籍效果

# 其他提交细节
## 多级目录下gitignore
推荐使用多级目录下的.gitignore
