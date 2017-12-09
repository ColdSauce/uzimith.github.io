---
title: "jqでAlfred Workflowを作る"
date: 2017-12-09T18:36:19+09:00
tags: [ "Alfred" ]
---

AlfredにはWorkflowというものがあって[Powerpack](https://www.alfredapp.com/powerpack/buy/)を購入したユーザーが使える。

いろいろあるので[Awsome Workflow](https://github.com/derimagia/awesome-alfred-workflows)のリンクを貼っておく。

とてもいいアプリなので35ユーロになるけど、Mega Supppoterを購入することをおすすめする。`Free lifetime Upgrades` のオプションになる。

Workflowは、コードを見ると[PHP実装](https://github.com/willfarrell/alfred-caniuse-workflow/blob/master/src/caniuse.php)だったり、[Ruby実装](https://github.com/carlosgaldino/alfred-emoji-workflow/blob/master/emoji.rb)だったりで作るのがめんどくさそうにみえる。

今回は、そういった言語を使わなくてもスクリプトを組み合わせるだけでAPIを使ったWorkflowを[Script Filter JSON Format](https://www.alfredapp.com/help/workflows/inputs/script-filter/json/)を使うことで簡単に作った話をしようと思う。

Script Filterは標準出力に以下のような出力を行なうだけでいい。

## JSON

### サンプル

```json
{
  "items": [
    {
      "uid": "desktop",
      "type": "file",
      "title": "Desktop",
      "subtitle": "~/Desktop",
      "arg": "~/Desktop",
      "autocomplete": "Desktop",
      "icon": {
        "type": "fileicon",
        "path": "~/Desktop"
      },
      "mods": {
        "alt": {
          "valid": true,
          "arg": "https://alfredapp.com/powerpack",
          "subtitle": "https://www.alfredapp.com/powerpack/"
        },
        "cmd": {
          "valid": true,
          "arg": "https://alfredapp.com/powerpack/buy/",
          "subtitle": "https://www.alfredapp.com/powerpack/buy/"
        }
      }
    }
  ]
}
```

## 属性

| key | type | description |
|-----|------|-------------|
| uid | string | alfredのソート機能のために振るunique id |
| type | string | fileをしているとAlfredにファイルとして扱われる（「Finderで開く」アクションが有効になるなど） |
| title | string | リストの一行目 |
| subtitle | string | リストの二行目 |
| arg | string | 次のブロックへ渡る値（引数） |
| autocomplete | string | オートコンプリート（Tabキー）を押したときに補完されるテキスト |
| icon | object | 画像　※ pathにはURLを指定できない |
| valid | boolean | Enterキーをおした時に反応するか |
| mods | obejct | 指定したキーをおした時に `valid` , `arg` , `subtitle` を切り替えれる |

### 試しに動かしてみる。

Script Filterを作る。

![Screen Shot](resources/B07905BD7FE1B3451B332EDF42996BFF.png)

スクリプトは標準出力に指定された形式のJSONを出力するだけでいい。とりあえず `echo '{sample json}'` といった感じ。

![Screen Shot](resources/8BD922ACF7F382D10D6FC67044433510.png)

Workflow全体はこんな感じになっているのが基本だと思う。

![Screen Shot 2017-12-09 at 16.19.43.png](resources/CA62C2114AE29489A3D4DE875E924963.png)

URLだったらブラウザで開き、それ以外だったら通知とともにクリップボードにはいる。

それぞれのオブジェクトの設定は以下のような感じ

#### Filter

URLではないフィルター: `{query}` matches regex `^(?!http)`

![Screen Shot](resources/554B37B3895B848D5BCC84453BB8074C.png)

URL フィルター: `{query}` matches regex `^http`

![Screen Shot](resources/630547CF3C6122ED897638B63934CA97.png)

#### Outputs

通知の設定

![Screen Shot](resources/FBAB4F9C91BC2FDF1261C98001306469.png)

動作はこんな感じになる。

![hoge.gif](resources/1E8EA42839CD09FFAD38268F6CB62B8E.gif)

あとはいい感じのJSONをなにかしらで生成するといい。curlと[jq](https://stedolan.github.io/jq/)が手軽に使えておすすめ。

今回は天気予報 Workflowsを作ろうと思うので[Open Weather Map](https://openweathermap.org/)のAPIを叩いてみた。

```bash
$ curl -s "http://api.openweathermap.org/data/2.5/forecast?q=Tokyo&units=metric&&lang=ja&appid=[appid]" | jq . > tenki.json
```

このJSONをさきほどのJSONに合うようにjqで整形する。

```json
$ cat tenki.json | /usr/local/bin/jq '{
    items: (
        .list | map({
            title: .dt_txt,
            subtitle: "\(.weather[].description) \(if .rain == {} or .rain == null then 0 else .rain["3h"] end)mm \(.main.temp)℃"
        })
    )
}'
{
  "items": [
    {
      "title": "2017-12-09 09:00:00",
      "subtitle": "晴天 0mm 4.7℃"
    },
...
```

これをScript Filterのスクリプトにする。

```
curl -s "http://api.openweathermap.org/data/2.5/forecast?q={query}&units=metric&&lang=ja&appid=[appid]" | /usr/local/bin/jq '{
    items: (
        .list | map({
            title: .dt_txt,
            subtitle: "\(.weather[].description) \(if .rain == {} or .rain == null then 0 else .rain["3h"] end)mm \(.main.temp)℃"
        })
    )
}'
```

これで東京の天気を表示してみる。

![Screen Shot](resources/93B94519343B63BFA78E78B2EC5D5FE4.png)

今回作ったWorkflowはこちら。APIキーは`[appid]`のままなのでそのままでは動かない。

[tenki.alfredworkflow](resources/616D77B6BEB7D2EB173BB2E9CDE8FC65.alfredworkflow)

すげーしょうもないサンプルコードになってしまったので、魅力が伝わらないかもしれない。
自分は社内の管理画面を開くのが面倒だったのでそれを簡単にAlfred Workflow化したりして便利だった。



## 所感

ビジュアルプログラミングだったの画像を貼る必要があり記事を書くのが億劫だった。ただ、すごく便利だと思うので、何かしら便利なWorkflowが作れたら公開してほしい。自分が使いたいので。

## 参考
- [jq コマンドを使う日常のご紹介 - Qiita](https://qiita.com/takeshinoda@github/items/2dec7a72930ec1f658af)
  - jqは便利
