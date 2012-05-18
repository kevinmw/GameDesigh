package puzzlegame.systems
{
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	
	import puzzlegame.GameContainer;
	import puzzlegame.components.Display;
	import puzzlegame.components.Position;
	import puzzlegame.nodes.RenderNode;
	
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	
	public class RenderSystem extends System
	{
		[Inject]
		public var container : GameContainer;
		
		[Inject(nodeType="puzzlegame.nodes.RenderNode")]
		public var nodes : NodeList;
		
		[PostConstruct]
		public function setUpListeners() : void
		{
			for(var node:RenderNode = nodes.head; node; node=node.next)
			{
				addToDisplay(node);
			}
			nodes.nodeAdded.add( addToDisplay );
			nodes.nodeRemoved.add(removeFromDisplay);
		}
		
		private function addToDisplay(node:RenderNode):void
		{
			container.addChild(node.display.displayObject);
		}
		
		private function removeFromDisplay(node:RenderNode):void
		{
			container.removeChild(node.display.displayObject);
		}
		
		override public function update(time:Number):void
		{
			var node : RenderNode;
			var position : Position;
			var display : Display;
			var displayObject : DisplayObject;
			
			for ( node = nodes.head; node; node = node.next )
			{
				display = node.display;
				displayObject = display.displayObject;
				position = node.position;
				
				displayObject.x = position.position.x;
				displayObject.y = position.position.y;
			}			
		}
	}
}