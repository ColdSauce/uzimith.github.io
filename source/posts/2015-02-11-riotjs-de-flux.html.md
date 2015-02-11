---
title: Riot.jsでFluxのデモ実装した。
date: 2015-02-11 22:32 JST
tags: riotjs,flux
---

フロントエンド開発でコンポーネント指向で書きたいのは間違いないんですが、
Reactは簡単な事をするのにも大量のコードを必要として手軽に書くのには辛いライブラリだと思っていたところ、
Qiitaで[よさ気なライブラリ](https://muut.com/riotjs/)が話題になってました。

- [Riot.js 2.0 を触ってみた — まだReactで消耗しているの? - Qiita](http://qiita.com/cognitom/items/fb1295f3f93911e9e92d)
- [Riotjsのいいところ - Qiita](http://qiita.com/jgs/items/afa7bca6d4d88812b7e4)

もともと[flux](https://github.com/facebook/flux)のデモコードがまったく理解できなくて悩んでいたところだったので2つのデモを実装しました。

- [Todo](http://uzimith.github.io/flux-practice/todo/)
- [Chat](http://uzimith.github.io/flux-practice/chat/)

https://github.com/uzimith/flux-practice

## Fluxについて

fluxのコンセプトについては[公式サイト](http://facebook.github.io/flux/docs/overview.html)読んでても全く理解できなかったので、下のサイトを見て覚えました。

- [Fluxアーキテクチャの覚え書きを書いた - snyk_s log](http://saneyukis.hatenablog.com/entry/2014/09/26/174750)
- [Fluxとはなんだったのか + misc at 2014 - snyk_s log](http://saneyukis.hatenablog.com/entry/2014/12/24/014421)
- [What the flux?](http://jonathancreamer.com/what-the-flux/)


Actionが(ユーザーの)動作、DispatcherがObserver、StoreがModelでAction -> Dispatcher -> Store -> Viewの一方通行でデータが動くと思えば大体合ってる気がします。

しかし、いまだにWEB APIがActionCreaterから呼び出される利点が未だに分かってないです。Storeで隠蔽してもいいと思うんですが。
複数のStoreを叩く必要があるAPI呼び出しを書く際に困らない、のかなといったところ。
