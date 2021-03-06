package nodehack.controller;
import nodehack.Enums.EAccess;
import nodehack.model.*;
import nodehack.states.GameOverState;
import flixel.FlxG;

/**
 * ...
 * @author Matthew Everett
 */
class CyberspaceController
{
	static var _server:Server;
	static var _time:Int;
	static var _keys:Int;
	static var _state:CyberspaceState;
	
	public static function initLevel(server:Server)
	{
		_server = server;
		_time = 200;
		_keys = 3;
		updateNodeVisibility();
		_state = new CyberspaceState();
		FlxG.switchState(_state);
	}
	
	public static function getServer():Server
	{
		return _server;
	}
	
	public static function getKeys():Int
	{
		return _keys;
	}
	
	public static function getTime():Int
	{
		return _time;
	}
	
	public static function getConnectDifficulty(nodeIndex:Int)
	{
		var result = 0;
		var ice = _server.nodes[nodeIndex].ice;
		if (ice != null)
		{
			result = ice.strength;
			//TODO: modifiers
		}
		return result;
	}

	public static function getBypassDifficulty(nodeIndex:Int)
	{
		var result = 0;
		var ice = _server.nodes[nodeIndex].ice;
		if (ice != null)
		{
			result = ice.strength;
			//TODO: modifiers
		}
		return result;
	}
	
	public static function getDeleteDifficulty(nodeIndex:Int)
	{
		var result = getBypassDifficulty(nodeIndex);
		//TODO: modifiers
		return result + Constants.DELETE_DIFFICULTY_MOD;
	}
	
	private static function updateNodeVisibility()
	{
		for (node in _server.nodes)
		{
			if (node.connected)
				node.visible = true;
		}
		
		for (connection in _server.connections)
		{
			if (connection.node1.connected && connection.node1.access != EAccess.NONE
				|| connection.node2.connected && connection.node2.access != EAccess.NONE)
			{
				connection.node1.visible = true;
				connection.node2.visible = true;
			}
		}
	}
	
	public static function connectNode(index:Int)
	{
		_server.nodes[index].connected = true;
		setNodeAccess(index, EAccess.USER);
		GameController.getHacker().money += _server.nodes[index].moneyReward;
		_state.printLine("Connection established.");
		updateNodeVisibility();
		_state.redrawServer();
	}
	
	public static function setNodeAccess(index:Int, access:EAccess)
	{
		_server.nodes[index].access = access;
	}
	
	public static function removeIceFromNode(index:Int)
	{
		_server.nodes[index].ice = null;
	}
	
	public static function addKey()
	{
		_keys++;
	}
	
	public static function removeKey()
	{
		_keys--;
	}
	
	public static function removeTime(amount:Int)
	{
		_time -= amount;
		if (_time < 0)
			_time = 0;
		if (_time == 0)
			FlxG.switchState(new GameOverState());
	}
	
	public static function makeConnectAttempt(nodeIndex:Int)
	{
		removeTime(Constants.CONNECT_TIME);
		var successDifficulty = 0.2 * getConnectDifficulty(nodeIndex);
		var success = Math.random() > successDifficulty;
		if (success)
		{
			connectNode(nodeIndex);
		}
		else
		{
			_state.printLine("Access denied.");
		}
	}

	public static function makeBypassAttempt(nodeIndex:Int)
	{
		removeTime(Constants.BYPASS_TIME);
		_state.printLine("Bypassing node.");
		var successDifficulty = 0.2 * getBypassDifficulty(nodeIndex);
		var success = Math.random() > successDifficulty;
		if (!success)
		{
			removeTime(Constants.BYPASS_FAIL_TIME);
			_state.printLine("Initial bypass failure, time lost.");
		}
		else
		{
			_state.printLine("Bypass successful.");
		}
		setNodeAccess(nodeIndex, EAccess.USER);
		updateNodeVisibility();
		_state.redrawServer();
	}
	
	public static function makeDeleteAttempt(nodeIndex:Int)
	{
		if (getKeys() <= 0)
		{
			_state.printLine("Error - Polymorphic encryption key needed.");
			return;
		}
		removeTime(Constants.DELETE_TIME);
		removeKey();
		_state.printLine("Attempting to delete ICE.");
		var successDifficulty = 0.2 * getDeleteDifficulty(nodeIndex);
		var success = Math.random() > successDifficulty;
		if (success)
		{
			_state.printLine("ICE purged.");
			setNodeAccess(nodeIndex, EAccess.ROOT);
			getServer().nodes[nodeIndex].ice = null;
		}
		else
		{
			_state.printLine("Error - delete failed.");
		}
		updateNodeVisibility();
		_state.redrawServer();
	}

	public static function gotoNextLevel()
	{
		var levelGen = new LevelGen();
		var newServer = levelGen.generateServer(_server.difficulty + 1);
		initLevel(newServer);
	}
	
}