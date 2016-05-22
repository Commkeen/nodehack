package nodehack.model;
import haxe.macro.ExprTools.ExprArrayTools;

/**
 * ...
 * @author Matthew Everett
 */
class Server
{

	public var name:String;
	public var difficulty:Int;
	public var nodes:Array<Node>;
	public var connections:Array<NodeConnection>;
	
	public function new() 
	{
		name = "Default Server";
		difficulty = 1;
		nodes = new Array<Node>();
		connections = new Array<NodeConnection>();
	}
	
}