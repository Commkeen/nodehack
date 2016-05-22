package nodehack.model;

/**
 * ...
 * @author Matthew Everett
 */
class Action
{

	public var name:String;
	public var desc:String;
	public var timeCost:Int;
	public var event:Void->Void;
	
	public function new(name:String) 
	{
		this.name = name;
	}
	
}