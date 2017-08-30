package;

import nape.space.Space;
import openfl.display.Stage;

class Level 
{
	private var floor: Floor;
	private var leftWall: Wall;
	private var rightWall: Wall;
	
	public function new(stage: Stage, space: Space, index: Int = 0) 
	{		
		floor = new Floor(stage, space);
		leftWall = new Wall(stage, space);
		rightWall = new Wall(stage, space);
		
		var bottom: Float = (stage.stageHeight - floor.halfHeight) - (index * 100);		
		
		floor.position(stage.stageWidth / 2, bottom);
		leftWall.position(leftWall.halfWidth, floor.y - floor.halfHeight - leftWall.halfHeight);
		rightWall.position(stage.stageWidth - rightWall.halfWidth, floor.y - floor.halfHeight - rightWall.halfHeight);
	}
	
}