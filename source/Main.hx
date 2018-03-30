package;

import algorithms.BubbleSort;
import algorithms.MergeSort;
import algorithms.QuickSort;
import algorithms.SortingAlgorithm;
import flixel.FlxGame;
import openfl.display.Sprite;

#if js
import js.AlgorithmChanger;
#end
/**
 * ...
 * @author Andrzej Bisewski
 * @email andrzej.bisewski@gmail.com
 * @github https://github.com/Boberkraft
 */
class Main extends Sprite
{
	public function new()
	{
		super();
        #if js
        AlgorithmChanger; // reference it just to keep and generate code for js. idk how to fix it.
        #end
        Status.activeAlgorithm = 'BogoSort';
        
        Status.preloadedItems = null;
		addChild(new FlxGame(0, 0, PlayState, 1, 60, 60, true, false));
	}
}
