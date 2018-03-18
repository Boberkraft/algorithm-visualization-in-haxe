package;

import flixel.FlxGame;
import openfl.display.Sprite;
import AlgorithmType;
import js.AlgorithmChanger;

class Main extends Sprite
{
	public function new()
	{
		super();
        Status.setAlgorithm(AlgorithmType.QuickSort);
		addChild(new FlxGame(0, 0, PlayState, 1, 60, 60, true, false));
	}
}
