---
title: "jqでAlfred Workflowを作る"
date: 2017-12-04T13:49:19+09:00
tags: [ "Alfred" ]
---

Alfredの拡張は、[Script Filter JSON Format](https://www.alfredapp.com/help/workflows/inputs/script-filter/json/)を使うことで簡単に作れる話をしようと思う。

Script Filterによって標準出力に以下のような出力を行なうだけでいい。

```
{"items": [
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
        }
    }
]}
```

uidはalfredのソート機能のために振るunique id

