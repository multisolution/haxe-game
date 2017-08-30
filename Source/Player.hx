package;

import nape.phys.BodyType;
import nape.shape.Polygon;
import openfl.display.DisplayObject;
import openfl.display.Sprite;

class Player extends Entity
{
	private var width: Int;
	private var height: Int;
	
	override function init() 
	{
		width = 20;
		height = 20;
		
		type = BodyType.DYNAMIC;
		verts = Polygon.box(width, height);
	}
	
	override function render(): DisplayObject 
	{
		var sprite: Sprite = new Sprite();
		sprite.graphics.beginFill(0);
		sprite.graphics.drawRect(-width / 2, -height / 2, width, height);
		sprite.graphics.endFill();
		return sprite;
	}
}