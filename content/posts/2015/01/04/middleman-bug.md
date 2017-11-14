---
title: middlemanでファイルを書き換えてもサーバーに反映されない。
date: 2015-01-04 12:32:00+09:00
tags: [ "middleman" ]
aliases:
- /2015/01/04/middleman-bug/
---

- OS X Yosemite 10.10.1
- ruby 2.1.2p95 (2014-05-08 revision 45877) [x86_64-darwin14.0]
- middleman (3.3.7)

middlemanいじってもconfig.rbやhelperメソッド書き換えても反映されなくて違和感を覚えていたらOSXのバグらしき報告がありました。

[Middleman 3.0 requires manual server restart for any change in config.rb or middleman-blog · Issue #595 · middleman/middleman](https://github.com/middleman/middleman/issues/595)

なるほどと思って、再起動したらLiveReloadが動かなくなりました。なるほど。

確かにサーバーの再起動してるよりは[手動で更新する](https://github.com/tell-k/vim-browsereload-mac)方がはるかにマシなんですが。

### 追記(15/01/06)
やっぱり不安定で現象が再現しないですね。

サーバー再起動せずに設定が反映されない/LiveReloadが動かない

といった感じなんですが時たま反応していて困ります。

### 結局

上のページ曰く
「原因はOS X FSEvents bugなんじゃないか」「サーバーの問題なのでは、Powで動かしたい」「Powはv4で対応予定」
とかなんとか。v4が今alpha6なので待っているといいかもしれません。
