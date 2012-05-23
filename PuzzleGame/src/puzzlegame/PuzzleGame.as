package puzzlegame
{
	import de.polygonal.ds.Array2;
	
	import flash.display.Stage;
	
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.integration.swiftsuspenders.SwiftSuspendersGame;
	import net.richardlord.ash.tick.FrameTickProvider;
	
	import org.swiftsuspenders.Injector;
	
	import puzzlegame.components.GameState;
	import puzzlegame.input.MouseInput;
	import puzzlegame.systems.GameManager;
	import puzzlegame.systems.InputSystem;
	import puzzlegame.systems.RenderSystem;
	import puzzlegame.systems.SystemPriorities;
	
	import starling.display.DisplayObject;

	public class PuzzleGame
	{
		private var game:Game;
		private var injector:Injector;
		private var tickProvider : FrameTickProvider;
		
		public function PuzzleGame(container : DisplayObject, stage : Stage)
		{
			prepare(container, stage);
		}
		
		/**
		 * 构筑游戏结构，进行依赖注入（injector）
		 * @param container Stage3d的现实对象根
		 * @param stage 传统stage
		 * 
		 */		
		private function prepare( container : DisplayObject, stage : Stage) : void
		{
			injector = new Injector();
			game = new SwiftSuspendersGame(injector);
			
			injector.map(Game).toValue(game);
			injector.map(GameContainer).toValue(container);
			injector.map(GameState).asSingleton();
			injector.map(EntityCreator).asSingleton();
			injector.map(MouseInput).toValue(new MouseInput(container.stage));
			
			game.addSystem(new GameManager(), SystemPriorities.preUpdate);
			game.addSystem(new InputSystem(), SystemPriorities.update);
			game.addSystem(new RenderSystem(), SystemPriorities.render);
			
			tickProvider = new FrameTickProvider( stage );
			
			var gameState : GameState = injector.getInstance( GameState );
			gameState.width = stage.stageWidth;
			gameState.height = stage.stageHeight;
		}
		
		/**
		 * 构筑游戏数据
		 * 开始每帧按序执行各个System
		 */		
		public function start():void
		{
			var gameState : GameState = injector.getInstance( GameState );
			
			gameState.level = 1;
			gameState.times = 100;
			
			//游戏的方块阵列数据初始化
			//TODO 考虑是否放在更合适的位置
			GameData.blockTypeArray2 = new Array2(GameData.blockCols, GameData.blockRows);
			GameData.blockTypeArray2.fill(null);
			
			tickProvider.add( game.update );
			tickProvider.start();
		}
	}
}