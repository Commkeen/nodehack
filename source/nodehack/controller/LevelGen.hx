package nodehack.controller;
import flixel.math.FlxPoint;
import nodehack.model.*;

/**
 * ...
 * @author Matthew Everett
 */
class LevelGen
{

	public function new() 
	{
		
	}
	
	public function generateServer(difficulty:Int):Server
	{
		var server = new Server();
		server.difficulty = difficulty;
		server.name = "A Server";
		
		var ice = new Ice("Barrier", 2);
		var ice2 = new Ice("Sentry", 3);
		var ice3 = new Ice("Barrier", 2);
		var ice4 = new Ice("Sentry", 3);
		var ice5 = new Ice("Tracker", 4);
		var ice6 = new Ice("Guardian", 5);
		var ice7 = new Ice("Sentry", 3);
		
		var node = new Node(new FlxPoint(280, 510), "Interlink", ice);
		server.nodes.push(node);
		var node2 = new Node(new FlxPoint(280, 360), "Subprocessor", ice2);
		server.nodes.push(node2);
		var node3 = new Node(new FlxPoint(50, 480), "Datastore", ice3);
		server.nodes.push(node3);
		var node4 = new Node(new FlxPoint(50, 330), "Subprocessor", ice4);
		server.nodes.push(node4);
		
		server.connections.push(new NodeConnection(node, node2));
		server.connections.push(new NodeConnection(node2, node3));
		server.connections.push(new NodeConnection(node3, node4));
		server.connections.push(new NodeConnection(node4, node2));
		
		node.connected = true;
		
		return server;
	}
	
}