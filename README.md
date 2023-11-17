
[Geekpie](https://geekpie.chat/) 目前基于[Hugo](https://gohugo.io/)和[Netlify](https://www.netlify.com/)构建，遵循Hugo的静态文件语法。


# 如何提交专栏
目前基于`Git submodule`来拉取专栏的内容，因此专栏的内容和静态网站的内容可以完全分开。当专栏的内容可以上架时，需要fork当前仓库，并需要修改[.gitmodules](https://github.com/geek-pie/geek-pie.github.io/blob/main/.gitmodules)文件，让github能拉取到指定内容，并被hugo渲染：

```git
[submodule "content/books/usage"]
	path = content/books/usage
	url = https://github.com/geek-pie/docsy-usage.git
        # exclude = path/to/excluded_file, path/to/excluded_director，比如排除code文件夹不同步
        exclude = code/
```


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
* 忽略不需要的文件：推荐使用多级目录下的`.gitignore`
* 书中的图片和代码：在对应书籍`asserts`目录下，新建一个`images`文件夹和`code`文件夹，用来保存图片和代码

# 子模块使用（仅用于内容创作，统一放于content/books目录下）

## 添加子模块
* 在submodules.sh中添加subrepo信息：

```sh
#添加使用说明（usage）
git submodule add git@github.com:geek-pie/docsy-usage.git content/usage
```
## 更新子模块
```sh
* 一般情况无需关心这一步
git submodule update --init --recursive
```
