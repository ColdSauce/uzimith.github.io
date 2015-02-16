---
title: Javscriptのクラス対応(=React 0.13対応)のFlummoxを試してみた
date: 2015-02-16 09:42 JST
tags: react, flummox, flux
---

[前回の記事](http://uzimith.github.io/2015/02/13/react-jade-coffee/)で快適なReact環境を手に入れることが出来た私ですが、Fluxを導入しようとして壁にぶち当たりました。

[Fluxxor](http://amagitakayosi.hatenablog.com/entry/fluxxor-introduction)などの有名なFlux実装などは
StoreとComponentの紐付けに従来のMixinを利用することが前提となっていますが、ReactにおいてMixinはReact.Componentを利用していると使えません。

ちょっとGithubを見ていたら[acdlite/flummox](https://github.com/acdlite/flummox)が特徴にReact 0.13対応だと書いてあったのでとりあえずTodoを実装しました。

- [Todoデモ](http://uzimith.github.io/flux-practice/react/)
    - [ソースコード](https://github.com/uzimith/flux-practice/tree/gh-pages/react)

## 簡単な説明

### Actions

```coffee
class TodoActions extends Actions
  createTodo: (text) ->
    id = (+new Date() + Math.floor(Math.random() * 999999)).toString(36)
    {
      id: id
      text: text
      complete: false
    }
```

関数の返り値が自動的にDispatcherに送られる。(undefinedを送るとDispatcherに無視されるので注意)

### Store

```coffee
class TodoStore extends Store
  constructor: (flux) ->
    super
    todoActions = flux.getActionIds('todo')
    @register(todoActions.createTodo, @handleNewTodo)
    @state = {
      todos: {
        1: {
          id: 1
          complete: true
          text: "hoge"
        }
      }
    }

  handleNewTodo: (todo) =>
    todos = @state.todos
    todos[todo.id] = todo
    @setState todos: todos
```

React.Componentっぽく書ける。setState()すると自動的にDispatcherにemitされ紐付いたComponentが更新される。

@register(actionId, handler)でDispatcherにhandlerが登録される。
ActionsIdが示すアクションの返り値がDispatcherを介してhandlerの引数となりhandlerが実行される。

handlerは関数だったらなんでもいいらしいが、普通にメソッドを渡すといい。

### Flux

```coffee
class AppFlux extends Flux
  constructor: ->
    super
    @createActions('todo', TodoActions)
    @createStore('todo', TodoStore, @)
```
createActions(key, ActionsClass, ...args)とcreateStore(key, StoreClass, ...args)でActionsとStoreが登録できる。argsはそれぞれcreateするときの
引数になる(この場合Storeの方はnew TodoStore(this)となる)

このインスタンスのメソッドgetActions(key)やgetStore(key)を呼び出すとActionsやStoreのインスタンスが返ってくる。

### Component
あとは`flux = new AppFlux()`してComponentを書いていく。

```coffee
React.render(React.createFactory(Application)(flux: flux), document.getElementById('container'))
```

```coffee
class Application extends React.Component
  render: =>
    jade.compile("""
      FluxComponent(flux=flux connectToStores=['todo'])
        TodoPanel
    """)(_.assign(@, @props, @state))
```

`FluxContainer flux=flux connectToStores=[key]`とするとStoreの@stateがFluxComponentの@propsになる。だから、中のComponentから参照できる。

(この理解が微妙に適当。親のpropsをなんで参照できるのか分かってないまま書いた)

FluxComponentは別に配列じゃなくてもいい。

```coffee
FluxComponent connectToStores={{
  posts: store => ({
    post: store.getPost(this.props.post.id),
  }),
  comments: store => ({
    comments: store.getCommentsForPost(this.props.post.id),
  })
}}
```

Actionを呼び出すときは`@props.flux.getActions("todo").createTodo(@state.newTodoText)`といった感じ。

## 所感
こんな感じにFLux書きたかった。

Facebookのfluxは初見の私には魔法の言葉が飛び交っているようにしか見えなかったです。

## 参考
- [flummox/quick-start.md at master · acdlite/flummox](https://github.com/acdlite/flummox/blob/master/docs/quick-start.md)
- [flummox/react-integration.md at master · acdlite/flummox](https://github.com/acdlite/flummox/blob/master/docs/react-integration.md)
