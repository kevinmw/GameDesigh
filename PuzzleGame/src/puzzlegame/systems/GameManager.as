package puzzlegame.systems
{
	import de.polygonal.ds.Array2;
	
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	
	import puzzlegame.EntityCreator;
	import puzzlegame.GameData;
	import puzzlegame.components.GameComponentConst;
	import puzzlegame.components.GameState;
	import puzzlegame.graphics.BlockView;
	import puzzlegame.nodes.RenderNode;
	import puzzlegame.texture.BlockConst;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	
	/**
	 * 游戏整体状态管理类
	 * @author Kevin Ni
	 * 
	 */	
	public class GameManager extends System
	{
		[Inject]
		public var gameState:GameState;
		
		[Inject]
		public var creator : EntityCreator;
		
		[Inject(nodeType="puzzlegame.nodes.RenderNode")]
		public var nodes:NodeList;
		
		override public function update(time:Number):void
		{
			//游戏进行状态中，没有方块时，创建方块
			if(gameState.times>0 && nodes.empty)
			{
				for(var i:int=0;i<80;i++)
				{
					creator.createBlocks(gameState.blocks%10, Math.floor(gameState.blocks/10), Math.floor(Math.random()*6));
					gameState.blocks++;
				}
				gameState.times = 0;
				GameData.blockTypeArray2.walk(
					function (val:String, x:int, y:int):void 
					{
						trace(Std.string(x), Std.string(y), Std.string(val)); 
					}
				);
				trace(GameData.blockTypeArray2.toString());
				
				gameState.state = GameComponentConst.BLOCKS_DROP;
				
				var block:RenderNode;
				var blockView:BlockView;
				block = nodes.head;
				while (block != null)
				{
					blockView = block.display.displayObject;
					var tween:Tween = new Tween(block.position.point, 1-blockView.rows*0.1, Transitions.LINEAR);
					tween.animate("y", BlockConst.TOP_OFFSET+blockView.rows*BlockConst.SIDE_LENGTH);
					if(blockView.rows == 6 && blockView.cols == 6)
					{
						tween.onComplete = function ():void{
							gameState.state = GameComponentConst.BLOCKS_MOVEBLE;
						}
					}
					block = block.next;
					Starling.juggler.add(tween);
				}
			}
		}
	}
}