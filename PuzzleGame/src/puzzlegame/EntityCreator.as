package puzzlegame
{
	import net.richardlord.ash.core.Entity;
	import net.richardlord.ash.core.Game;
	
	import puzzlegame.components.Block;
	import puzzlegame.components.BlockColor;
	import puzzlegame.components.Display;
	import puzzlegame.components.Position;
	import puzzlegame.graphics.BlockView;

	public class EntityCreator
	{
		private var game:Game;
		
		public function EntityCreator(_game:Game)
		{
			this.game = _game;
		}
		
		public function destroyEntity(entity:Entity) : void
		{
			game.removeEntity(entity);
		}
		
		public function createBlocks(x:Number, y:Number, type:int):Entity
		{
			trace(type);
			var block:Entity = new Entity()
				.add(new Block())
				.add(new Position(x, y))
				.add(new BlockColor(type))
//				.add(new Motion( ( Math.random() - 0.5 ) * 4 * ( 50 - radius ), ( Math.random() - 0.5 ) * 4 * ( 50 - radius ), Math.random() * 2 - 1, 0 ) )
				.add(new Display(new BlockView(type)));
			game.addEntity(block);
			return block;			
		}
	}
}