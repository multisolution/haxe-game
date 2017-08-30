package;

import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;
import nape.shape.Shape;
import nape.space.Space;
import openfl.display.DisplayObject;
import openfl.display.Sprite;
import openfl.display.Stage;
import openfl.events.Event;

class Entity 
{
	public var x(get, null): Float;
	public var y(get, null): Float;
	public var width(get, null): Float;
	public var height(get, null): Float;
	public var halfWidth(get, null): Float;
	public var halfHeight(get, null): Float;
	
	private var type: BodyType;
	private var verts: Dynamic;
	private var body: Body;
	private var shape: Shape;
	private var display: DisplayObject;
	private var stage: Stage;
	private var space: Space;
	
	public function new(stage: Stage, space: Space)
	{
		this.stage = stage;
		this.space = space;
		
		init();
		create();
		bind();
		
		stage.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
	}
	
	public function position(x: Float, y: Float)
	{
		body.position.x = x;
		body.position.y = y;
	}
	
	public function get_x(): Float
	{
		return body.position.x;
	}
	
	public function get_y(): Float
	{
		return body.position.y;
	}
	
	public function get_width(): Float
	{
		return display.width;
	}
	
	public function get_height(): Float
	{
		return display.height;
	}
	
	public function get_halfWidth(): Float
	{
		return display.width / 2;
	}
	
	public function get_halfHeight(): Float
	{
		return display.height / 2;
	}
	
	private function init()
	{
		
	}
	
	private function create()
	{
		body = new Body(type);
		shape = new Polygon(verts);
		display = render();
	}
	
	private function render(): DisplayObject
	{
		return new Sprite();
	}
	
	private function bind()
	{	
		stage.addChild(display);
		shape.body = body;
		body.space = space;		
	}
	
	private function update()
	{
		display.x = body.position.x;
		display.y = body.position.y;
		display.rotation = body.rotation;
	}
	
	private function onEnterFrame(event: Event)
	{
		update();
	}
	
}