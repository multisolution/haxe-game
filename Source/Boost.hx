package;

import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.space.Space;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Stage;

class Boost extends Entity 
{
	private var _width: Float = 15;
	private var _height: Float = 15;
	
	override function init() 
	{
		type = BodyType.KINEMATIC;
		verts = Polygon.box(15, 15);
	}
	
	override function create() 
	{
		super.create();
		
		body.cbTypes.add(CbTypes.BOOST);
		body.userData.entity = this;
	}
	
	override function render():DisplayObject 
	{
		var sprite: Sprite = new Sprite();
		sprite.graphics.beginFill(0x00FF00);
		sprite.graphics.drawRect( -_width / 2, -_height / 2, _width, _height);
		sprite.graphics.endFill();
		return sprite;
	}
}