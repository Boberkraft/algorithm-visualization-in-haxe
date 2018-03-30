package;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;


/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */
class LineManager extends FlxTypedSpriteGroup<Line>
{
    private var registrated:Map<Int, Line>;
    public function new()
    {
        super();
        registrated = new Map<Int, Line>();
    }
    public function register(height:Int, line:Line)
    {
        //trace('registering Line at $height');
        if (registrated[height] != null)
        {
            var def = [ for (el in registrated.keys()) el];
            throw 'Line ($height) is already defined here!\nDefined lines = \n $def';
        }
        add(line);
        //trace('Adding bracket at $where, $height');
        registrated[height] = line;
    }
    public function unregister(height:Int)
    {
        var line:Line = registrated[height];
        
        return line;
        registrated.remove(height);
        
    }

}