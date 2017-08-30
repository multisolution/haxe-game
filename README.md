# HaxeGame

Playing with [Haxe](https://haxe.org/), [OpenFl](http://www.openfl.org/) and [Nape](http://napephys.com/).

https://multisolution.github.io/haxe-game/demo/

## NTS
- It's boring, yet very illustrative to handle a link between Nape and OpenFl
- Definitely, for a production work, it worth to use a renderer like HaxeFlixel or HaxePunk
- <strike>It's very hard to manage DPI scale</strike>

## Gave up DPI scale management

Actually, it doesn't makes sense to build a fluid layout game since players will, at least in this case, see distinct level widths which direct impacts gameplay. So we're defining `360x640` as the logical resolution, which has a 9:16 aspect ratio (or a portrait 16:9) and let it fit into the available space. Good read: https://v-play.net/doc/vplay-different-screen-sizes/
