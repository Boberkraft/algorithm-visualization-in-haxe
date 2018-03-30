package js;

import flixel.FlxG;
import js.Browser.document;
import js.Browser.window;
/**
 * ...
 * @author Andrzej
 */
@:keep
@:expose
class AlgorithmChanger 
{

    public static function load(type:String)
    {
        
        if (AlgorithmFactory.availivable.indexOf(type) == -1) {
            throw 'Unknown Algorithm!: ' + type;
        }
        Status.activeAlgorithm = type;
        FlxG.switchState(new PlayState());
        init();
    }
    
    
    private static function init()
    {
        var codeImplementationAnchor = document.getElementById("codeImplementation");
        var descAnchor = document.getElementById("desc");
        codeImplementationAnchor.innerHTML = '...';
        descAnchor.innerHTML = '...';
        untyped window.hljs.initHighlighting.called = false;
        untyped window.hljs.initHighlighting();
    }
}
