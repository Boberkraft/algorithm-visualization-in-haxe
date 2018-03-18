package;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

/**
 * ...
 * @author Andrzej
 */
class BracketManager extends FlxTypedSpriteGroup<Bracket>
{
    private var registrated:Map<Int, Bracket>;
    public function new()
    {
        super();
        registrated = new Map<Int, Bracket>();
    }
    public function register(where:Int, height:Int, bracket:Bracket)
    {
        var index = where +  10000 * height;
        
        if (registrated[index] != null)
        {
            var def = [ for (el in registrated.keys()) el];
            throw 'Bracket $index is already defined here!\nDefined Brackets = \n $def';
        }
        bracket.y = Std.int(Bracket.WIDTHPIXELS * 3.5 * height);
        add(bracket);
        //trace('Adding bracket at $where, $height');
        registrated[index] = bracket;
    }
    public function unregister(where:Int, height:Int)
    {
        var index = where +  10000 * height;
        var bracket = registrated[index];
        //trace('Bracket to remove $bracket');
        
        return bracket;
        registrated.remove(index);
        
    }

}