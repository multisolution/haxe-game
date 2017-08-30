package;

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

class Player extends Entity
{	
	public var speed: Int = 200;
	
	private var _width: Int;
	private var _height: Int;
	private var isJumping: Bool = false;
	
	override function init() 
	{
		_width = 20;
		_height = 20;
		
		type = BodyType.DYNAMIC;
		verts = Polygon.box(_width, _height);
		
		detectCollision(CbTypes.PLAYER, CbTypes.WALL, onWallCollision);
		detectCollision(CbTypes.PLAYER, CbTypes.FLOOR, onFloorCollision);
		
		stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
	}
	
	override function create() 
	{
		super.create();
		
		body.velocity.x = speed;
		body.cbTypes.add(CbTypes.PLAYER);
		
		shape.material.dynamicFriction = 0;
	}
	
	override function render(): DisplayObject 
	{
		var sprite: Sprite = new Sprite();
		sprite.graphics.beginFill(0);
		sprite.graphics.drawRect(-_width / 2, -_height / 2, _width, _height);
		sprite.graphics.endFill();
		return sprite;
	}
	
	public function jump(): Bool
	{
		if (isJumping) {
			return false;
		}
		
		body.applyImpulse(new Vec2(0, -100));
		return isJumping = true;
	}
	
	
	private function onWallCollision(collision: InteractionCallback)
	{
		speed *= -1;
		body.velocity.x = speed;
	}
	
	private function onFloorCollision(collision: InteractionCallback)
	{
		isJumping = false;
	}
	
	private function onMouseDown(event: MouseEvent)
	{
		jump();
	}
}