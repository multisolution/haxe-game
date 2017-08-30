package;

import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.space.Space;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Stage;
import Utils.*;

class Floor extends Entity 
{
	private var _width: Float;
	private var _height: Float;
	
	override function init() 
	{
		_width = stage.stageWidth;
		_height = dpiScale(20);
		
		type = BodyType.KINEMATIC;
		verts = Polygon.box(_width, _height);
	}
	
	override function create() 
	{
		super.create();
		
		body.cbTypes.add(CbTypes.FLOOR);
	}
	
	override function render():DisplayObject 
	{
		var sprite: Sprite = new Sprite();
		sprite.graphics.beginFill(0);
		sprite.graphics.drawRect(-_width / 2, -_height / 2, _width, _height);
		sprite.graphics.endFill();
		return sprite;
	}
	
}