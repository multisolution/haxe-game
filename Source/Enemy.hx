package;

import nape.phys.BodyType;
import nape.shape.Polygon;
import openfl.Assets;
import openfl.display.DisplayObject;
import openfl.display.MovieClip;

class Enemy extends Entity
{
	public var speed: Float = 50;

	public function move()
	{
        body.velocity.x = speed;
		cast(display, MovieClip).play();
	}

    public function die()
    {
        cast(display,MovieClip).gotoAndStop("tombstone");
        body.velocity.x = speed = 0;
        shape.filter.collisionMask = InteractionManager.enemyDeadCollisionMask;
    }


	public function bounce()
	{
		speed *= -1;
		display.scaleX *= -1;
		move();
	}

	override function init()
	{
		width = 13;
		height = 27;

		speed += Data.score();
		type = BodyType.DYNAMIC;
		verts = Polygon.box(width, height);
	}

	override function create()
	{
		super.create();

		body.cbTypes.add(InteractionManager.enemyCallbackType);
		body.allowRotation = false;
		body.userData.entity = this;

        shape.filter.collisionGroup = InteractionManager.enemyCollisionGroup;
        shape.filter.collisionMask = InteractionManager.enemyCollisionMask;
		shape.material.dynamicFriction = 0;
	}

	override function render():DisplayObject
	{
		return Assets.getMovieClip("library:Zombie");
	}
}
