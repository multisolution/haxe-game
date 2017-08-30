package;

import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.space.Space;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Stage;

class Enemy extends Entity 
{
	private var _width: Float = 15;
	private var _height: Float = 15;
	
	override function init() 
	{
		type = BodyType.KINEMATIC;
		verts = Polygon.box(_width, _height);
	}
	
	override function create() 
	{
		super.create();
		
		body.cbTypes.add(CbTypes.ENEMY);
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