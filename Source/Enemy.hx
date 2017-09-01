package;

import nape.callbacks.InteractionCallback;
import nape.phys.BodyType;
import nape.shape.Circle;
import nape.shape.Polygon;
import nape.shape.Shape;
import nape.space.Space;
import openfl.Assets;
import openfl.display.DisplayObject;
import openfl.display.MovieClip;
import openfl.display.Sprite;
import openfl.display.Stage;

class Enemy extends Entity 
{	
	public var speed: Float = 50;
	
	public function move()
	{		
		body.velocity.x = speed;
		cast(display, MovieClip).play();
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
		type = BodyType.DYNAMIC;
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