package;

import motion.Actuate;
import nape.geom.Vec2;
import nape.space.Space;
import openfl.display.Stage;
import openfl.geom.Rectangle;

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
		
		
		var whiteSpace: Rectangle = new Rectangle(
			leftWall.right,
			leftWall.top,
			stage.stageWidth - leftWall.width - rightWall.width,
			leftWall.height
		);
		
		var randomLadderY: Float = Std.random(Std.int(whiteSpace.width - ladder.width)) + (whiteSpace.left + ladder.halfWidth);		
		ladder.position(randomLadderY, floor.y - floor.halfHeight - ladder.halfHeight - 20);
	}
	
	public function slideDown(toSlide: Float)
	{
		y += toSlide;	
		Actuate.tween(floor, 1, {y: floor.y + toSlide});
		Actuate.tween(leftWall, 1, {y: leftWall.y + toSlide});
		Actuate.tween(rightWall, 1, {y: rightWall.y + toSlide});
		Actuate.tween(ladder, 1, {y: ladder.y + toSlide}).delay(0.1);
	}
	
	public function free()
	{
		floor.free();
		leftWall.free();
		rightWall.free();
		ladder.free();
	}
	
}