package nodehack.view;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.FlxG;
import flixel.text.FlxText;
import nodehack.Color;
import nodehack.model.Action;
import nodehack.model.Node;
import nodehack.controller.CyberspaceController;
import nodehack.controller.GameController;

/**
 * ...
 * @author Matthew Everett
 */
class CyberspaceUI extends FlxSpriteGroup
{

	var _bottomPanelBg:FlxSprite;
	var _rightPanelBg:FlxSprite;
	
	var _actionButtons:Array<ActionButton> = new Array<ActionButton>();
	
	var _bypassTimeCost:FlxText = new FlxText();
	var _deleteTimeCost:FlxText = new FlxText();
	var _deleteCodeCost:FlxText = new FlxText();
	
	var _messagePanel:MessagePanel;
	var _nodeOverview:NodeOverviewPanel;
	var _iceOverview:IceOverviewPanel;
	var _timeBar:TimeBar;
	var _keysDisplay:KeysDisplay;
	var _moneyDisplay:MoneyDisplay;
	var _mousePos:FlxText = new FlxText();
	
	public function new() 
	{
		super();
		scrollFactor.x = 0;
		scrollFactor.y = 0;
		
		_bottomPanelBg = new FlxSprite(0, FlxG.height - 120);
		_bottomPanelBg.makeGraphic(FlxG.width, 120, Color.DARK);
		add(_bottomPanelBg);
		
		_rightPanelBg = new FlxSprite(FlxG.width - 200, 0);
		_rightPanelBg.makeGraphic(200, FlxG.height, Color.DARK);
		add(_rightPanelBg);
		
		_messagePanel = new MessagePanel();
		add(_messagePanel);
		
		_mousePos.color = 0xFFFFFFFF;
		add(_mousePos);
		
		_nodeOverview = new NodeOverviewPanel();
		add(_nodeOverview);
		
		_iceOverview = new IceOverviewPanel();
		add(_iceOverview);
		
		//var testAction:Action = new Action("Bypass");
		//var testAction2:Action = new Action("Delete");
		//var actionSprite:ActionButton = new ActionButton(testAction);
		//add(actionSprite);
		//actionSprite.setPosition(20, FlxG.height - 110);
		//var actionSprite2:ActionButton = new ActionButton(testAction2);
		//add(actionSprite2);
		//actionSprite2.setPosition(20, FlxG.height - 55);
		
		_bypassTimeCost = new FlxText(140, FlxG.height - 110, 0, "5 T", Constants.UI_FONTSIZE);
		_bypassTimeCost.font = Constants.UI_FONT;
		add(_bypassTimeCost);
		
		_deleteTimeCost = new FlxText(140, FlxG.height - 55, 0, "9 T", Constants.UI_FONTSIZE);
		_deleteTimeCost.font = Constants.UI_FONT;
		add(_deleteTimeCost);
		_deleteCodeCost = new FlxText(140, FlxG.height - 35, 0, "1 C", Constants.UI_FONTSIZE);
		_deleteCodeCost.font = Constants.UI_FONT;
		add(_deleteCodeCost);
		
		_timeBar = new TimeBar();
		_timeBar.setMaxTime(CyberspaceController.getTime());
		_timeBar.setTime(CyberspaceController.getTime());
		add(_timeBar);
		
		_keysDisplay = new KeysDisplay();
		_keysDisplay.setKeys(CyberspaceController.getKeys());
		add(_keysDisplay);

		_moneyDisplay = new MoneyDisplay();
		_moneyDisplay.setMoney(GameController.getHacker().money);
		add(_moneyDisplay);
	}
	
	public function addActionButton(action:Action, x:Int, y:Int)
	{
		var button = new ActionButton(action);
		button.setPosition(x,y);
		add(button);
		_actionButtons.push(button);
	}
	
	public function clearActionButtons()
	{
		while (_actionButtons.length != 0)
		{
			remove(_actionButtons.pop());
		}
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		_mousePos.text = "X: " + FlxG.mouse.screenX + " Y: " + FlxG.mouse.screenY;
		if (FlxG.mouse.justPressed)
		{
			var actionButtonPressed = null;
			for (index in 0..._actionButtons.length)
			{
				if (_actionButtons[index].box.overlapsPoint(FlxG.mouse.getScreenPosition()))
				{
					actionButtonPressed = _actionButtons[index];
				}
			}
			if (actionButtonPressed != null)
				actionButtonPressed.buttonClicked();
		}
		_timeBar.setTime(CyberspaceController.getTime());
		_keysDisplay.setKeys(CyberspaceController.getKeys());
		_moneyDisplay.setMoney(GameController.getHacker().money);
	}
	
	public function updateSelectedNode(node:Node)
	{
		if (!node.connected)
		{
			_nodeOverview.updateInfo(null);
			_iceOverview.updateInfo(null);
		}
		else
		{
			_nodeOverview.updateInfo(node);
			_iceOverview.updateInfo(node.ice);
		}
	}
	
	public function printLine(msg:String)
	{
		_messagePanel.printLine(msg);
	}
	
	
	
}