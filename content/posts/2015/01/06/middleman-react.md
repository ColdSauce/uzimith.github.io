---
title: middlemanでReactを書く
date: 2015-01-06 11:47:00+09:00
tags: [ "middleman", "react" ] 
aliases:
- /2015/01/06/middleman-react/
---

Javascriptのライブラリといえば[AngularJS](https://angularjs.org/)とか[vue.js](http://vuejs.org/)などが流行っていますが
今回はさらなる流行の最先端[React](http://facebook.github.io/react/)です。

というわけで書き始めようと思うのですが、書き方がいろいろあって一番簡単なのはCDNを使うことです。

```html
<script src="http://fb.me/react-0.11.1.js"></script>
<script src="http://fb.me/JSXTransformer-0.11.1.js"></script>
<script type="text/jsx;harmony=true">

//ここに書ける

</script>
```

さすがにコレはリアルタイムでコンパイルしているので遅くなるみたいです。

普通こういったJavascriptライブラリを書くとなると[Gulp](http://gulpjs.com/)を使うことになりますが
ちょっと気持ちが萎える(Gulp好きじゃない)わりにいい感じにMiddlemanと協調するGulpfileを書けなかった(だからキライ)ので
もうmiddlemanに処理させたいと思います。

というかいまMiddlemanで書いてるんだから、よしなに頑張ってくれ。

というわけで[middleman-react](https://github.com/plasticine/middleman-react)です。
公式の[reactjs/react-rails](https://github.com/reactjs/react-rails)にインスパイアされた(ていうかパクった)middleman拡張です。


### Gemfile
```ruby
gem "middleman-react"
```

### config.rb
```ruby
activate :react, harmony: true
after_configuration do
  sprockets.append_path File.dirname(::React::Source.bundled_path_for('react.js'))
end
```

### source/javascripts/all.js
```ruby
//= require react-with-addons
//= require_tree .
```

あとは`javascripts`配下に`.js.jsx`ファイルを追加していくといい感じに書けます。

簡単ですね。

HTMLのbodyの最後とかで下みたく書いたりとかすればいいんじゃないかと。

### hoge.slim
```slim
#hogehoge
= javascript_include_tag "all"
```

ところでmiddleman-reactの`harmony`オプションですが、もともと見当たらなかったので私が追加しました。

ES6やES7の構文がコンパイルできるようになります。

つまり下記が使えるようになります。実はあまり調べてませんが。

- es6-arrow-functions
- es6-object-concise-method
- es6-object-short-notation
- es6-classes
- es6-rest-params
- es6-templates
- es6-destructuring
- es7-spread-property

[https://github.com/facebook/react/blob/master/vendor/fbtransform/visitors.js](https://github.com/facebook/react/blob/master/vendor/fbtransform/visitors.js)

[アロー関数](https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/arrow_functions)や[テンプレートリテラル](http://tc39wiki.calculist.org/es6/template-strings/)は便利なのでぜひお使いください。

## 所感
簡単に導入できるのはいいんですがやっぱり`require`が使いたくなってきますね。
[superagent](https://github.com/visionmedia/superagent)なんかは`require`できないと使えないです。

ここあたりのJavascriptライブラリのベストプラクティスが分からなくていつも困ってます。

今思っているのはGuardから[watchify](https://github.com/substack/watchify)を呼び出すのが汎用的な解決なんじゃないかなってことです。試してないですが。
