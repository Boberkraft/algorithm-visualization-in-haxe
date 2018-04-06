package;

import algorithms.BubbleSort;
import algorithms.InsertionSort;
import algorithms.MergeSort;
import algorithms.SortingAlgorithm;
import algorithms.Template;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxG;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */

class PlayState extends FlxState
{

    var background:Background;
    var drawArea:DrawArea;
    var actionQueue:ActionQueue; // we need to check if all acions are done.
    var codeMenu:CodeMenu;
    
    override public function create():Void
    {
        super.create();
        FlxG.mouse.unload();
        FlxG.mouse.useSystemCursor = true;
        
        // pre initializes algorithm.
        var algClass = AlgorithmFactory.getAlgorithmClass(Status.activeAlgorithm);
        Type.createInstance(algClass, []).preInit();
        
        // the background of the main scene with blocks
        background = new Background();
        add(background);
        
        
        add(new GlobalTimer());
        
        //list of items
        var items:Array<Int>;
        if (Status.preloadedItems == null) {
            // load standard random items
            trace('generating random set of items');
            items  = DrawArea.generateShuffledItems(Status.howManyItems);
        }
        else {
            items = Status.preloadedItems;
        }

        drawArea = new DrawArea(items);
        codeMenu = new CodeMenu();

        add(codeMenu);

        
        //var sortingAlgo = Status.activeAlgorithm();
        
        //var algo = new BubbleSort(drawArea, codeMenu);
        //var algo = new InsertionSort(drawArea, codeMenu);
        
        var algo = Type.createInstance(algClass, [drawArea, codeMenu]);
        
        codeMenu.y = FlxG.height / 2 - codeMenu.height / 2;
        //codeMenu.x = Std.int(drawArea.x + drawArea.width + drawArea.width / 16);
        codeMenu.x = Std.int(FlxG.width - codeMenu.width - codeMenu.width/16);
        
        trace('width', drawArea.width);
        var actionQueue:ActionQueue = algo.generateActions();
                
        drawArea.x = Std.int(drawArea.width/16);
        drawArea.y = FlxG.height / 2 - drawArea.height / 2;
        
        if ( Status.activeAlgorithm == 'MergeSort') {
            drawArea.y /= 2; 
        }
        add(drawArea);
        drawArea.x = (FlxG.width - codeMenu.width) / 2 - drawArea.width / 2;
        add(actionQueue); // 
        actionQueue.start();
    }
    
    
    //#if js
    public static function loadAlgorithm(type:Dynamic)
    {
        Status.activeAlgorithm = type;
        FlxG.switchState(new PlayState());
    }
    //#end
    
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        if (FlxG.keys.pressed.LBRACKET) {
            Status.howManyItems -= 1;
        }
        if (FlxG.keys.pressed.RBRACKET) {
            Status.howManyItems += 1;
        }
    }
}
