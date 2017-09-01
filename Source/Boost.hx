package;

import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.space.Space;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Stage;

class Boost extends Entity 
{	
	override function init() 
	{
		width = height = 15;
		
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
		sprite.graphics.drawRect(-halfWidth, -halfHeight, width, height);
		sprite.graphics.endFill();
		return sprite;
	}
}