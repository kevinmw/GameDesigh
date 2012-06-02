package puzzlegame.components
{
	/**
	 * entity系统中component中需要的常量
	 * @author Kevin Ni
	 * 
	 */	
	public class GameComponentConst
	{	
		/**
		 * 游戏的状态
		 */		
		public static const GAME_STATE_PLAY:int = 0;//游戏正在进行的状态
		public static const GAME_STATE_STOP:int = 1;//游戏结束的状态，时间到结束、强制结束、用户选择结束
		public static const GAME_STATE_PAUSE:int = 2;//游戏暂停状态
		
		/**
		 * 方块组（所有方块的群体）的状态
		 */		
		public static const BLOCKS_DROP:int = 0;//掉落
		public static const BLOCKS_MOVEBLE:int = 1;//可移动
		public static const BLOCKS_FIXED:int = 2;//凝固，可由道具触发该状态
	}
}