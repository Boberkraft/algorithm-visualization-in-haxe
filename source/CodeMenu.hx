package;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */
class CodeMenu extends FlxSpriteGroup
{
    public var TEXT_HEIGHT = 16;
    
    private var code:Array<String>;
    private var texts:Array<FlxText>;
    private var textsBackground:Array<FlxSprite>;
    private var lastTextY = 0;
    private var highlightedLine = 0;
    
    public function new()
    {
        super();
    }
    
    public function loadCode(code:Array<String>)
    {
        this.code = code;
        init(code);
    }
    
    function init(code:Array<String>)
    {
        texts = [];
        textsBackground = [];
        var maxWidth = 0.0;
        for (row in code)
        {
            var text = new FlxText(0, lastTextY, 0, row, TEXT_HEIGHT);
            text.font = 'Arial';
            if (text.width > maxWidth) {
                maxWidth = text.width;
            }
            texts.push(text);
            lastTextY = Std.int(text.y + text.height);
        }
        for (text in texts)
        {
            var back = new FlxSprite(0, text.y);
            textsBackground.push(back);
            back.makeGraphic(Std.int(maxWidth), Std.int(text.height), 0xffffffff);
            back.color = Status.idleCodeColor;
            add(back);
            add(text);
        }
    }

    public function hilightLine(line:Int)
    {
        textsBackground[highlightedLine].color = Status.idleCodeColor;
        texts[highlightedLine].color = Color.White;

        textsBackground[line].color = Status.pickCodeColor;
        texts[line].color = Color.Black;

        highlightedLine = line;
    }
    public function stopLineHilighting()
    {
        textsBackground[highlightedLine].color = Status.idleCodeColor;
        texts[highlightedLine].color = Color.White;
    }
    function _generateCodeMenu()
    {
        throw 'not used anymore';
        //var code:Array<String> = switch (Status.algorithm)
        //{
//
            //case AlgorithmType.InsertionSort:

            //case AlgorithmType.MergeSort:

            //case AlgorithmType.QuickSort:

        //}
        ////trace(code);
        //init(code);
    }

}