package nodehack.view;
import flixel.group.FlxSpriteGroup;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Matthew Everett
 */
class TimeBar extends FlxSpriteGroup
{

	static var position:FlxPoint = new FlxPoint(210, 655);
	static var size:FlxPoint = new FlxPoint(400, 20);
	
	var _outline:FlxSprite;
	var _bar:FlxSprite;
	var _txt:FlxText;
	
	var _maxTime:Int = 200;
	
	public function new() 
	{
		super(position.x, position.y);
		
		_outline = new FlxSprite(0, 0);
		_outline.makeGraphic(Math.round(size.x), Math.round(size.y), Color.TRANSPARENT);
		add(_outline);
		
		_bar = new FlxSprite(6, 6);
		_bar.makeGraphic(Math.round(size.x) - 12, Math.round(size.y) - 12, Color.LIGHT);
		add(_bar);
		
		_txt = new FlxText(size.x + 6, 0, 0, "100", Constants.UI_FONTSIZE);
		_txt.font = Constants.UI_FONT;
		_txt.color = Color.LIGHT;
		add(_txt);
		
		setTime(_maxTime);
	}
	
	public function setMaxTime(time:Int)
	{
		_maxTime = time;
	}
	
	public function setTime(time:Int)
	{
		_txt.text = "" + time;
		
		var line:LineStyle = { color:Color.LIGHT, thickness:4 };
		var fill:FillStyle = { color:Color.TRANSPARENT };
		_outline.drawRect(0, 0, size.x, size.y, Color.TRANSPARENT, line, fill);
		
		//_bar.fill(Color.TRANSPARENT);
		var barSize:Float = _bar.width;
		barSize = (time / _maxTime) * barSize;
		_bar.drawRect(0, 0, barSize, _bar.height, Color.LIGHT);
	}
	
}