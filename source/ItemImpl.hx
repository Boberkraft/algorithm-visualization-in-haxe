package;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
/**
 * ...
 * @author Andrzej
 */
class ItemImpl extends FlxSpriteGroup
{
    public inline static var ITEM_WIDTH = 20;
    // the height is maped value of the block.
    // so val 0 -> 0
    // and val 100 -> MAX_HEIGHT
    public inline static var MAX_HEIGHT = 200;
    private inline static var MAX_WIDTH = 5; // scale of height
    private var itemHeight:Int;
    public var value:Int;
    private var graph:FlxSprite;

    override public function new(height:Int, val:Int)
    {
        super(x, y);
        value = val;
        itemHeight = height;
        graph = new FlxSprite(0, MAX_HEIGHT - itemHeight);
        graph.makeGraphic(ITEM_WIDTH, itemHeight,true);
        add(graph);
    }
    
    public function setColor(color:FlxColor)
    {
        this.color = color;
    }
    public function setColorPick()
    {
        //graph.color = Status.pickColor;
        color = Status.pickColor;
    }
    
    public function setColorPickSecondary()
    {
        color = Status.pickColorSecondary;
    }
    
    public function setColorIdle()
    {
        color = Status.idleColor;
    }
}

