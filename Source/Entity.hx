package;

import nape.callbacks.CbEvent;
import nape.callbacks.CbType;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.callbacks.OptionType;
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
	public var x(get, set): Float;
	public var y(get, set): Float;
	public var width(get, null): Float;
	public var height(get, null): Float;
	public var halfWidth(get, null): Float;
	public var halfHeight(get, null): Float;
	public var top(get, null): Float;
	public var right(get, null): Float;
	
	public var type: BodyType;
	public var verts: Dynamic;
	public var body: Body;
	public var shape: Shape;
	public var display: DisplayObject;
	public var stage: Stage;
	public var space: Space;
	
	public function new(stage: Stage, space: Space)
	{
		this.stage = stage;
		this.space = space;
		
		init();
		create();
		update();
		bind();
		
		stage.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
	}
	
	public function position(x: Float, y: Float)
	{
		body.position.x = x;
		body.position.y = y;
	}
	
	public function detectCollision(a: CbType, b: CbType, handler: InteractionCallback->Void): InteractionListener
	{
		var event: CbEvent = CbEvent.BEGIN;
		var type: InteractionType = InteractionType.COLLISION;
		var listener: InteractionListener = new InteractionListener(event, type, a, b, handler);
		
		space.listeners.add(listener);
		
		return listener;
	}
	
	public function get_x(): Float
	{
		return body.position.x;
	}
	
	public function set_x(value: Float): Float
	{
		return body.position.x = value;
	}
	
	public function get_y(): Float
	{
		return body.position.y;
	}
	
	public function set_y(value: Float): Float
	{
		return body.position.y = value;
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
	
	public function get_top(): Float
	{
		return y - halfHeight;
	}
	
	public function get_right(): Float
	{
		return x + halfWidth;
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