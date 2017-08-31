package;

import motion.Actuate;
import motion.easing.Bounce;
import motion.easing.Expo;
import motion.easing.Quint;
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
	public var enemy: Enemy;
	public var whiteSpace: Rectangle;
	public var player: Player;
	public var boost: Boost;
	
	public function new(stage: Stage, space: Space, ?prevLevel: Level, player: Player) 
	{		
		floor = new Floor(stage, space);
		leftWall = new Wall(stage, space);
		rightWall = new Wall(stage, space);
		ladder = new Ladder(stage, space);
		enemy = new Enemy(stage, space);
		
		this.player = player;
		
		y = prevLevel == null ? stage.stageHeight - floor.halfHeight : prevLevel.y - 90;
		
		floor.position(stage.stageWidth / 2, y);
		leftWall.position(leftWall.halfWidth, floor.y - floor.halfHeight - leftWall.halfHeight);
		rightWall.position(stage.stageWidth - rightWall.halfWidth, floor.y - floor.halfHeight - rightWall.halfHeight);
		
		whiteSpace = new Rectangle(
			leftWall.right,
			leftWall.top,
			stage.stageWidth - leftWall.width - rightWall.width,
			leftWall.height
		);
		
		var ladderX: Float = getRandomXFor(ladder);
		ladder.position(ladderX, floor.y - floor.halfHeight - ladder.halfHeight - 30);
		
		
		var enemyX: Float = getRandomXFor(enemy);
		
		if (prevLevel != null) {
			while (enemyX >= prevLevel.ladder.x - 60 && enemyX <= prevLevel.ladder.x + 60) {
				enemyX = getRandomXFor(enemy);
			}
		} else {
			enemy.free();
		}
		
		enemy.position(enemyX, floor.top - enemy.halfHeight);
		
		boost = new Boost(stage, space);
		boost.position(
			Math.random() > 0.5 ? leftWall.right + 20 : rightWall.left - 20,
			floor.top - boost.halfHeight
		);
		
		if (Math.random() >= 0.1) {
			boost.free();
		}
	}
	
	private function getRandomXFor(entity: Entity): Float
	{
		return Std.random(Std.int(whiteSpace.width - entity.width)) + (whiteSpace.left + entity.halfWidth);		
	}
	
	
	public function slideDown(toSlide: Float)
	{
		var duration: Float = 0.3;
		
		y += toSlide;
		
		Actuate.tween(floor, duration, {y: floor.y + toSlide}).ease(Expo.easeOut);
		Actuate.tween(leftWall, duration, {y: leftWall.y + toSlide}).ease(Expo.easeOut);
		Actuate.tween(rightWall, duration, {y: rightWall.y + toSlide}).ease(Expo.easeOut);
		Actuate.tween(boost, duration, {y: boost.y + toSlide}).ease(Expo.easeInOut);
		Actuate.tween(ladder, duration, {y: ladder.y + toSlide}).delay(0.1);
		Actuate.tween(enemy, duration, {y: enemy.y + toSlide}).delay(0.1).ease(Bounce.easeOut);
	}
	
	public function free()
	{
		floor.free();
		leftWall.free();
		rightWall.free();
		ladder.free();
		enemy.free();
		boost.free();
	}
	
}