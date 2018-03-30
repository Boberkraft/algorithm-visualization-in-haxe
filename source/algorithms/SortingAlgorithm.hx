package algorithms;

import flixel.util.FlxColor;
/**
 * ...
 * @author Andrzej
 */
@:expose
class SortingAlgorithm
{

    public var speed = 1;
    // TODO: add a macro to check if all fields are correct, no missing or invalid ones
    public var description:Map<String, String> = [
                'englishName' => '_default_ englishName',
                'polishName' => '_default_ polishName',
                'main' => '_default_ main',
                'implementation' => '_default_ implementation',
                'speed' => '_default_ speed',
            ];

    // this allows us to invoke aprop. methods in local functions
    var drawArea:DrawArea;
    var codeMenu:CodeMenu;

    // Array filed with items. This way we can reference to individual objects to eq.
    // color them
    var data:Array<Item>;

    // Event queue.
    // each subclass adds events coresponding to actions that the algorithm made to stuff.
    var queue:ActionQueue;

    var code:Array<String> = ['_default_ code'];

    var S_SetColor = 0.2;
    var S_MoveItem = 0.2;
    var S_NormWait = 0.5;
    var S_LineWait = 0.5;

    public function new(itemInterface:DrawArea, codeMenuInterface:CodeMenu)
    {
        if (itemInterface == null && codeMenuInterface == null) {
            //just for insepction!
            return;
        }
        drawArea = itemInterface;
        
        codeMenu = codeMenuInterface;
        
        
        queue = new ActionQueue();
    } // new
    
    
    public function generateActions():ActionQueue
    {
        data = drawArea.getItems();
        trace('Unsorted items:');
        trace([for (item in data) item.value]);
        _generateActions();
            
        queue.push(function()
        {
            codeMenu.stopLineHilighting();
            return T_SINGLE(ActionQueue.wait(0.1));
        });
        trace('Sorted items:');
        trace([for (item in data) item.value]);
        return queue;

    } // generateActions
    
    private function init()
    {
        if (codeMenu != null)
        {
            codeMenu.loadCode(code);
            trace(description['englishName']);
            trace(code);
        }
    }
    // to be overriden by subclasses
    private function _generateActions()
    { throw 'Must be overriden by subclass'; }

    // to be overriden by subclasses
    // initalizes stuff like a overriden costructor


    // ----------------- HELPER FUNCIONS FOR CLARITY ------------------ //

    // setting default colorSettingTime if it is -1
    function Q_setColor(item:Item, color:FlxColor, ?waitTime:Float=0, ?colorSettingTime:Float=-1):Void->ActionType
    {
        if (colorSettingTime == -1)
        {
            waitTime = S_SetColor * speed;
        }
        return function()
        {
            
            return T_MANY([T_SINGLE(ActionQueue.wait(waitTime * speed)),
                drawArea.setColorForItem(item, color, waitTime * speed)]);
        }
    }

    // setting default waitTime if it is -1
    function Q_hilightLine(line:Int, ?waitTime:Float=-1):Void->ActionType
    {
        var waitTime:Float = waitTime;
        
        if ( waitTime == -1)
        {
            waitTime = S_LineWait * speed;
        }
        return function()
        {
            codeMenu.hilightLine(line);
            return T_SINGLE(ActionQueue.wait(waitTime * speed));
        }
    }
    
    

}