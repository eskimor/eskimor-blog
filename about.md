---
title: About me
---

I am Robert Klotzner born 1986 in Vienna (Austria). Since I learned in school
that anyone owning a computer has the means to write programs for it, I bought a
1200 pages book on C++ and was into programming. Since then I am a self taught
passionate programmer, both as a hobby and professionally. Later I also learned
Java, Python, Lua, Assembler and D. D was the first language that finally let me
leave my mother tongue (C++) behind a bit, until I finally learned Haskell and
was sold on statically typed functional programming and Haskell in particular,
embracing laziness. I had courses about Haskell at the Vienna University of
Technology and worked through a bunch of books[1][1] [2][2] [3][3].

In 2014, I became father
of twins, which resulted in me writing a baby monitor in Haskell. Then I got
invited to an "open-source innovation camp", by [Netidee][Netidee]. This led the
groundwork for Gonimo: I applied for a funding to improve on my baby monitor and make it
suitable for the general public. We did get the funding, so I paused my study on
Electrical Engineering and brought, together with some awesome
people, [Gonimo][Gonimo] to life. Gonimo is now a fully functional baby monitor,
written end-to-end in Haskell. The web version is compiled via [ghcjs][ghcjs] to
JavaScript and since recently we also have
a [native Android version][Android App] on Google play, which is compiled to ARM
assembly.

An earlier version of Gonimo was written in [PureScript][PureScript], you can find it [here][gonimo-front]. In the course of this earlier version I wrote a couple of libraries, which you might find useful:

* [purescript-bridge] : Type translation from Haskell to PureScript.
* [servant-purescript] : Translation of a [Servant API][Servant] to type-safe `PureScript` accessor functions.
* [purescript-localstorage] : Type-safe usage of the browser's local storage in `PureScript`
* [purescript-argonaut-generic-codecs] : Generic JSON encoding library which is compatible to the default encoding used by [Aeson][Aeson].
* [servant-subscriber] : Notification API to have clients informed on changes to resources on the server.

When I am not programming, I am usually with my kids. I also cycle a lot and I
do kick boxing once to twice a weak.


[1]: http://www.haskellcraft.com/craft3e/Home.html
[2]: http://book.realworldhaskell.org/
[3]: https://www.yesodweb.com/book
[Netidee]: https://www.netidee.at/
[4]: The Frontend is based on reflex and ghcjs for compiling Haskell to JavaScript.
[Android App]: https://play.google.com/store/apps/details?id=com.gonimo.baby
[ghcjs]: https://github.com/ghcjs/ghcjs
[gonimo-front]: https://github.com/gonimo/gonimo-front
[PureScript]: http://www.purescript.org/
[purescript-bridge]: https://github.com/eskimor/purescript-bridge
[servant-purescript]: https://github.com/eskimor/servant-purescript
[purescript-localstorage]: https://github.com/eskimor/purescript-localstorage
[purescript-argonaut-generic-codecs]: https://github.com/eskimor/purescript-argonaut-generic-codecs
[servant-subscriber]: https://github.com/eskimor/servant-subscriber
[Gonimo]: https://gonimo.com
[Aeson]: https://hackage.haskell.org/package/aeson
[Servant]: http://haskell-servant.readthedocs.io/en/stable/
