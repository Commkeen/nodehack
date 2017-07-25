package nodehack.view;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import flixel.FlxSprite;

/**
 * ...
 * @author Matthew Everett
 */
class MessagePanel extends FlxSpriteGroup
{

	public static var size:FlxPoint = new FlxPoint(810, 110);
	public static var position:FlxPoint = new FlxPoint(5, 0);
	static var _queueLength = 5;
	
	var _bg:FlxSprite;
	
	var _currentTxt:FlxText;
	var _backTxt:FlxText;
	
	var _msgQueue:Array<String> = new Array<String>();
	
	public function new() 
	{
		super(position.x, position.y);
		
		_bg = new FlxSprite();
		_bg.makeGraphic(Math.round(size.x), Math.round(size.y), Color.DARK);
		add(_bg);
		
		_currentTxt = new FlxText(10, 82, 800, "", Constants.UI_FONTSIZE);
		_currentTxt.font = Constants.UI_FONT;
		_currentTxt.color = Color.LIGHTEST;
		add(_currentTxt);
		
		_backTxt = new FlxText(10, 10, 800, "", Constants.UI_FONTSIZE);
		_backTxt.font = Constants.UI_FONT;
		_backTxt.color = Color.LIGHT;
		add(_backTxt);
		
		for (i in 0..._queueLength)
			_msgQueue.push("");
		
		printLine("This is my first message.");
		printLine("This is my second message.");
		printLine("This is my third message.");
		printLine("This is my fourth message.");
		printLine("This is my fifth message.");
	}
	
	public function printLine(msg:String)
	{
		_msgQueue.insert(0, msg);
		while (_msgQueue.length > _queueLength)
		{
			_msgQueue.pop();
		}
		_currentTxt.text = _msgQueue[0];
		
		var oldTxt = "";
		for (i in 1..._msgQueue.length)
		{
			oldTxt = _msgQueue[i] + "\n" + oldTxt;
		}
		_backTxt.text = oldTxt;
	}
	
}