package puzzlegame.systems
{
	import net.richardlord.ash.core.System;
	
	import puzzlegame.EntityCreator;
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
		
		override public function update(time:Number):void
		{
			if(gameState.times>0 && gameState.points<9)
			{
				gameState.points ++;
				creator.createBlocks(100+gameState.points*BlockConst.SIDE_LENGTH, 100+gameState.points*BlockConst.SIDE_LENGTH, Math.floor(Math.random()*6));
			}
		}
	}
}