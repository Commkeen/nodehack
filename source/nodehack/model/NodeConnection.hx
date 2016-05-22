package nodehack.model;

/**
 * ...
 * @author Matthew Everett
 */
class NodeConnection
{

	public var node1:Node;
	public var node2:Node;
	
	public function new(node1:Node, node2:Node) 
	{
		this.node1 = node1;
		this.node2 = node2;
	}
	
}