package;

import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.space.Space;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Stage;

class Ladder extends Entity 
{	
	override function init() 
	{
		width = 20;
		height = 40;
		
		type = BodyType.KINEMATIC;
		verts = Polygon.box(width, height);
	}
	
	override function create() 
	{
		super.create();
		
		body.cbTypes.add(CbTypes.LADDER);
	}
	
	override function render():DisplayObject 
	{
		var sprite: Sprite = new Sprite();
		sprite.graphics.beginFill(0x777777);
		sprite.graphics.drawRect(-halfWidth, -halfHeight, width, height);
		sprite.graphics.endFill();
		return sprite;
	}
}