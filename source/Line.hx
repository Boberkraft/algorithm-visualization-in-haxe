package;
import flixel.FlxSprite;
import flixel.FlxG;

/**
 * ...
 * @author Andrzej
 */
class Line extends FlxSprite
{
    public var HEIGHTPIXELS = 2;
    public function new(width:Int) 
    {
        super();
        makeGraphic(width, HEIGHTPIXELS , Status.pickColor);
    }
    
}