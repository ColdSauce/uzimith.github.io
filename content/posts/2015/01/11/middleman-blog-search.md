---
title: middleman-blogでの検索機能をJavascript(React)で実装した。
date: 2015-01-11 14:12:00+09:00
tags: [ "middleman", "react" ] 
aliases:
- /2015/01/11/middleman-blog-search/
---

[middleman-blogの検索機能の前例](https://github.com/joelhans/middleman-search-example)はあるんですが
jQueryを利用しているため宗教上の理由により使用できません。


# 説明

最近は[React](http://facebook.github.io/react/)が気になっているのでこちらで実装しました。

こちらが[デモ](https://uzimith.github.io/middleman-blog-search-sample/)です。

![demo](post/15/0111/search.png)
前例に比べて該当部分を表示する機能も追加したので使いやすいんじゃないかと。

# 実装

ソースコードはこちらです。

[uzimith/middleman-blog-search-sample](https://github.com/uzimith/middleman-blog-search-sample)

参考にどうぞ。

## 所感
Reactのチュートリアル見ながら書いてたら簡単に書けました。
さらにちょうど先月のAdvent Calendarが分かりやすいので、いま始めやすいと思います。

[一人React.js Advent Calendar 2014 - Qiita](http://qiita.com/advent-calendar/2014/reactjs)

書き始めは双方向バインドじゃないのかと若干失望気味だったんですが、データの流れを一方向にすることでアプリケーションを複雑さを
減らすという思想が結構良いですね。一度Fluxを使った中規模アプリケーション書いてみたいです。

Reactはコンポーネント思想でつまりいろいろ飛び飛びで見なくても、その機能のすべてが集まってる、そういう感じで書く印象です。

Web Componentsと[Polymer](https://www.polymer-project.org/)が同じ思想で出来てるのかなといった感じですが、
Polymerは将来的に正しく未来のWebはこう書ければいいという夢を語る実装で、Reactは現実的に実用できる範囲で実装されているんでしょう。

いまPolymerを使うと遅すぎて話にならないですが、Web ComponentsはC++で実装されるわけですからそのうち早くなる未来が待ってるはず。

それまではコンポーネント思想ならReactですね。よさ気なライブラリです。

