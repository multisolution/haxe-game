package;

import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.space.Space;
import openfl.Assets;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Stage;

class Floor extends Entity 
{	
	override function init() 
	{
		width = stage.stageWidth;
		height = 20;
		
		type = BodyType.KINEMATIC;
		verts = Polygon.box(width, height);
	}
	
	override function create() 
	{
		super.create();
		
		body.cbTypes.add(CbTypes.FLOOR);
	}                                                                                                                     
	
	override function render():DisplayObject 
	{
		return Assets.getMovieClip("library:FloorArt");
	}
	
}