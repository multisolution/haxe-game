package;

import nape.phys.BodyType;
import nape.shape.Polygon;
import openfl.Assets;
import openfl.display.DisplayObject;
import openfl.display.MovieClip;
import nape.dynamics.InteractionFilter;

class Enemy extends Entity
{
	public var speed: Float = 50;
    public var isDead = false;

	public function move()
	{
        body.velocity.x = speed;
		cast(display, MovieClip).play();
	}

    public function kill()
    {
        cast(display,MovieClip).gotoAndStop("tombstone");
        body.velocity.x = speed = 0;
        shape.sensorEnabled = true;
        isDead = true;
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

		speed = 50 + Data.score();
		type = BodyType.KINEMATIC;
		verts = Polygon.box(width, height);
	}

	override function create()
	{
		super.create();

		body.cbTypes.add(CbTypes.ENEMY);
		body.allowRotation = false;
		body.userData.entity = this;
		shape.material.dynamicFriction = 0;
	}

	override function render():DisplayObject
	{
		return Assets.getMovieClip("library:Zombie");
	}
}
