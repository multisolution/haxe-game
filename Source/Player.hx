package;

import nape.callbacks.CbEvent;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.phys.BodyType;
import nape.shape.Polygon;
import openfl.display.DisplayObject;
import openfl.display.Sprite;

class Player extends Entity
{	
	public var speed: Int = 200;
	
	private var _width: Int;
	private var _height: Int;
	
	override function init() 
	{
		_width = 20;
		_height = 20;
		
		type = BodyType.DYNAMIC;
		verts = Polygon.box(_width, _height);
		
		detectCollision(CbTypes.PLAYER, CbTypes.WALL, onWallCollision);
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
	
	
	private function onWallCollision(collision: InteractionCallback)
	{
		speed *= -1;
		body.velocity.x = speed;
	}
}