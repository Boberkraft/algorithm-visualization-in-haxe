package;

import flash.display.InterpolationMethod;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.math.FlxRandom;
import flixel.group.FlxSpriteGroup;
import ActionType;
/**
 * ...
 * @author Andrzej
 */
class ItemList extends FlxSpriteGroup
{
    public var _ItemList:Array<ItemImpl>;
    public var data:Array<Int>;
    public var lenght(get, null):Int;
    private var brackets:FlxTypedSpriteGroup<Bracket>;
    private var bracketRegister:BracketManager;
    private var lineRegister:LineManager;
    public function new(items:Int)
    {
        super();
        _ItemList = [];
        //brackets = new FlxTypedSpriteGroup<Bracket>();
        bracketRegister = new BracketManager();
        lineRegister = new LineManager();
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
            item.x = calculateX(i);
        }
        //trace(bracketRegister.height, bracketRegister.width);
        bracketRegister.y = height;
        
        add(bracketRegister);
        add(lineRegister);
        
    }

    private function calculateX(index:Int):Int
    {
        return Std.int(ItemImpl.ITEM_WIDTH * index * 2 + this.x);
    }
    
    public static function calculateXwithoutThisX(index:Int):Int
    {
        return Std.int(ItemImpl.ITEM_WIDTH * index * 2 );
    }
    //public function swapItemsByIndex(a:Int, b:Int)
    //{
        //var itemA:Item = get(a);
        //var itemB:Item = get(b);
        //
        //var temp = _ItemList[a];
        //_ItemList[a] = _ItemList[b];
        //_ItemList[b] = temp;
        ////return swapItemsByItem(itemA, itemB);
    //}
    private function tweenFunction(s:FlxSprite, v:Float) {
        s.alpha = v;
        if (v == 0)
        {
            s.kill();
        }
    }
    public function addBracket(where:Int, span:Int, height:Int):ActionType
    {
        var bracket = new Bracket(span);
        bracket.alpha = 0.000000001;
        bracketRegister.register(where, height, bracket);
        bracket.x = calculateX(where);
        return T_SINGLE(FlxTween.num(0, 1, 0.5, {ease:FlxEase.smootherStepInOut}, tweenFunction.bind(bracket)));
    }
    public function removeBracket(where:Int, height:Int):ActionType
    {
        var bracket = bracketRegister.unregister(where, height);
        //return T_SINGLE(new Wait(0.5));
        return T_SINGLE(FlxTween.num(1, 0, 0.5, {ease:FlxEase.smootherStepInOut}, tweenFunction.bind(bracket)));
    }
    public function addLineForItem(item:Item):ActionType
    {
        return addLine(ItemImpl.MAX_HEIGHT - item.itemHeight);
    }
    private  function addLine(height:Int):ActionType
    {
        var line = new Line(ItemImpl.ITEM_WIDTH * data.length * 2 - ItemImpl.ITEM_WIDTH);
        line.y += height;
        line.alpha = 0.000000001;
        lineRegister.register(height, line);
        //return T_SINGLE(new Wait(0.5));
        return T_SINGLE(FlxTween.num(0, 1, 0.5, {ease:FlxEase.smootherStepInOut}, tweenFunction.bind(line)));
    }
    public function removeLineForItem(item:Item):ActionType
    {
        return removeLine(ItemImpl.MAX_HEIGHT - item.itemHeight);
    }
    private function removeLine(height:Int):ActionType
    {
        var line = lineRegister.unregister(height);
        //return T_SINGLE(new Wait(0.5));
        return T_SINGLE(FlxTween.num(1, 0, 0.5, {ease:FlxEase.smootherStepInOut}, tweenFunction.bind(line)));
    }
    public function moveItemToIndex(item:Item, index:Int, time:Float, ?offset=0):ActionType
    {
        var newX = calculateX(index + offset);

        return T_SINGLE(FlxTween.tween(item, {x:newX}, time, {ease:FlxEase.smootherStepInOut}));
    }
    public function moveItemDown(item:Item, tier:Int, time:Float)
    {
        var where = ItemImpl.MAX_HEIGHT * (-1 * tier) + item.y;
        return T_SINGLE(FlxTween.tween(item, {y:where}, time, {ease:FlxEase.smootherStepInOut}));
    }
    
    //public function swapItemsByItem(itemA:Item, itemB:Item):ActionType
    //{
        //var tweens:Array<ActionType> = [
        //T_SINGLE(FlxTween.tween(itemA, {x:itemB.x}, 0.2, {ease:FlxEase.smootherStepInOut})),
        //T_SINGLE(FlxTween.tween(itemB, {x:itemA.x}, 0.2, {ease:FlxEase.smootherStepInOut}))
        //];
        //
        //return T_MANY(tweens);
    //}
    //public function setColorByIndex(i:Int, color:FlxColor):ActionType
    //{
        //var item:Item = get(i);
        //throw 'error';
        //return setColorByItem(item);
    //}
    public function setColorForItem(item:Item,  color:FlxColor, time:Float):ActionType
    {
        return T_SINGLE(FlxTween.color(item, time, item.color, color));
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
