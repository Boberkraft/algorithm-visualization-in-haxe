package;

import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
/**
 * ...
 * @author Andrzej
 */
class Bracket extends FlxSpriteGroup 
{
    public static var WIDTHPIXELS = 4;
    public function new(width:Int) 
    {
        super();
        var left = new FlxSprite().makeGraphic(WIDTHPIXELS, WIDTHPIXELS * 2, Status.doneColor);
        var right = new FlxSprite().makeGraphic(WIDTHPIXELS, WIDTHPIXELS * 2, Status.doneColor);
        var middle = new FlxSprite().makeGraphic(ItemImpl.ITEM_WIDTH * 2 * width - ItemImpl.ITEM_WIDTH + 2 * WIDTHPIXELS, WIDTHPIXELS, Status.doneColor);
        middle.y = left.height - middle.health;
        middle.x -= WIDTHPIXELS;
        right.x = middle.width - right.width * 2;
        left.x -= WIDTHPIXELS;
        add(left);
        add(right);
        add(middle); 
    }
    
}