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