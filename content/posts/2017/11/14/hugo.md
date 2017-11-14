---
title: "middlemanからHugoに移行した"
date: 2017-11-14T23:48:02+09:00
tags: [ "Hugo" ]
---

middlemanとgithub.ioの構成から、[Hugo](https://gohugo.io/)とgithub pagesを利用しつつ独自ドメイン + [Cloudflare](https://www.cloudflare.com/)を利用する構成に変更してCDNでHTTPS化してもらった。

markdownのdateとtagsの形式が異なるのと、 ルート下から `posts/` 以下にブロク記事が移動したのでaliasが必要になると思う。importスクリプトがなかったので作ったほうが良さそうだったが、記事も少なかったので手作業で移行した。普通にめんどくさかった。

記事生成はmiddlemanと違って自分でパスを指定するようなのでコマンドを書いておいた。

```bash
#!/bin/bash

hugo new posts/$(date +"%Y/%m/%d")/$1.md
```

記事数が少ないので当てにならないがこのブロクの生成も爆速になって快適な気がする。

## 参考
- [ブログをMiddlemanからHugoに移行した - UKSTUDIO](http://ukstudio.jp/posts/2017/02/20/hugo/)
