package;
import flixel.util.FlxColor;

/**
 * ...
 * @author Andrzej
 */
class Status 
{
    
    //selected algorithm
    public static var algorithm:AlgorithmType;
    //
    
    //colors
    public static var pickColor:FlxColor;
    public static var pickColorSecondary:FlxColor;
    public static var idleColor:FlxColor;
    
    public static var doneColor:FlxColor;
    public static var backgroundColor:FlxColor;
    
    public static var idleCodeColor:FlxColor;
    public static var pickCodeColor:FlxColor;
    //
    

    public static function setAlgorithm(alg:AlgorithmType)
    {
        Status.algorithm = alg;
        Status.pickColor = Color.Turquoise;
        Status.pickColorSecondary = Color.GreenJungle;
        Status.idleColor = Color.Black;
        Status.backgroundColor = Color.PinkCrimson;
        Status.doneColor = Color.White;

        Status.idleCodeColor = Status.backgroundColor;
        Status.pickCodeColor = Status.pickColor;
        switch (alg)
        {
            case BubbleSort:
                //Status.pickColor = Color.Black;
                //Status.pickColorSecondary = Color.GreenJungle;
                //Status.idleColor = Color.Turquoise;
                //Status.backgroundColor = Color.PinkCrimson;
                //Status.doneColor = Color.PinkRed;                
            case InsertionSort:
        }
    }
    
}