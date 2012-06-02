package puzzlegame.systems
{
	/**
	 * 描述游戏每帧处理的各个阶段
	 * @author Kevin Ni
	 * 
	 */	
	public class SystemPriorities
	{
		/**
		 * 预更新阶段
		 * 判断游戏的状态：是否结束，是否挂起
		 * 添加新方块
		 */		
		public static const preUpdate : int = 10;
		/**
		 * 更新阶段
		 * 处理游戏中的各种输入，鼠标，键盘...
		 * 记录状态，做出响应
		 */	
		public static const update : int = 20;
		/**
		 * 移动阶段
		 * 处理游戏中的对象的运动
		 * 以及移动完成后的数据更新
		 */		
		public static const move : int = 30;
		/**
		 * 预渲染阶段
		 * 处理游戏中方块的消除，以及消除后的数据更新
		 */		
		public static const preRender : int = 40;
		/**
		 * 渲染阶段
		 * 处理游戏中显示对象的渲染
		 */		
		public static const render : int = 50;
	}
}
