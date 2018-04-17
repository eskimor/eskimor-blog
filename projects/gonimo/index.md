---
title: Gonimo
author: Robert Klotzner
description: web-based baby monitor
date: 2016-01-15
tags: haskell, reflex-frp
...

This is the project I am currently working on. It is a web-based baby monitor, turning your browser into a baby monitor. We've also built a native Android version, already available on [Google Play][Gonimo Android].

It is written entirely in Haskell, including the frontend, based on [reflex][reflex] and [reflex-dom][reflex-dom].

Some related resources:

 - [The web app](https://app.gonimo.com): Try it, it's free!
 - [The Android app](Gonimo Android): Is sold for a little fee, to make the project sustainable.
 - [The Website](https://gonimo.com): Our shiny online presence.
 - [The Code][Gonimo Github]: Also if you want to have some inspiration, on howto build an app based on reflex, check out the [Gonimo Architecture][Gonimo Architecture].


Deployment of our services is accomplished via [nixops][nixops].


[Gonimo Android]: https://play.google.com/store/apps/details?id=com.gonimo.baby
[reflex]: https://github.com/reflex-frp/reflex
[reflex-dom]: https://github.com/reflex-frp/reflex-dom
[Gonimo Architecture]: /posts/2018-04-11-Gonimo-Architecture-Part1.html
[Gonimo Github]: https://github.com/gonimo/gonimo
[nixops]: https://nixos.org/nixops/
