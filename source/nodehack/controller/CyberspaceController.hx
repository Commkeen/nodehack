package nodehack.controller;
import nodehack.Enums.EAccess;
import nodehack.model.*;
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
		for (connection in _server.connections)
		{
			if (connection.node1.connected || connection.node2.connected)
			{
				connection.node1.visible = true;
				connection.node2.visible = true;
			}
		}
	}
	
	public static function connectNode(index:Int)
	{
		_server.nodes[index].connected = true;
		updateNodeVisibility();
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
	}
	
	public static function makeBypassAttempt(nodeIndex:Int)
	{
		removeTime(Constants.BYPASS_TIME);
		var successDifficulty = 0.2 * getBypassDifficulty(nodeIndex);
		var success = Math.random() > successDifficulty;
		if (!success)
		{
			removeTime(Constants.BYPASS_FAIL_TIME);
		}
		setNodeAccess(nodeIndex, EAccess.USER);
	}
	
	public static function makeDeleteAttempt(nodeIndex:Int)
	{
		removeTime(Constants.DELETE_TIME);
		removeKey();
		var successDifficulty = 0.2 * getDeleteDifficulty(nodeIndex);
		var success = Math.random() > successDifficulty;
		if (success)
		{
			setNodeAccess(nodeIndex, EAccess.ROOT);
		}
	}
	
}