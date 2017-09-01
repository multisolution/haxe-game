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
	
	private var _width: Float = 20;
	private var _height: Float = 30;
	
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
		speed = 50 + Data.score();
		type = BodyType.DYNAMIC;
		verts = Polygon.box(_width, _height);
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
		var movieClip: MovieClip = Assets.getMovieClip("library:Zombie");
		movieClip.width = 30;
		movieClip.height = 30;
		movieClip.stop();
		return movieClip;
		
		var sprite: Sprite = new Sprite();
		sprite.graphics.beginFill(0xFF0000);
		sprite.graphics.drawCircle(0, 0, _width / 2);
		sprite.graphics.endFill();
		return sprite;
	}
}