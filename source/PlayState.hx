package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxG;
import flixel.tweens.FlxTween;

@:expose
class PlayState extends FlxState
{

    private var background:Background;
    private var itemList:ItemList;
    
    private var swapStatus:FlxTween = null;
    private var pickedItem:ItemImpl;
    
    private var algorithmQueue:AlgorithmQueue;
    
    private var codeMenu:CodeMenu;
    override public function create():Void
    {
        super.create();
        FlxG.mouse.unload();
        FlxG.mouse.useSystemCursor = true;
           
        
        //
        // the background of the main scene with blocks
        background = new Background();
        add(background);
        
        
        add(new GlobalTimer());
        //list of items
        itemList = new ItemList(14);
        itemList.x = itemList.width/16;
        itemList.y = FlxG.height / 2 -itemList.height/2;
        add(itemList);
        
        codeMenu = new CodeMenu();
        codeMenu.generateCodeMenu();
        add(codeMenu);
        codeMenu.y = FlxG.height / 2 - codeMenu.height / 2;
        codeMenu.x = itemList.x + itemList.width + itemList.width/16;
        
        var actions = AlgorithmQueue.generateOperations(itemList, codeMenu);
        add(actions);
        actions.start();
    }
    
    
    //#if js
    public static function loadAlgorithm(type:AlgorithmType)
    {
        Status.setAlgorithm(type);
        FlxG.switchState(new PlayState());
    }
    //#end
    
    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        

    }
}
