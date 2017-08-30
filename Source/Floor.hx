package;

import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.space.Space;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Stage;

class Floor extends Entity 
{
	private var width: Int;
	private var height: Int;
	
	override function init() 
	{
		width = stage.stageWidth;
		height = 20;
		
		type = BodyType.KINEMATIC;
		verts = Polygon.box(width, height);
	}
	
	override function render():DisplayObject 
	{
		var sprite: Sprite = new Sprite();
		sprite.graphics.beginFill(0);
		sprite.graphics.drawRect(-width / 2, -height / 2, width, height);
		sprite.graphics.endFill();
		return sprite;
	}
	
}