package nodehack.controller;
import nodehack.model.Hacker;

/**
 * ...
 * @author Matthew Everett
 */
class GameController
{

	public static var hacker:Hacker;
	
	public static function initGame()
	{
		var levelGen:LevelGen = new LevelGen();
		var server = levelGen.generateServer(1);
		CyberspaceController.initLevel(server);
	}
	
	
}