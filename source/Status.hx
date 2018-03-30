package;
import algorithms.SortingAlgorithm;
import flixel.util.FlxColor;

/**
 * ...
 * @author Andrzej
 */
class Status
{

    //selected algorithm
    public static var activeAlgorithm:String;
    //
    
    //based on this values, the DrawArea with items is generated.
    //set in main and when new algorithm is loaded
    public static var preloadedItems:Array<Int>;
    
    //colors
    public static var pickColor:FlxColor = Color.Turquoise;
    public static var pickColorSecondary:FlxColor = Color.GreenJungle;
    public static var pickColorTertiary:FlxColor = Color.Purple;
    public static var idleColor:FlxColor = Color.Black;

    public static var doneColor:FlxColor = Color.White;
    public static var backgroundColor:FlxColor = Color.PinkCrimson;

    public static var idleCodeColor:FlxColor = Status.backgroundColor;
    public static var pickCodeColor:FlxColor = Status.pickColor;
    
    //


}