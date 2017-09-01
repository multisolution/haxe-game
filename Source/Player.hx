package;

import events.PlayerEvent;
import haxe.Timer;
import motion.Actuate;
import nape.callbacks.CbEvent;
import nape.callbacks.CbType;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.callbacks.OptionType;
import nape.geom.Vec2;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.shape.Polygon;
import openfl.Assets;
import openfl.display.DisplayObject;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.events.TouchEvent;

class Player extends Entity
{	
	public var speed: Float = 200;
	public var isJumping: Bool = false;
	public var isBoosted: Bool = false;
	
	private var jumpPower: Float = 150;
	
	override function init() 
	{		
		width = 16;
		height = 30;
		
		type = BodyType.DYNAMIC;
		verts = Polygon.box(width, height);
		
		detectCollision(CbTypes.PLAYER, CbTypes.WALL, onWallCollision);
		detectCollision(CbTypes.PLAYER, CbTypes.FLOOR, onFloorCollision);
		detectCollision(CbTypes.PLAYER, CbTypes.LADDER, onLadderCollision);
		detectCollision(CbTypes.PLAYER, CbTypes.ENEMY, onEnemyCollision);
		detectCollision(CbTypes.ENEMY, new OptionType(CbType.ANY_BODY, CbTypes.FLOOR), onEnemyWallCollision);
		detectCollision(CbTypes.PLAYER, CbTypes.BOOST, onBoostCollision);
		
		stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
	}
	
	override function create() 
	{
		super.create();
		
		body.cbTypes.add(CbTypes.PLAYER);		
		body.allowRotation = false;
		
		shape.material.dynamicFriction = 0;
		
		move();
	}
	
	override function render(): DisplayObject 
	{
		return Assets.getMovieClip("library:Minazinha");
	}
	
	public function move()
	{
		body.velocity.x = speed;
	}
	
	public function jump(): Bool
	{		
		if (isJumping) {
			return false;
		}
		
		body.applyImpulse(new Vec2(0, -jumpPower));
		return isJumping = true;
	}
	
	public function boost()
	{
		isBoosted = true;
		Actuate.tween(display, 0.3, {alpha: 0.3}).repeat(6).reverse().onComplete(stopBoost);
	}
	
	public function stopBoost()
	{
		isBoosted = false;
	}
	
	
	private function onWallCollision(collision: InteractionCallback)
	{
		speed *= -1;
		display.scaleX *= -1;
		move();
	}
	
	private function onFloorCollision(collision: InteractionCallback)
	{
		isJumping = false;
	}
	
	private function onLadderCollision(collision: InteractionCallback)
	{
		stage.dispatchEvent(new PlayerEvent(PlayerEvent.LADDER_COLLISION));
	}
	
	private function onEnemyCollision(collision: InteractionCallback)
	{
		var enemy: Enemy = cast(collision.int2.userData.entity, Enemy);
		
		if (shouldKill(enemy)) {
			enemy.free();
			move();
			return;
		}
		
		stage.dispatchEvent(new PlayerEvent(PlayerEvent.ENEMY_COLLISION));
	}
	
	private function shouldKill(enemy: Enemy): Bool
	{		
		if (isBoosted) {
			return true;
		}
		
		var tolerence: Int = 3;		
		return Math.floor(bottom) - tolerence <= Math.ceil(enemy.top);
	}
	
	private function onEnemyWallCollision(collision: InteractionCallback)
	{
		var enemy: Enemy = cast(collision.int1.userData.entity, Enemy);
		enemy.bounce();
	}
	
	private function onBoostCollision(collision: InteractionCallback)
	{
		var mBoost: Boost = cast(collision.int2.userData.entity, Boost);
		mBoost.free();
		boost();
		move();
	}
	
	private function onMouseDown(event: MouseEvent)
	{
		jump();
	}
}