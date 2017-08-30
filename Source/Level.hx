package;

import nape.geom.Vec2;
import nape.space.Space;
import openfl.display.Stage;

class Level 
{
	public var y: Float;
	
	private var floor: Floor;
	private var leftWall: Wall;
	private var rightWall: Wall;
	private var ladder: Ladder;
	
	public function new(stage: Stage, space: Space, ?prevLevel: Level) 
	{		
		floor = new Floor(stage, space);
		leftWall = new Wall(stage, space);
		rightWall = new Wall(stage, space);
		ladder = new Ladder(stage, space);
		
		y = prevLevel == null ? stage.stageHeight - floor.halfHeight : prevLevel.y - 80;
		
		floor.position(stage.stageWidth / 2, y);
		leftWall.position(leftWall.halfWidth, floor.y - floor.halfHeight - leftWall.halfHeight);
		rightWall.position(stage.stageWidth - rightWall.halfWidth, floor.y - floor.halfHeight - rightWall.halfHeight);
		ladder.position(Std.random(stage.stageWidth), floor.y - floor.halfHeight - ladder.halfHeight - 20);
	}
	
	public function positionPlayer(player: Player)
	{
		player.position(floor.x, floor.y - floor.halfHeight - player.halfHeight);
	}
	
	public function slideDown()
	{
		var toSlide: Int = 80;
		
		y += toSlide;
		floor.body.position.y += toSlide;
		leftWall.body.position.y += toSlide;
		rightWall.body.position.y += toSlide;
		ladder.body.position.y += toSlide;
	}
	
}