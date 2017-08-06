package nodehack.states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import nodehack.controller.GameController;

/**
 * A FlxState which can be used for the game's menu.
 */
class GameOverState extends FlxState
{
	
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		this.bgColor = Color.DARKEST;
		this.add(new FlxText(400, 250, 0, "Final Money: $" + GameController.hacker.money, Constants.UI_FONTSIZE));
		this.add(new FlxButton(400, 300, "Reset Game", GameController.initGame));
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}	
}