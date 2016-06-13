package nodehack.view;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxPoint;
import nodehack.model.Node;
import nodehack.Enums;

/**
 * ...
 * @author Matthew Everett
 */
class NodeOverviewPanel extends FlxSpriteGroup
{

	static var size = new FlxPoint(190, 150);
	static var position = new FlxPoint(830, 10);
	
	var _bg:FlxSprite;
	
	var _name:FlxText;
	var _access:FlxText;
	
	public function new() 
	{
		super(position.x, position.y);
		
		_bg = new FlxSprite();
		_bg.makeGraphic(Math.round(size.x), Math.round(size.y), Color.LIGHTEST);
		add(_bg);
		
		_name = new FlxText(10, 10, 0, "Processor", Constants.UI_FONTSIZE);
		_name.font = Constants.UI_FONT;
		_name.color = Color.DARKEST;
		add(_name);
		
		_access = new FlxText(10, 40, 0, "Access: None", Constants.UI_FONTSIZE);
		_access.font = Constants.UI_FONT;
		_access.color = Color.DARKEST;
		add(_access);
	}
	
	public function updateInfo(node:Node)
	{
		if (node == null)
		{
			visible = false;
			return;
		}
		
		visible = true;
		_name.text = node.name;
		_access.text = "Access: ";
		switch node.access {
			case EAccess.NONE: _access.text += "None";
			case EAccess.USER: _access.text += "User";
			case EAccess.ROOT: _access.text += "Root";
		}
	}
	
}