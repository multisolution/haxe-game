package;

import nape.geom.Vec2;
import nape.space.Space;
import openfl.display.Sprite;
import openfl.events.Event;

class Main extends Sprite
{
	private var gravity: Vec2;
	private var space: Space;
	private var player: Player;
	private var floor: Floor;
	
	public function new()
	{
		super();
		
		gravity = new Vec2(0, 1000);
		space = new Space(gravity);
		
		player = new Player(stage, space);
		player.position(stage.stageWidth / 2, stage.stageHeight / 2);
		
		floor = new Floor(stage, space);
		floor.position(stage.stageWidth / 2, stage.stageHeight - floor.halfHeight);
		
		stage.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
	}
	
	private function onEnterFrame(event: Event)
	{
		space.step(1 / stage.frameRate);
	}
}