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

		var entrance = server.nodes[0];
		entrance.connected = true;
		entrance.access = Enums.EAccess.ROOT;
		entrance.type = Enums.ENodeType.ENTRANCE;
		entrance.name = "PORT";

		var exit = server.nodes[server.nodes.length - 3];
		exit.type = Enums.ENodeType.EXIT;
		exit.name = "EXIT";

		var criticalPath = getPathBetweenNodes(server, entrance, exit);
		if (criticalPath == null)
		{
			throw "SOMETHING IN LEVEL GEN WENT HORRIBLY WRONG!";
		}

		//Get random connections, knock them out, if we can't reach a node, put them back
		var connectionsRemoved = 0;
		var failures = 0;
		while (connectionsRemoved < server.nodes.length * 3 && failures < 50)
		{
			var randomConnection = server.connections[_random.int(0,server.connections.length-1)];
			server.connections.remove(randomConnection);
			if (getPathBetweenNodes(server, entrance, randomConnection.node1) == null
				|| getPathBetweenNodes(server, entrance, randomConnection.node2) == null)
			{
				server.connections.push(randomConnection);
				failures++;
			}
			else
			{
				connectionsRemoved++;
			}
		}

		return server;
	}
	
	private static function getPathBetweenNodes(server:Server, source:Node, target:Node):Array<Node>
	{
		var distancesFromSource = new Map<Node, Int>();
		var previousNodeFromSource = new Map<Node, Node>();
		var unoptimizedNodes = server.nodes.copy();
		var intMax:Int = 65535;

		for (node in unoptimizedNodes)
		{
			distancesFromSource.set(node, intMax);
			previousNodeFromSource.set(node, null);
			if (node == source)
			{
				distancesFromSource[node] = 0;
			}
		}

		var pathFound:Bool = false;
		while (unoptimizedNodes.length > 0 && !pathFound)
		{
			var shortest:Int = intMax;
			var nextNode = unoptimizedNodes[0];
			for (node in unoptimizedNodes)
			{
				if (distancesFromSource[node] < shortest)
				{
					shortest = distancesFromSource[node];
					nextNode = node;
				}
			}

			if (shortest == intMax)
			{
				return null;
			}
			unoptimizedNodes.remove(nextNode);
			if (nextNode == target)
			{
				pathFound = true;
			}

			for (neighbor in server.getAdjacentNodes(nextNode))
			{
				var nodeFound = false;
				for (node in unoptimizedNodes)
				{
					if (node == neighbor)
					{
						nodeFound = true;
						neighbor = node;
						break;
					}
				}
				if (nodeFound)
				{
					var newDistance = distancesFromSource[nextNode] + 1;
					if (newDistance < distancesFromSource[neighbor])
					{
						distancesFromSource[neighbor] = newDistance;
						previousNodeFromSource[neighbor] = nextNode;
					}
				}
			}
		}

		var nodePath = new Array<Node>();
		var nextNodeInFinalPath = target;
		while (previousNodeFromSource[nextNodeInFinalPath] != null)
		{
			nodePath.push(nextNodeInFinalPath);
			nextNodeInFinalPath = previousNodeFromSource[nextNodeInFinalPath];
		}
		nodePath.push(source);
		nodePath.reverse();
		return nodePath;
	}
}