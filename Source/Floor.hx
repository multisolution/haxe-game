package;

import nape.phys.BodyType;
import nape.shape.Polygon;
import openfl.Assets;
import openfl.display.DisplayObject;

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

		body.cbTypes.add(InteractionManager.floorCallbackType);

        shape.filter.collisionGroup = InteractionManager.floorCollisionGroup;
        shape.filter.collisionMask = InteractionManager.floorCollisionMask;

	}

	override function render():DisplayObject
	{
		return Assets.getMovieClip("library:FloorArt");
	}

}
