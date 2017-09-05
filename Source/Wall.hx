package;

import nape.phys.BodyType;
import nape.shape.Polygon;
import openfl.Assets;
import openfl.display.DisplayObject;

class Wall extends Entity
{
	override function init()
	{
		width = 20;
		height = 60;

		type = BodyType.KINEMATIC;
		verts = Polygon.box(width, height);
	}

	override function create()
	{
		super.create();

		body.cbTypes.add(InteractionManager.wallCallbackType);

        shape.filter.collisionGroup = InteractionManager.wallCollisionGroup;
        shape.filter.collisionMask = InteractionManager.wallCollisionMask;
	}

	override function render():DisplayObject
	{
		return Assets.getMovieClip("library:WallArt");
	}
}
