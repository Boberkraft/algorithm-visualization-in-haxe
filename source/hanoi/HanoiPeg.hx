package hanoi;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */
class HanoiPeg extends FlxSpriteGroup
{
    
    //MUST BE SETTEN BEFORE
    public static var MAX_BLOCKS:Int;
    public static var MAX_HEIGHT:Int;
    
    public var name:String;
    public var blockCount = 0;
    
    public var blocks:Array<HanoiBlock> = [];
    
    public function new(name:String, initialBlocks:Array<Int>) 
    {   
        super();
        HanoiPeg.MAX_HEIGHT = HanoiPeg.MAX_BLOCKS * (2 * HanoiBlock.MAX_HEIGHT) - HanoiBlock.MAX_HEIGHT;
        
        this.name = name;
        var peg = new FlxSprite().makeGraphic(Std.int(HanoiBlock.MAX_HEIGHT/2), Std.int(11 / 10 * MAX_HEIGHT), Status.pickColor);
        peg.y -= Std.int(1 / 10 * MAX_HEIGHT) ;
        peg.y += Std.int(2 * HanoiBlock.MAX_HEIGHT - HanoiBlock.MAX_HEIGHT/10 );
        peg.x = Std.int(HanoiBlock.MAX_WIDTH / 2 - peg.width/2) ;
        add(peg);
        
        for (val in initialBlocks) {
            addBlock(val);
        }
    }
    
    public function addBlock(value:Int):HanoiBlock
    {
        var block = new HanoiBlock(value);
        
        block.x = Std.int(HanoiBlock.MAX_WIDTH/2 - block.width/2);
        //block.x = -1000;
        //block.y = -1000;
        block.y = MAX_HEIGHT;
        block.y -= blockCount * 2 * HanoiBlock.MAX_HEIGHT - HanoiBlock.MAX_HEIGHT;
        
        add(block);
        blocks.push(block);
        
        blockCount++;
        return block;
    }
    
    public function pop():HanoiBlock
    {
        blockCount -= 1;
        return blocks.pop();
    }
    
    public function push(block:HanoiBlock)
    {
        blockCount += 1;
        blocks.push(block);
    }
    public function moveBlockUp(block:HanoiBlock, speed:Float, wait:Float):Void->ActionType
    {
        var height = blockCount;
        return function () {
            return T_MANY([T_SINGLE(ActionQueue.wait(wait)),
                           T_SINGLE(FlxTween.tween(block, {y:Std.int(this.y - 4/3 * HanoiBlock.MAX_HEIGHT)}, speed, {ease:FlxEase.smootherStepInOut}))]);
        }
    }
    public function moveBlockOver(block:HanoiBlock, peg:HanoiPeg,  speed:Float, wait:Float):Void->ActionType
    {
        var height = blockCount;
        
        return function () {
            
            return T_MANY([T_SINGLE(ActionQueue.wait(wait)),
                           T_SINGLE(FlxTween.tween(block, {x:Std.int(peg.x + HanoiBlock.MAX_WIDTH/2 - block.width/2)}, speed, {ease:FlxEase.smootherStepInOut}))]);
        }
    }
    public function putBlockOn(block:HanoiBlock, speed:Float, wait:Float):Void->ActionType
    {
        var blCount = blockCount;
        return function () {
            return T_MANY([T_SINGLE(ActionQueue.wait(wait)),
                           T_SINGLE(FlxTween.tween(block, 
                                                   {y:Std.int(this.y + HanoiPeg.MAX_HEIGHT - (2 * blCount * HanoiBlock.MAX_HEIGHT - HanoiBlock.MAX_HEIGHT))}, 
                                                   speed, 
                                                   {ease:FlxEase.smootherStepInOut}))
                           ]);
        }
    }
    
}