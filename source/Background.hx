package;

import flixel.FlxSprite;
import flixel.FlxG
;
/**
 * ...
 * @author Andrzej
 */
class Background extends FlxSprite
{

    public function new()
    {
        super(0, 0);
        makeGraphic(FlxG.width, FlxG.height, Status.backgroundColor);
    }

}