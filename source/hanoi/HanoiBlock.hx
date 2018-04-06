package hanoi;
import flixel.FlxSprite;

/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */
class HanoiBlock extends FlxSprite
{
    public static var MAX_HEIGHT = 20;
    public static var MAX_WIDTH = 100;
    
    public var value:Int;
    
    public function new(val:Int) 
    {
        super();
        value = val;
        makeGraphic(Std.int(val / HanoiPeg.MAX_BLOCKS * MAX_WIDTH), MAX_HEIGHT, Status.doneColor);
    }
    
}