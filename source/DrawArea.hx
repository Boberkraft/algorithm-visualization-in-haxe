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
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */
class DrawArea extends FlxSpriteGroup
{
    public var itemList:Array<ItemImpl>;
    public var bracketManager:BracketManager;
    public var lineManager:LineManager;
    
    public var data:Array<Int>;
    public var lenght(get, null):Int;
    
    public static function generateShuffledItems(items:Int):Array<Int>
    {
        var random = new FlxRandom();
        var shuffled_items = [for (i in 0...items) i + 1];
        random.shuffle(shuffled_items);
        return shuffled_items;        
    }
    
    
    public function new(items:Array<Int>)
    {
        super();
        itemList = [];
        
        bracketManager = new BracketManager();
        lineManager = new LineManager();
        
        data = items;

        for (i in 0...items.length)
        {
            var val = items[i];
            var height = Std.int(val / items.length * ItemImpl.MAX_HEIGHT);
            var item = new ItemImpl(height, val);
            item.setColorIdle();
            
            add(item);
            
            itemList.push(item);
            item.x = calculateX(i);            
        }
        bracketManager.y = height;
        
        add(bracketManager);
        add(lineManager);
        
    }

    private function calculateX(index:Int):Int
    {
        return Std.int(ItemImpl.ITEM_WIDTH * index * 2 + this.x);
    }
    public function getItems():Array<ItemImpl>
    {
        return itemList;
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
        bracketManager.register(where, height, bracket);
        bracket.x = calculateX(where);
        return T_SINGLE(FlxTween.num(0, 1, 0.5, {ease:FlxEase.smootherStepInOut}, tweenFunction.bind(bracket)));
    }
    public function removeBracket(where:Int, height:Int):ActionType
    {
        var bracket = bracketManager.unregister(where, height);
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
        lineManager.register(height, line);
        //return T_SINGLE(new Wait(0.5));
        return T_SINGLE(FlxTween.num(0, 1, 0.5, {ease:FlxEase.smootherStepInOut}, tweenFunction.bind(line)));
    }
    public function removeLineForItem(item:Item):ActionType
    {
        return removeLine(ItemImpl.MAX_HEIGHT - item.itemHeight);
    }
    private function removeLine(height:Int):ActionType
    {
        var line = lineManager.unregister(height);
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
        return itemList.length;
    }

    public inline function get(i:Int):ItemImpl
    {
        return itemList[i];
    }
}
