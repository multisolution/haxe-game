package;

import events.PlayerEvent;
import motion.Actuate;
import nape.callbacks.InteractionCallback;
import nape.geom.Vec2;
import nape.phys.BodyType;
import nape.shape.Polygon;
import openfl.Assets;
import openfl.display.DisplayObject;
import openfl.events.MouseEvent;

class Player extends Entity
{
	public var speed: Float = 200;
	public var isJumping: Bool = false;
	public var isBoosted: Bool = false;

	private var jumpPower: Float = 150;

	override function init()
	{
		width = 16;
		height = 30;

		type = BodyType.DYNAMIC;
		verts = Polygon.box(width, height);

		stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
	}

	override function create()
	{
		super.create();

		body.cbTypes.add(InteractionManager.playerCallbackType);
		body.allowRotation = false;
        body.userData.entity = this;

        shape.filter.collisionGroup = InteractionManager.playerCollisionGroup;
        shape.filter.collisionMask = InteractionManager.playerCollisionMask;
		shape.material.dynamicFriction = 0;

		move();
	}

	override function render(): DisplayObject
	{
		return Assets.getMovieClip("library:Minazinha");
	}

	public function move()
	{
		body.velocity.x = speed;
	}

	public function jump(): Bool
	{
		if (isJumping) {
			return false;
		}

		body.applyImpulse(new Vec2(0, -jumpPower));
		return isJumping = true;
	}

	public function boost()
	{
		isBoosted = true;
		Actuate.tween(display, 0.3, {alpha: 0.3}).repeat(6).reverse().onComplete(stopBoost);
	}

	public function stopBoost()
	{
		isBoosted = false;
		display.alpha = 1;
	}

	public function bounce()
	{
		speed *= -1;
		display.scaleX *= -1;
		move();
	}

	public function willKill(enemy: Enemy): Bool
	{
        if (isBoosted) {
			return true;
		}

		var tolerence: Int = 3;
		return Math.floor(bottom) - tolerence <= Math.ceil(enemy.top);
	}

    public function kill(enemy: Enemy)
    {
        enemy.die();
    }

	private function onMouseDown(event: MouseEvent)
	{
		jump();
	}
}
