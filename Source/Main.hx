package;

import events.PlayerEvent;
import events.GameEvent;
import motion.Actuate;
import motion.easing.Linear;
import nape.geom.Vec2;
import nape.space.Space;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.display.StageScaleMode;
import openfl.events.Event;

class Main extends Sprite
{
	public var currentLevel(get, null): Level;

	private var gravity: Vec2;
	private var space: Space;
	private var player: Player;
	private var levels: Array<Level>;
	private var currentLevelIndex: Int;
	private var ui: UI;
    private var interactionManager: InteractionManager;

	public function new()
	{
		super();

		stage.addChild(Assets.getMovieClip("library:Background"));
		stage.scaleMode = StageScaleMode.EXACT_FIT;

		gravity = new Vec2(0, 1000);
		space = new Space(gravity);

		player = new Player(stage, space);
		ui = new UI();
        stage.addChild(ui);

        interactionManager = InteractionManager.init(stage, space);
        interactionManager.addEventListener(PlayerEvent.JUMP, onPlayerJump, false, 0, true);
        interactionManager.addEventListener(GameEvent.LEVEL_UP, onLevelUp, false, 0, true);
        interactionManager.addEventListener(GameEvent.GAME_OVER, onGameOver, false, 0, true);

		stage.addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);

        start();
	}

	private function start()
	{
		currentLevelIndex = 0;
		levels = [];


        for(i in 0...9){
            addLevel();
        }




		player.position(stage.stageWidth / 2, currentLevel.floor.top - player.halfHeight);
		player.move();
	}

	private function reset()
	{
		for (level in levels) {
			level.free();
		}

		Data.resetScore();
	}

	private function onGameOver(event: GameEvent)
	{
		Data.setHighScore(Std.int(Math.max(Data.highScore(), Data.score())));
		reset();
		start();
	}

	private function addLevel(): Level
	{
		var level: Level = new Level(stage, space, levels[levels.length - 1], player);
		levels.push(level);
		return level;
	}

	private function get_currentLevel(): Level
	{
		return levels[currentLevelIndex];
	}

	private function onLevelUp(event: GameEvent)
	{
		var newPlayerX: Float = currentLevel.ladder.x;
		var toSlide: Float = currentLevelIndex > 2 ? 100 : 0;

		player.shape.sensorEnabled = true;
		player.body.velocity.setxy(0, 0);

		for (level in levels) {
			level.slideDown(toSlide);
		}

		addLevel();
		currentLevelIndex += 1;

		player.isJumping = false;

		Actuate.tween(player, 0.3, {x: newPlayerX, y: currentLevel.floor.top + toSlide - player.halfHeight})
		.ease(Linear.easeNone)
		.onComplete(function () {
			player.shape.sensorEnabled = false;
			player.move();
			currentLevel.enemy.move();
		});

		freeOldLevel();

		Data.incScore();
	}

	private function freeOldLevel()
	{
		if (currentLevelIndex > 10) {
			levels[currentLevelIndex - 10].free();
		}
	}

    private function onPlayerJump(event: PlayerEvent)
    {
        player.jump();
    }

	private function onEnterFrame(event: Event)
	{
		space.step(1 / stage.frameRate);
		ui.update();
	}
}
