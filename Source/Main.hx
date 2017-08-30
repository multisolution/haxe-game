package;

import events.PlayerEvent;
import nape.geom.Vec2;
import nape.space.Space;
import openfl.display.Sprite;
import openfl.events.Event;

class Main extends Sprite
{
	public var currentLevel(get, null): Level;
	
	private var gravity: Vec2;
	private var space: Space;
	private var player: Player;
	private var levels: Array<Level>;
	private var currentLevelIndex: Int;
	
	public function new()
	{
		super();
		
		gravity = new Vec2(0, 1000);
		space = new Space(gravity);
		
		player = new Player(stage, space);
		
		currentLevelIndex = 0;
		levels = [];
		
		addLevel();
		addLevel();
		
		player.position(stage.stageWidth / 2, currentLevel.floor.top - player.halfHeight);
		
		stage.addEventListener(PlayerEvent.LADDER_COLLISION, onPlayerLadderCollision, false, 0, true);
		stage.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
	}
	
	private function addLevel(): Level
	{		
		var level: Level = new Level(stage, space, levels[levels.length - 1]);
		levels.push(level);
		return level;
	}
	
	private function get_currentLevel(): Level
	{
		return levels[currentLevelIndex];
	}
	
	private function onPlayerLadderCollision(event: PlayerEvent)
	{
		if (currentLevelIndex > 0) {
			for (level in levels) {
				level.slideDown();
			}
		}
		
		addLevel();
		player.x = currentLevel.ladder.x;
		currentLevelIndex += 1;
		player.y = currentLevel.floor.top - player.halfHeight;
		player.move();
	}
	
	private function onEnterFrame(event: Event)
	{
		space.step(1 / stage.frameRate);
	}
}