package;

import flixel.FlxGame;
import openfl.display.Sprite;
import AlgorithmType;


class Main extends Sprite
{
	public function new()
	{
		super();
        Status.setAlgorithm(AlgorithmType.BubbleSort);
		addChild(new FlxGame(0, 0, PlayState, true));
	}
    

}
