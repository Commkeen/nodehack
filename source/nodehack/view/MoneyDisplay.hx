package nodehack.view;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.math.FlxPoint;

/**
 * ...
 * @author Matthew Everett
 */
class MoneyDisplay extends FlxSpriteGroup
{

	static var position:FlxPoint = new FlxPoint(550, 685);
	static var size:FlxPoint = new FlxPoint(250, 20);
	
	var _moneyTxt:FlxText;
	
	public function new() 
	{
		super(position.x, position.y);
		
		_moneyTxt = new FlxText(0, 0, size.x, "$0", Constants.UI_FONTSIZE);
		_moneyTxt.font = Constants.UI_FONT;
		_moneyTxt.color = Color.LIGHT;
		add(_moneyTxt);
	}
	
	public function setMoney(value:Int)
	{
		_moneyTxt.text = "$" + value;
	}
	
}