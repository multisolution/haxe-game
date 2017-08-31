# HaxeGame

Playing with [Haxe](https://haxe.org/), [OpenFl](http://www.openfl.org/) and [Nape](http://napephys.com/).

https://multisolution.github.io/haxe-game/demo/

## NTS
- Missing something to globally handle collisions, maybe a `InteractionManager` what would avoid custom events like `PlayerEvent` and handling `Enemy` collisions to the `Wall` inside the `Player`
- It's boring, yet very illustrative to handle a link between Nape and OpenFl
- Definitely, for a production work, it worth to use a renderer like HaxeFlixel or HaxePunk
- <strike>It's very hard to manage DPI scale</strike>

## Gave up DPI scale management

Actually, it doesn't makes sense to build a fluid layout game since players will, at least in this case, see distinct level widths which direct impacts gameplay. So we're defining `360x640` as the logical resolution, which has a 9:16 aspect ratio (or a portrait 16:9) and let it fit into the available space. Good read: https://v-play.net/doc/vplay-different-screen-sizes/

## 🎨 Looking for some graphic assets

The main ideia is a **8-bit**, e.g.:
* https://dribbble.com/shots/3156576-Rocketbank-Characters-Jump-cycle
* https://dribbble.com/shots/113217-Out-erspace-casts
* https://dribbble.com/shots/639611-Don-t-Call-It-A-Sequel
* https://dribbble.com/shots/2553152-Booking-com
* https://dribbble.com/shots/2316427-Asics-GEL-LYTE-III
* https://dribbble.com/shots/40116-Frank-s-walk-cycle
* https://dribbble.com/shots/44530-Grubeway
* https://dribbble.com/shots/2753260-Donkey-Kong-s-35th-Anniversary
