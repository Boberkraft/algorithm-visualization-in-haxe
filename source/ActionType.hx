package;

/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */
enum ActionType 
{
    T_SINGLE(wait:Dynamic);
    T_MANY(waiters:Array<ActionType>);
}


@:forward
abstract Activable(Dynamic)
from _Activable1
from _Activable2
{}



typedef _Activable1 = {
    public var active(get, null):Bool;
}


typedef _Activable2 = {
    public var active(default, set):Bool;
}


