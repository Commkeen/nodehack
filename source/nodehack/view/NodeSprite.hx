package nodehack.view;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.math.FlxPoint;
import nodehack.model.Node;
import nodehack.Color;
using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Matthew Everett
 */
class NodeSprite extends FlxSpriteGroup
{

	public static var size = new FlxPoint(100, 100);
	
	var _node:Node;
	
	var _selected:Bool;
	
	public var box:FlxSprite;
	var _outline:FlxSprite;
	var _accessIcon:FlxSprite;
	var _nodeStrength:FlxText;
	var _nodeName:FlxText;
	var _nodeReward:FlxText;
	var _nodeIcon:FlxSprite;
	
	public function new(node:Node) 
	{
		super(node.position.x, node.position.y);
		_node = node;
		
		box = new FlxSprite();
		box.makeGraphic(Math.round(size.x), Math.round(size.y), Color.LIGHT);
		add(box);
		_outline = new FlxSprite();
		_outline.makeGraphic(Math.round(size.x), Math.round(size.y), Color.TRANSPARENT, true);
		add(_outline);
		
		_accessIcon = new FlxSprite(8, 8);
		_accessIcon.loadGraphic("assets/images/icons.png", true, 24, 24);
		_accessIcon.scale = new FlxPoint(1,1);
		add(_accessIcon);
		
		_nodeName = new FlxText(12, 30, 0, node.name, Constants.UI_FONTSIZE);
		_nodeName.font = Constants.UI_FONT;
		_nodeName.color = Color.DARKEST;
		add(_nodeName);
		
		_nodeStrength = new FlxText(38, 6, 0, "", Constants.UI_FONTSIZE);
		_nodeStrength.font = Constants.UI_FONT;
		_nodeStrength.color = Color.DARKEST;
		add(_nodeStrength);

		_nodeReward = new FlxText(38, 22, 0, "$" + node.moneyReward, Constants.UI_FONTSIZE);
		_nodeReward.font = Constants.UI_FONT;
		_nodeReward.color = Color.DARKEST;
		add(_nodeReward);
		
		if (node.ice != null)
			_nodeStrength.text = "ST " + node.ice.strength;
		
		redraw();
	}
	
	public function setSelected(isSelected:Bool)
	{
		_selected = isSelected;
		redraw();
	}
	
	public function redraw()
	{
		if (!_node.visible)
		{
			visible = false;
			return;
		}
		
		visible = true;
		_outline.fill(Color.TRANSPARENT);
		var line:LineStyle = { color:Color.DARK, thickness:3 };
		if (!_node.connected)
		{
			line.color = Color.TRANSPARENT;
		}
		if (_selected)
		{
			line.color = Color.LIGHTEST;
			line.thickness = 10;
		}
		_outline.drawRect(2, 2, size.x - 4, size.y - 4, Color.TRANSPARENT, line);
		
		
		if (!_node.connected)
		{
			_nodeName.visible = false;
			_nodeStrength.visible = true;
			_nodeReward.visible = true;
		}
		else
		{
			_nodeName.visible = true;
			_nodeStrength.visible = false;
			_nodeReward.visible = false;
		}
	}
	
}