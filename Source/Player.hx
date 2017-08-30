package;

import events.PlayerEvent;
import nape.callbacks.CbEvent;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.geom.Vec2;
import nape.phys.BodyType;
import nape.shape.Polygon;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.events.MouseEvent;
import openfl.events.TouchEvent;

class Player extends Entity
{	
	public var speed: Float = 200;
	
	private var _width: Float = 20;
	private var _height: Float = 20;
	private var jumpPower: Float = 100;
	private var isJumping: Bool = false;
	
	override function init() 
	{		
		type = BodyType.DYNAMIC;
		verts = Polygon.box(_width, _height);
		
		detectCollision(CbTypes.PLAYER, CbTypes.WALL, onWallCollision);
		detectCollision(CbTypes.PLAYER, CbTypes.FLOOR, onFloorCollision);
		detectCollision(CbTypes.PLAYER, CbTypes.LADDER, onLadderCollision);
		detectCollision(CbTypes.PLAYER, CbTypes.ENEMY, onEnemyCollision);
		
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
		var sprite: Sprite = new Sprite();
		sprite.graphics.beginFill(0);
		sprite.graphics.drawRect(-_width / 2, -_height / 2, _width, _height);
		sprite.graphics.endFill();
		return sprite;
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
	
	
	private function onWallCollision(collision: InteractionCallback)
	{
		speed *= -1;
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
		stage.dispatchEvent(new PlayerEvent(PlayerEvent.ENEMY_COLLISION));
	}
	
	private function onMouseDown(event: MouseEvent)
	{
		jump();
	}
}