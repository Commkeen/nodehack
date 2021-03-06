package nodehack.model;
import flixel.math.FlxPoint;
import nodehack.Enums.EAccess;
import nodehack.Enums.ENodeType;

/**
 * ...
 * @author Matthew Everett
 */
class Node
{

	public var position:FlxPoint = new FlxPoint(0, 0);
	public var name:String;
	public var ice:Ice;
	public var access:EAccess;
	public var connected:Bool;
	public var visible:Bool;
	public var moneyReward:Int;
	public var type:ENodeType;
	
	public function new(position:FlxPoint, name:String, ice:Ice) 
	{
		this.position.set(position.x, position.y);
		this.name = name;
		this.ice = ice;
		this.connected = false;
		this.visible = false;
		this.access = EAccess.NONE;
		this.moneyReward = 0;
		this.type = ENodeType.NONE;
	}
	
}