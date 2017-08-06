package nodehack.controller;
import flixel.math.FlxPoint;
import flixel.math.FlxRandom;
import nodehack.model.*;

/**
 * ...
 * @author Matthew Everett
 */
class LevelGen
{

	private var _random:FlxRandom = new FlxRandom();

	public function new() 
	{
		
	}
	
	public function generateServer(difficulty:Int):Server
	{
		return generateBasicGridServer(difficulty);
	}

	private function generateFixedServer(difficulty:Int):Server
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

	private function generateBasicGridServer(difficulty:Int):Server{
		var server = new Server();
		server.difficulty = difficulty;
		server.name = "A name";

		var serversV = 3;
		var serversH = 6;
		var spacingV = 130;
		var spacingH = 130;
		var topLeft = new FlxPoint(50, 190);

		var i = 0;
		for (x in 0...serversH)
		{
			for (y in 0...serversV)
			{
				var node = new Node(new FlxPoint(topLeft.x + x*spacingH, topLeft.y + y*spacingV), "SVR", null);
				server.nodes.push(node);
				node.ice = new Ice("Default", _random.int(Std.int(Math.max(1, difficulty-1)), difficulty+1));
				node.moneyReward = _random.int(difficulty*12, (difficulty+node.ice.strength*12));
				if (y > 0)
				{
					var nodeAbove = server.nodes[i-1];
					server.connections.push(new NodeConnection(nodeAbove, node));
				}
				if (x > 0)
				{
					var nodeLeft = server.nodes[i-serversV];
					server.connections.push(new NodeConnection(nodeLeft, node));
				}
				i++;
			}
		}

		server.nodes[0].connected = true;
		server.nodes[0].access = Enums.EAccess.ROOT;

		return server;
	}
	
}