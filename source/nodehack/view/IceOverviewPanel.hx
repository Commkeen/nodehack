package nodehack.view;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import flixel.FlxSprite;
import nodehack.model.Ice;

/**
 * ...
 * @author Matthew Everett
 */
class IceOverviewPanel extends FlxSpriteGroup
{

	static var size = new FlxPoint(190, 150);
	static var position = new FlxPoint(830, 200);
	
	var _bg:FlxSprite;
	
	var _name:FlxText;
	var _strength:FlxText;
	
	public function new() 
	{
		super(position.x, position.y);
		
		_bg = new FlxSprite();
		_bg.makeGraphic(Math.round(size.x), Math.round(size.y), Color.LIGHTEST);
		add(_bg);
		
		_name = new FlxText(10, 10, 0, "Barrier", Constants.UI_FONTSIZE);
		_name.font = Constants.UI_FONT;
		_name.color = Color.DARKEST;
		add(_name);
		
		_strength = new FlxText(10, 40, 0, "Strength: 2", Constants.UI_FONTSIZE);
		_strength.font = Constants.UI_FONT;
		_strength.color = Color.DARKEST;
		add(_strength);
	}
	
	public function updateInfo(ice:Ice)
	{
		if (ice == null)
		{
			_name.text = "";
			_strength.text = "";
			visible = false;
			return;
		}
		
		visible = true;
		_name.text = ice.name;
		_strength.text = "Strength: " + ice.strength;
	}
	
}