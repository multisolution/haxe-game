package;

import openfl.display.Stage;
import openfl.events.MouseEvent;
import openfl.events.EventDispatcher;

import nape.space.Space;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.callbacks.InteractionCallback;
import nape.callbacks.CbType;
import nape.callbacks.CbEvent;

import events.PlayerEvent;
import events.GameEvent;

class InteractionManager extends EventDispatcher
{
    static public var playerCollisionGroup: Int = 2;
    static public var playerCollisionMask: Int = ~2;
    static public var playerCallbackType: CbType = new CbType();

    static public var floorCollisionGroup: Int = 4;
    static public var floorCollisionMask: Int = -1;
    static public var floorCallbackType: CbType = new CbType();

    static public var wallCollisionGroup: Int = 4;
    static public var wallCollisionMask: Int = -1;
    static public var wallCallbackType: CbType = new CbType();

    static public var enemyCollisionGroup: Int = 8;
    static public var enemyCollisionMask: Int = 2|4;
    static public var enemyDeadCollisionMask: Int = 4;
    static public var enemyCallbackType: CbType = new CbType();


    static public var boostCollisionGroup: Int = 16;
    static public var boostCollisionMask: Int = ~(8|16);
    static public var boostCallbackType: CbType = new CbType();

    static public var ladderCollisionGroup: Int = 32;
    static public var ladderCollisonMask: Int = 2;
    static public var ladderCallbackType: CbType = new CbType();

    static private var instance: InteractionManager;

    private var stage: Stage;
    private var space: Space;

    static public function init(stage: Stage, space: Space): InteractionManager
    {
        if (instance != null) {
            return instance;
        }

        instance = new InteractionManager(stage, space);
        return instance;
    }

    static public function getInstance(): InteractionManager
    {
        return instance;
    }

    private function new(stage: Stage, space: Space)
    {
        super();

        this.stage = stage;
        this.space = space;

        listen();
    }

    public function listen()
    {
        space.listeners.add(playerCollidesWall());
        space.listeners.add(playerCollidesFloor());
        space.listeners.add(playerCollidesLadder());
        space.listeners.add(playerCollidesEnemy());
        space.listeners.add(playerSensesBoost());

        space.listeners.add(enemyCollidesWall());

        stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
    }

    private function playerCollidesWall(): InteractionListener
    {
        return new InteractionListener(
            CbEvent.BEGIN, InteractionType.COLLISION,
            playerCallbackType, wallCallbackType,

            function (cb: InteractionCallback) {
                var player: Player = cast(cb.int1.userData.entity, Player);
                player.bounce();
            }
        );
    }

    private function playerCollidesFloor(): InteractionListener
    {
        return new InteractionListener(
            CbEvent.BEGIN, InteractionType.COLLISION,
            playerCallbackType, floorCallbackType,

            function (cb: InteractionCallback) {
                var player: Player = cast(cb.int1.userData.entity, Player);
                player.isJumping = false;
            }
        );
    }

    private function playerSensesBoost(): InteractionListener
    {
        return new InteractionListener(
            CbEvent.BEGIN, InteractionType.SENSOR,
            playerCallbackType, boostCallbackType,

            function (cb: InteractionCallback) {
                var player: Player = cast(cb.int1.userData.entity, Player);
                player.boost();

                var boost: Boost = cast(cb.int2.userData.entity, Boost);
                boost.free();
            }
        );
    }

    private function playerCollidesLadder(): InteractionListener
    {
        return new InteractionListener(
            CbEvent.BEGIN, InteractionType.COLLISION,
            playerCallbackType, ladderCallbackType,

            function (cb: InteractionCallback) {
                dispatchEvent(new GameEvent(GameEvent.LEVEL_UP));
            }
        );
    }

    private function playerCollidesEnemy(): InteractionListener
    {
        return new InteractionListener(
            CbEvent.BEGIN, InteractionType.COLLISION,
            playerCallbackType, enemyCallbackType,

            function (cb: InteractionCallback) {
                var player: Player = cast(cb.int1.userData.entity, Player);
                var enemy: Enemy = cast(cb.int2.userData.entity, Enemy);

                if (player.willKill(enemy)) {
                    player.kill(enemy);
                    return;
                }

                dispatchEvent(new GameEvent(GameEvent.GAME_OVER));
            }
        );
    }


    private function enemyCollidesWall(): InteractionListener
    {
        return new InteractionListener(
            CbEvent.BEGIN, InteractionType.COLLISION,
            enemyCallbackType, wallCallbackType,

            function (cb: InteractionCallback) {
                var enemy: Enemy = cast(cb.int1.userData.entity, Enemy);
                enemy.bounce();
            }
        );
    }

    private function onMouseDown(event: MouseEvent)
    {
        dispatchEvent(new PlayerEvent(PlayerEvent.JUMP));
    }
}
