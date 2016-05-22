package nodehack.view;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import nodehack.model.Action;
import nodehack.Color;
using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Matthew Everett
 */
class ActionButton extends FlxSpriteGroup
{

	public static var size = new FlxPoint(100, 40);
	
	var _action:Action;
	
	var _bg:FlxSprite;
	var _nameTxt:FlxText;
	
	public function new(action:Action) 
	{
		super();
		
		_bg = new FlxSprite();
		_bg.makeGraphic(Math.round(size.x), Math.round(size.y), Color.LIGHT);
		add(_bg);
		
		_nameTxt = new FlxText(10, 10, 0, action.name, Constants.UI_FONTSIZE);
		_nameTxt.font = Constants.UI_FONT;
		_nameTxt.color = Color.DARKEST;
		add(_nameTxt);
	}
	
	
}