package;
import flixel.FlxObject;
import flixel.group.FlxGroup;

/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */
class GlobalTimer extends FlxGroup
{
    public static var instance(default, null) = new GlobalTimer();
    
    public function new()
    {
        super();
        Wait.Waiter = this;
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}