package nodehack.view;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxPoint;

/**
 * ...
 * @author Matthew Everett
 */
class KeysDisplay extends FlxSpriteGroup
{

	static var position:FlxPoint = new FlxPoint(600, 685);
	static var size:FlxPoint = new FlxPoint(250, 20);
	
	var _keysTxt:FlxText;
	
	public function new() 
	{
		super(position.x, position.y);
		
		_keysTxt = new FlxText(0, 0, size.x, "Keys: 2", Constants.UI_FONTSIZE);
		_keysTxt.font = Constants.UI_FONT;
		_keysTxt.color = Color.LIGHT;
		add(_keysTxt);
	}
	
	public function setKeys(value:Int)
	{
		_keysTxt.text = "Keys: " + value;
	}
	
}