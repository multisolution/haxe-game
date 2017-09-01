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
	public var speed: Float = 225;
	public var isJumping: Bool = false;
	public var isBoosted: Bool = false;
	
	private var _width: Float = 30;
	private var _height: Float = 30;
	private var jumpPower: Float = 200;
	
	override function init() 
	{		
		type = BodyType.DYNAMIC;
		verts = [];
		
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
		
		shape = new Circle(_width / 2);
		shape.material.dynamicFriction = 0;
		
		move();
	}
	
	override function render(): DisplayObject 
	{
		var graphic: MovieClip = Assets.getMovieClip("library:Minazinha");
		graphic.width = 30;
		graphic.height = 30;
		return graphic;
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
		
		var threshold: Int = 3;
		
		var isAbove: Bool = Math.floor(bottom) - threshold <= Math.ceil(enemy.top);		
		trace('isAbove: $isAbove = ${Math.floor(bottom) - threshold} <= ${Math.ceil(enemy.top)}');
		
		var isOnTheLeft: Bool = Math.ceil(left) + threshold < Math.floor(enemy.right);
		trace('isOnTheLeft: $isOnTheLeft = ${Math.ceil(left) + threshold} < ${Math.floor(enemy.right)}');
		
		var isOnTheRight: Bool = Math.floor(right) - threshold > Math.ceil(enemy.left);
		trace('isOnTheRight: $isOnTheRight = ${Math.floor(right) - threshold} > ${Math.ceil(enemy.left)}');
		
		return isAbove && isOnTheLeft && isOnTheRight;
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