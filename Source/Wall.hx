package;

import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.space.Space;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Stage;

class Wall extends Entity 
{
	private var _width: Int;
	private var _height: Int;
	
	override function init() 
	{
		_width = 20;
		_height = 60;
		
		type = BodyType.KINEMATIC;
		verts = Polygon.box(_width, _height);
	}
	
	override function render():DisplayObject 
	{
		var sprite: Sprite = new Sprite();
		sprite.graphics.beginFill(0);
		sprite.graphics.drawRect( -_width / 2, -_height / 2, _width, _height);
		sprite.graphics.endFill();
		return sprite;
	}
	
}