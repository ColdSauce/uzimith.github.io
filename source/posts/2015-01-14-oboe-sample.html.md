---
title: Oboe.jsのデモ
date: 2015-01-14 23:38 JST
tags: JavaScript, Ajax, Oboe.js
---
今日は[Oboe.js](http://oboejs.com/)を触っていたのでその記事です。

# Oboe.jsとは
JSONをストリーミングで読み込むライブラリです。通常のAJAXだとJSONをすべて読み込むまで待機するため
大きいファイルを扱ったり、モバイル環境のような低速環境だったりすると読み込み完了までなんの情報も得られない
という欠点を改善してくれます。

とはいえ、いまいちピンとこないのでデモサイト作って動作確認してました。

## コード例

とりあえず[Example](http://oboejs.com/examples)を見る。

Oboe.jsの目的ではないが、AJAXライブラリとしても使える。

```javascript
oboe('/myapp/things.json')
   .done(function(things) {

      // すべて読み込みが完了した場合
   })
   .fail(function() {

      // なんらかのエラーが発生した場合
   });
```

ストリーミングで受け取るには以下

こういうJSONが来るとして

```json
{
   "foods": [
      {"name":"aubergine",    "colour":"purple"},
      {"name":"apple",        "colour":"red"},
      {"name":"nuts",         "colour":"brown"}
   ],
   "badThings": [
      {"name":"poison",       "colour":"pink"},
      {"name":"broken_glass", "colour":"green"}
   ]
}
```

oboe.node('pattern', callback)を指定する。

```javascript
oboe('/myapp/things.json')
   .node('foods.*', function( foodThing ){

      // 'foods.*'に該当する新しい要素を見つけるとこのコールバックが呼ばれる。

      console.log( 'Go eat some', foodThing.name);
   })
   .node('badThings.*', function( badThing ){

      console.log( 'Stay away from', badThing.name);
   })
   .done(function(things){

      console.log(
         'there are', things.foods.length, 'things to eat',
         'and', things.nonFoods.length, 'to avoid'); 
   });
```

oboe.path('pattern', callback)を利用することでoboe.node()よりも早く
callbackを呼び出すことができる。

```javascript
var currentPersonElement;
oboe('people.json')
   .path('people.*', function(){
      // パターンに該当する要素が存在することが分かったら
      // 中身を読み込む前にpathで指定されたコールバックを呼び出す。
      // 例えば、ここでは人物が読み込まれると分かった時点で
      // div要素を作ることで、とりあえず人物が読み込まれることをユーザーに示すことができる。
      currentPersonElement = $('<div class="person">');
      $('#people').append(currentPersonElement);
   })
   .node({
      'people.*.name': function( name ){
         // 名前を見つけた時点でdiv要素に名前を埋め込む
         currentPersonElement.append(
            '<span class="name">' + name + '</span>');
      },
      'people.*.email': function( email ){
         // メールアドレスを見つけた時点でdiv要素に名前を埋め込む
         currentPersonElement.append(
            '<span class="email">' + email + '</span>');
      }
   });
```

パターンの例が[こちら](http://oboejs.com/examples#example-patterns)

`*`が任意のオブジェクト、`!`がルートと言った感じ。

# 使ってみた

```javascript
{
    "article": [
        {
            "text": "..."
        }
        // ... (10000件)
    ]
}
```

みたいなJSONを作って読み込ませてみました。

## oboe.done()

すべて読み込んでから表示します。

```javascript
$ = require("jquery");
oboe = require("oboe");

dom = $("#articles");
dom.append("<div>start</div>");

oboe("articles.json").done(function(data) {
  data.article.map(function(article) {
    dom.prepend("<div>"+article.text+"</div>");
  })
})
```
[oboe.done()](http://uzimith.github.io/oboe-sample/done.html)

## oboe.node()

ストリーミングで表示します。

```javascript
$ = require("jquery");
oboe = require("oboe");

dom = $("#articles");
dom.append("<div>start</div>");

oboe("articles.json").node('article.*', function(article) {
  dom.prepend("<div>"+article.text+"</div>");
});
```

[oboe.node()](http://uzimith.github.io/oboe-sample/node.html)

# 所感
ローカルで試す分には回線が早すぎて関数呼び出しの分か、むしろnode()の方が
レンダリングが遅かったんですが、回線速度を下げてみると確かに順次表示されてました。
大きいJSONを読み込む際にはいいかもしれません。

