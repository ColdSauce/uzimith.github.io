---
title:  React.jsをCoffeeScriptとjadeで書く
date: 2015-02-13 21:00:00+09:00
tags: [ "react", "CoffeeScript", "jade" ]
aliases:
- /2015/02/13/react-jade-coffee/
---
# はじめに
- [React v0.13.0 Beta 1 | React](http://facebook.github.io/react/blog/2015/01/27/react-v0.13.0-beta-1.html)
    - React.Componentを使うと生のJSのclass形式でReact Componentを定義できる
- [reactjs - react-jadeでjadeテンプレートから仮想DOMを出力する - Qiita](http://qiita.com/mizchi/items/4e17b54cd9cc70d747cc)
    - JSXのXの部分をjadeで書けるようにするライブラリ (Jade -> React VDOM)

ここあたりの記事を読んでRiot.jsなら素でできるCoffeeScriptとJadeの組み合わせがReactでも出来そうだと気づいたので試行錯誤中、
よさ気な書き方を見つけた話です。


# 結論

こうです。

https://gist.github.com/uzimith/145a0cf8e342dc46ac96

```coffee
React = require('react')
jade = require('react-jade')
_ = require('lodash')

class Counter extends React.Component
  constructor: ->
    @state =
      count: 0
  tick: =>
    @setState count: @state.count + 1
  render: =>
    jade.compile("""
      #counter
        span Count :
        button(onClick=tick)= count
    """)(_.assign {}, @, @props, @state)

React.render(React.createFactory(Counter)(), document.getElementById('container'))
```

React.jsの俺的主なキツさの原因である今どき生HTML, なんかめっちゃ多いthis, React.CreateComponet, getInitialStateとかいう意味不明なメソッド等々が
まとめて解決されて良さそうです。

### コメント

Qiitaを見ていたら@mizchiさんがreact-jadeを使ってるとのことで下記のプロジェクトを見てたら
`template(_.extend {}, @, @props, @state)`とjadeテンプレートを呼び出していました。

thisに定義されている関数とpropsとstateの値をマージしてテンプレートに渡す手法がまさに自分の求めていたものでさすが利用者は違いますね。

[俺専用ReactのSVGスケッチ環境作った - mizchi's blog](http://mizchi.hatenablog.com/entry/2015/02/02/004728)

react-jadeにはjade.compileFile()といった関数もあるのでいざとなったらテンプレートのファイル分割も簡単にできるのも利点になりそうです。

## browserifyで使ってるライブラリ

- [jadejs/react-jade](https://github.com/jadejs/react-jade)
- [jnordberg/coffeeify](https://github.com/jnordberg/coffeeify)

まだreact-jadeがreact v0.13 betaに対応していないので依存関係削除してインストールしてますが
多分問題無いと思うのでリリースされたら対応されるんじゃないでしょうか。

## 所感
React.CreateElementやReact.DOMなどを生で駆使するとか[ラッパーを書いて頑張る](http://qiita.com/mizchi/items/811fb25372ce2f12783e)とか考えたんですが
他で定義したコンポーネントがタグを書くだけで呼び出せるあたり、この手法が一番良さそうです。
