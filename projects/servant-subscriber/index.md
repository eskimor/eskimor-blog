---
title: servant-subscriber
author: Robert Klotzner
description: Get notifiied about changes in a Servant endpoint.
date: 2016-04-03
tags: haskell, purescript, servant
...

[Servant][servant] is a Haskell library, making it possible to specify REST web APIs on the type level. `servant-subscriber` allows clients to subscribe to endpoints in order to get notified about changes by the server via a `WebSocket` connection. [servant-purescript][servant-purescript] is capable of generating the necessary functions for issuing change subscriptions.

Related resources:

 - [The code](https://github.com/eskimor/servant-subscriber)
 - [Hackage Package](http://hackage.haskell.org/package/servant-subscriber)
 - [Stackage](https://www.stackage.org/package/servant-subscriber)

[servant]: http://haskell-servant.readthedocs.io/en/stable/
[servant-purescript]: /projects/servant-purescript/index.html
