package;

import nape.geom.Vec2;
import nape.space.Space;
import openfl.display.Stage;

class Level 
{
	public var y: Float;
	public var floor: Floor;
	public var leftWall: Wall;
	public var rightWall: Wall;
	public var ladder: Ladder;
	
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