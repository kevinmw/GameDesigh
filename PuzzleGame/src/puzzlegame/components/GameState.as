package puzzlegame.components
{
	/**
	 * 保存当前游戏的状态
	 * @author Kevin Ni
	 * 
	 */	
	public class GameState
	{
		/**
		 * 本局游戏时间
		 */		
		public var times:int;
		/**
		 * 游戏等级，后续如用到会与游戏难度相关
		 */		
		public var level:int;
		/**
		 * 游戏的方块数目
		 */		
		public var blocks:int;	
		/**
		 * 游戏的当前状态
		 */		
		public var state:int;
				
		public var width:int; //游戏的宽度
		public var height:int; //游戏的高度
		
		public function GameState(width:int = 0, height:int = 0 )
		{
			this.width = width;
			this.height = height;
			this.state = GameComponentConst.GAME_STATE_PLAY;
		}
	}
}
