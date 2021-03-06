package;

import nape.callbacks.CbEvent;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
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
	public var halfWidth(get, null): Float;
	public var halfHeight(get, null): Float;
	public var top(get, null): Float;
	public var left(get, null): Float;
	public var bottom(get, null): Float;
	public var right(get, null): Float;

	public var width: Float;
	public var height: Float;

	public var type: BodyType;
	public var verts: Dynamic;
	public var body: Body;
	public var shape: Shape;
	public var display: DisplayObject;
	public var stage: Stage;
	public var space: Space;

	private var listeners: Array<InteractionListener>;

	public function new(stage: Stage, space: Space)
	{
		this.stage = stage;
		this.space = space;

		listeners = [];

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

	public function get_halfWidth(): Float
	{
		return width / 2;
	}

	public function get_halfHeight(): Float
	{
		return height / 2;
	}

	public function get_top(): Float
	{
		return y - halfHeight;
	}

	public function get_left(): Float
	{
		return x - halfWidth;
	}

	public function get_bottom(): Float
	{
		return y + halfHeight;
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

	public function free()
	{
		stage.removeEventListener(Event.ENTER_FRAME, onEnterFrame, false);

		if (display.parent == stage) {
			stage.removeChild(display);
		}

		for (listener in listeners) {
			space.listeners.remove(listener);
		}

		body.space = null;
	}
}
