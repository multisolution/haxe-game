package;

import nape.shape.Polygon;
import nape.phys.BodyType;
import openfl.Assets;

class Arrow extends Enemy
{
    override function init()
    {
        width = 13;
        height =  13;
		type = BodyType.KINEMATIC;
		verts = Polygon.box(width, height);
    }

    override function create()
    {
        super.create();

        body.isBullet = true;

		shape.material.dynamicFriction = 0;

        //move();

    }

    override function render()
    {
        return Assets.getMovieClip("library:ArrowArt");
    }
}
