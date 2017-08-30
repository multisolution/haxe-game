package;

import nape.geom.Vec2;
import nape.space.Space;
import openfl.display.Sprite;
import openfl.events.Event;

class Main extends Sprite
{
	private var gravity: Vec2;
	private var space: Space;
	
	public function new()
	{
		super();
		
		gravity = new Vec2(0, 1000);
		space = new Space(gravity);
		
		stage.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
	}
	
	private function onEnterFrame(event: Event)
	{
		space.step(1 / stage.frameRate);
	}
}