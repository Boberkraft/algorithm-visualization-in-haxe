package;

import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.math.FlxRandom;
import ActionType;
/**
 * ...
 * @author Andrzej
 */
class ItemList extends FlxTypedSpriteGroup<ItemImpl>
{
    public var _ItemList:Array<ItemImpl>;
    public var data:Array<Int>;
    public var lenght(get, null):Int ;

    public function new(items:Int)
    {
        super();
        _ItemList = [];
        var random = new FlxRandom();
        var shuffled_items = [for (i in 0...items) i];
        random.shuffle(shuffled_items);
        data = shuffled_items;
        for (i in 0...shuffled_items.length)
        {
            var val = shuffled_items.length - shuffled_items[i];
            var height = Std.int(val/ items * ItemImpl.MAX_HEIGHT);
            var item = new ItemImpl(height, val);
            item.setColorIdle();
            add(item);
            
            _ItemList[i] = item;
            item.x = ItemImpl.ITEM_WIDTH * i * 2;
        }

    }

    
    public function swapItemsByIndex(a:Int, b:Int)
    {
        var itemA:Item = get(a);
        var itemB:Item = get(b);
        
        var temp = _ItemList[a];
        _ItemList[a] = _ItemList[b];
        _ItemList[b] = temp;
        //return swapItemsByItem(itemA, itemB);

    }
    public function swapItemsByItem(itemA:Item, itemB:Item):ActionType
    {
        var tweens:Array<ActionType> = [
        T_SINGLE(FlxTween.tween(itemA, {x:itemB.x}, 0.2, {ease:FlxEase.smootherStepInOut})),
        T_SINGLE(FlxTween.tween(itemB, {x:itemA.x}, 0.2, {ease:FlxEase.smootherStepInOut}))
        ];
        
        return T_MANY(tweens);
    }
    //public function setColorByIndex(i:Int, color:FlxColor):ActionType
    //{
        //var item:Item = get(i);
        //throw 'error';
        //return setColorByItem(item);
    //}
    public function setColorByItem(item:Item, color:FlxColor):ActionType
    {
        return T_SINGLE(FlxTween.color(item, 0.1, item.color, color));
    }
    
    public inline function get_lenght()
    {
        return _ItemList.length;
    }

    public inline function get(i:Int):ItemImpl
    {
        return _ItemList[i];
    }
}

class PythonRange
{
    var start:Int;
    var i:Int;
    var end:Int;

    public function new(start:Int, _end:Int)
    {
        this.start = 0;
        i = start;
        this.end = _end;

    }
    public function hasNext()
    {
        return i < end;
    }
    public function next()
    {
        var old_i = i;
        i += 1;
        return old_i;

    }
}
