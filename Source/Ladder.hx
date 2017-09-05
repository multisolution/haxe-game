package;

import nape.phys.BodyType;
import nape.shape.Polygon;
import openfl.display.DisplayObject;
import openfl.Assets;

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

		body.cbTypes.add(InteractionManager.ladderCallbackType);

        shape.filter.collisionGroup = InteractionManager.ladderCollisionGroup;
        shape.filter.collisionMask = InteractionManager.ladderCollisonMask;
	}

	override function render(): DisplayObject
	{
        return Assets.getMovieClip("library:LadderArt");
	}
}
