package;

import nape.callbacks.InteractionCallback;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.shape.Shape;
import nape.space.Space;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Stage;

class Enemy extends Entity 
{	
	public var speed: Float = 50;
	
	private var _width: Float = 15;
	private var _height: Float = 15;
	
	public function move()
	{
		body.velocity.x = speed;
	}
	
	override function init() 
	{
		speed = Std.random(100) + 50;
		type = BodyType.DYNAMIC;
		verts = Polygon.box(_width, _height);
	}
	
	override function create()
	{
		super.create();
		
		body.cbTypes.add(CbTypes.ENEMY);
		body.allowRotation = false;
		body.userData.entity = this;
		
		shape.material.dynamicFriction = 0;
		
		move();
	}
	
	override function render():DisplayObject 
	{
		var sprite: Sprite = new Sprite();
		sprite.graphics.beginFill(0xFF0000);
		sprite.graphics.drawRect( -_width / 2, -_height / 2, _width, _height);
		sprite.graphics.endFill();
		return sprite;
	}
}