## 如何写书
1. 在content/cn/docs目录下新建文件夹（如usage），书籍的所有内容都放在该文件夹下（为了方便将该文件夹简称u）。
2. 在上述文件夹u中新建_index.md，格式如下
```toml
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

description: "本书简短的描述内容，在书籍列表中展示"
---
 md格式正文内容，如本书的大纲，和详细介绍可放在这里

```
3. 章节目录组织，在文件夹u下新建任意子文件夹，用于存放不同的章节内容，同时子文件夹也是以同样的形式无限嵌套的，用于组织多层目录，当子目录中也新建_index.md文件时，在页面上才能展示出正确的章节目录结构。反之，无论嵌套多少文件夹，页面上都是将所有章节展示到同一层级。_index.md格式如下：
```toml
---
title: "章节名or标题" 

#优先级权重，章节目录排序，越小越靠前
weight: 1

description: "本章简短的描述内容"
---
 md格式正文内容，如本章的大纲，和详细介绍可放在这里

```
4.章节内容书写，新建md文件如a.md,格式如下:

```toml
---
title: "章节名or标题" 

#优先级权重，章节目录排序，越小越靠前
weight: 1

description: "本章简短的描述内容"
---
 md格式正文内容，该章具体内容

```

## Repo organization

This is a [hugo](https://gohugo.io) statically-generated site, hosted
on [netlify](https://netlify.com).  The site is automatically built by
netlify (see netlify.toml and build.sh).

All site content is stored in the `content` directory in markdown format.

```text
content/cn
├── _index.md    # home page 
├── blog         # Blog posts
├── docs         # Documentation pages
└── search.md
```

## Contributing

### Setup

1. Clone and setup

    ```sh
    # Install NPM dependencies
    npm install
    ```

2. Run Hugo server

    ```sh
    $ hugo server
    Web Server is available at http://localhost:1313/ (bind address 127.0.0.1)
    Press Ctrl+C to stop
    ```

You can visit [localhost:1313](http://localhost:1313/) in browser to preview website.

### Making changes

1. Create a new branch
2. Make your changes
3. Verify your changes locally with Hugo server
4. Commit and push your changes to the branch
5. Raise a PR to default branch, verify changes with Netlify preview URL
6. Once PR is merged, your changes would be live on the site


# 多级目录下gitignore
推荐使用多级目录下的.gitignore