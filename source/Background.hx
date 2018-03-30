package;

import flixel.FlxSprite;
import flixel.FlxG;

/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */
class Background extends FlxSprite
{

    public function new()
    {
        super(0, 0);
        makeGraphic(FlxG.width, FlxG.height, Status.backgroundColor);
    }

}