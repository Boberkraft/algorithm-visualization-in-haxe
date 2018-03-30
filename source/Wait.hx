package;
import flixel.FlxObject;
import Date;

/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */
class Wait extends FlxObject
{

    private var waitingTime:Float;
    public static var Waiter:GlobalTimer;
    
    public function new(_waitingTime:Float) 
    {
       super();
       Waiter.add(this);
       waitingTime = _waitingTime;
       this.active = true;
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        waitingTime -= elapsed;
        if (waitingTime <= 0)
        {
            this.active = false;
            Waiter.remove(this);
        }
    }
}