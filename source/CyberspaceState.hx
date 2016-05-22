package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import nodehack.model.Node;
import nodehack.model.NodeConnection;
import nodehack.model.Server;
import nodehack.view.CyberspaceUI;
import nodehack.view.NodeSprite;
import flixel.group.FlxSpriteGroup;
import nodehack.Color;
import nodehack.controller.CyberspaceController;
using flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class CyberspaceState extends FlxState
{
	
	var _bgSprite:FlxSprite;
	
	var _nodeLayer:FlxSpriteGroup = new FlxSpriteGroup();
	var _uiLayer:FlxSpriteGroup = new FlxSpriteGroup();
	
	var _nodeSprites:Array<NodeSprite>;
	var _connectionLayer:FlxSprite;
	
	var _ui:CyberspaceUI;
	
	var _selectedNode:Int;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		_bgSprite = new FlxSprite();
		_bgSprite.makeGraphic(FlxG.width, FlxG.height, Color.DARKEST);
		add(_bgSprite);
		
		_connectionLayer = new FlxSprite();
		_connectionLayer.makeGraphic(FlxG.width, FlxG.height, Color.TRANSPARENT);
		add(_connectionLayer);
		
		add(_nodeLayer);
		add(_uiLayer);
		
		
		_ui = new CyberspaceUI();
		_uiLayer.add(_ui);
		loadServer(CyberspaceController.getServer());
	}
	
	public function loadServer(server:Server)
	{
		_nodeSprites = new Array<NodeSprite>();
		for (node in server.nodes)
		{
			addNodeToDisplay(node);
		}
		for (connection in server.connections)
		{
			if (connection.node1.connected || connection.node2.connected)
				drawNodeConnection(connection);
		}
		
		selectNode(0);
	}
	
	private function addNodeToDisplay(node:Node)
	{
		var sprite = new NodeSprite(node);
		_nodeLayer.add(sprite);
		_nodeSprites.push(sprite);
	}
	
	private function redrawServer()
	{
		for (node in _nodeSprites)
		{
			node.redraw();
		}
		for (connection in CyberspaceController.getServer().connections)
		{
			if (connection.node1.connected || connection.node2.connected)
				drawNodeConnection(connection);
		}
		_ui.updateSelectedNode(CyberspaceController.getServer().nodes[_selectedNode]);
	}
	
	private function drawNodeConnection(connection:NodeConnection)
	{
		var line:LineStyle = { color:Color.LIGHT, thickness:2 };
		_connectionLayer.drawLine(
							connection.node1.position.x + NodeSprite.size.x/2,
							connection.node1.position.y + NodeSprite.size.y/2,
							connection.node2.position.x + NodeSprite.size.x/2,
							connection.node2.position.y + NodeSprite.size.y/2,
							line);
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
	override public function update():Void
	{
		super.update();
		updateMouse();
		if (FlxG.keys.justPressed.SPACE && _selectedNode >= 0)
		{
			if (!CyberspaceController.getServer().nodes[_selectedNode].connected)
			{
				CyberspaceController.connectNode(_selectedNode);
				redrawServer();
			}
		}
	}
	
	//Check whether user has clicked any nodes
	private function updateMouse()
	{
		if (FlxG.mouse.justPressed)
		{
			var nodeClicked:Bool = false;
			for (index in 0..._nodeSprites.length)
			{
				if (_nodeSprites[index].box.overlapsPoint(FlxG.mouse.getWorldPosition()))
				{
					nodeClicked = true;
					selectNode(index);
				}
			}
		}
	}
	
	private function selectNode(index:Int)
	{
		if (_selectedNode >= 0)
		{
			_nodeSprites[_selectedNode].setSelected(false);
		}
		_selectedNode = index;
		_nodeSprites[_selectedNode].setSelected(true);
		
		_ui.updateSelectedNode(CyberspaceController.getServer().nodes[_selectedNode]);
	}
	
}