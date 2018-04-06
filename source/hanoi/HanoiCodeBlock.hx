package hanoi;

import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;

import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

import ActionType;
/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */
class HanoiCodeBlock extends FlxSpriteGroup
{

    private var left:HanoiPeg;
    private var middle:HanoiPeg;
    private var right:HanoiPeg;

    public function new(left, middle, right)
    {
        super();
        this.left = left;
        this.middle = middle;
        add(middle);
        this.right = right;
        add(right);
        add(left);
        
        middle.x += HanoiBlock.MAX_WIDTH * 3 / 2;
        right.x += 2 * ( HanoiBlock.MAX_WIDTH * 3 / 2);
    }
    
    

}