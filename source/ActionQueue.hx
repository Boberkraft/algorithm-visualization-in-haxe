package;
import flixel.FlxObject;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author Andrzej
 */
class ActionQueue extends FlxObject
{
    private var operations:Array<Void->ActionType>;
    private var activeAction:ActionType;
    private var isStarted:Bool;
    private var activeActionIndex:Int;
    public function new()
    {
        super();
        init();
    }

    private function init()
    {
        operations = [];
        isStarted = false;
        activeActionIndex = -1;
        activeAction = null;
    }
    public function push(action)
    {
        operations.push(action);
    }

    function get_start():Bool
    {
        return this.isStarted;
    }

    public function start()
    {
        if (isStarted == true)
            throw "Yy";
        isStarted = true;
    }

    override public function update(elapsed:Float)
    {

        if (isStarted)
        {
            if (activeAction == null)
            {
                //invoke function! and advance
                activeActionIndex += 1;
                if (activeActionIndex >= operations.length)
                {
                    // ok its the end reset everything
                    // and return!
                    return init();
                }
                //load new action lists
                activeAction = operations[activeActionIndex]();
                //trace(activeAction);
            }

            if (checkIfStillActive(activeAction) == false)
                activeAction = null;
        }
    }

    private function checkIfStillActive(command:ActionType):Bool
    {
        switch (command)
        {
            case ActionType.T_SINGLE(cmd):
                return cmd.active == true;
            
            case ActionType.T_MANY(cmds):
                for (cmd in cmds)
                {
                    if (checkIfStillActive(cmd))
                    {
                        return true;
                    }
                }
                return false;
        }
    }
    
    public static function wait(time:Float):Wait
    {
        return new Wait(time);
    }

}

