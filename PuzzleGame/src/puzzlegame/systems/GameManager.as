package puzzlegame.systems
{
	import de.polygonal.ds.Array2;
	
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	
	import puzzlegame.EntityCreator;
	import puzzlegame.GameData;
	import puzzlegame.components.GameState;
	import puzzlegame.texture.BlockConst;
	
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
			if(gameState.times>0 && nodes.empty)
			{
				for(var i:int=0;i<80;i++)
				{
					creator.createBlocks(gameState.blocks%10, Math.floor(gameState.blocks/10), Math.floor(Math.random()*6));
					gameState.blocks ++;
				}
				gameState.times = 0;
				GameData.blockTypeArray2.walk(
					function (val:String, x:int, y:int):void 
					{
						trace(Std.string(x), Std.string(y), Std.string(val)); 
					}
				);
				trace(GameData.blockTypeArray2.toString());
			}
		}
	}
}