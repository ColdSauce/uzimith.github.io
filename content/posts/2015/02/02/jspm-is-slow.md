---
title: jspmって遅い？
date: 2015-02-02 01:30:00+09:00
tags: [ "JavaScript" ]
aliases:
- /2015/02/02/jspm-is-slow/
---
# jspmについて
みなさん[jspm](http://jspm.io/)ってご存知ですか。
自分はQiitaの記事で知ったんですけど。

[jspm で快適 javascript 生活（クライアントサイド JS の依存管理決定版） - Qiita](http://qiita.com/hrsh7th@github/items/0a225c46ba17196b9a55)

[ES6 module loader](https://github.com/ModuleLoader/es6-module-loader)を利用してES6のimport文で前もってダウンロードしていたパッケージを読み込む仕組みになってるみたいです。依存も解決してくれるし特にnpmでもgithubでも[bowerでも](https://github.com/guybedford/jspm-bower)インストールできるのが明らかな優位な点っぽいです。

# importって速度的に大丈夫なの？
`jspm init`ってやると`config.js`と`es6-module-loader.js`とかが入った`jspm_packages`のフォルダが生成されるんですが、そんないろんなファイルをインポートして遅くならないかなって
思い`jspm slow`とかでぐぐてみたんですけど特に計測してるサイトとか無かったのでまあ問題ないものかなとReactを書き始めてみました。
すると表示が明らかに待たされて違和感バリバリだったのでwatchifyでも変換したファイルを読み込む場合とくらべてみました。

## jspmの場合
<div class="video">
    <iframe width="560" height="315" src="https://www.youtube.com/embed/XS4vxqguf1U?rel=0" frameborder="0" allowfullscreen></iframe>
</div>

https://github.com/uzimith/flux-todo-practice/tree/692aa4eb33afd1fd372d51da10b517db4384d0d7

1.30 s

# watchifyの場合

<div class="video">
    <iframe width="560" height="315" src="https://www.youtube.com/embed/pwv-8zQddBE?rel=0" frameborder="0" allowfullscreen></iframe>
</div>

https://github.com/uzimith/flux-todo-practice/tree/4d2bc63b8026cdc42ebb5d2bac99733eecb188b9#

275 ms

さすがに文字を出すだけでこの速度になるようでは実用性に欠けるのではないかと思っていたところ[Prodoction環境用のファイル生成法](https://github.com/jspm/jspm-cli/wiki/Production-Workflows)がありました。
`jspm bundle`して`build.js`を作って読み込ませるといいらしい。

<div class="video">
    <iframe width="560" height="315" src="https://www.youtube.com/embed/2fM2tmrqxjk?rel=0" frameborder="0" allowfullscreen></iframe>
</div>

324 msと、かなり早くなりました。とはいえwatchifyは250ms前後で安定してるのでこのコードの場合はwatchifyの生成するコードの方が若干速いです。

# 所感
jspmでもbundleすれば十分速度が出るっぽいです。実はトップページを目を通せばひと目でわかることなんですが。

    For production, optimize into a bundle, layered bundles or a self-executing bundle with a single command.

とはいえ自分的には開発中レンダリングが遅いほうが苦になるのが目に見えてるし、JSXで書くために[パスの指定が`.jsx!`になる](https://github.com/floatdrop/plugin-jsx)とださいし、
6to5ify,reactify,uglifyなどwatchifyで機能性は十分、むしろ高いとjspmを使う理由は見当たらないといったところです。

ビルドのほうが時間がかかるということならjspmのほうがいいと思いますが、大規模なプロジェクトとかだとそうなんですかね？

