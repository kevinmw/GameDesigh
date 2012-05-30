package puzzlegame
{
	import net.richardlord.ash.core.Entity;
	import net.richardlord.ash.core.Game;
	
	import puzzlegame.components.Block;
	import puzzlegame.components.BlockColor;
	import puzzlegame.components.Display;
	import puzzlegame.components.Position;
	import puzzlegame.graphics.BlockView;
	import puzzlegame.texture.BlockConst;

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
		
		public function createBlocks(x:int, y:int, type:int):Entity
		{
//			trace(type, x, y);
			var view:BlockView = new BlockView(type, x, y);
			var block:Entity = new Entity()
				.add(new Block())
				.add(new Position(BlockConst.LEFT_OFFSET+x*BlockConst.SIDE_LENGTH, BlockConst.TOP_OFFSET+y*BlockConst.SIDE_LENGTH))
				.add(new BlockColor(type))
//				.add(new Motion( ( Math.random() - 0.5 ) * 4 * ( 50 - radius ), ( Math.random() - 0.5 ) * 4 * ( 50 - radius ), Math.random() * 2 - 1, 0 ) )
				.add(new Display(view));
			GameData.blockTypeArray2.set(x, y, view);
			game.addEntity(block);
			return block;			
		}
	}
}