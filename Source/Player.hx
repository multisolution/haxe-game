package;

import nape.phys.BodyType;
import nape.shape.Polygon;
import openfl.display.DisplayObject;
import openfl.display.Sprite;

class Player extends Entity
{
	override function init() 
	{
		type = BodyType.DYNAMIC;
		verts = Polygon.rect(0, 0, 20, 20);
	}
	
	override function render(): DisplayObject 
	{
		var sprite: Sprite = new Sprite();
		sprite.graphics.beginFill(0);
		sprite.graphics.drawRect(0, 0, 20, 20);
		sprite.graphics.endFill();
		return sprite;
	}
}