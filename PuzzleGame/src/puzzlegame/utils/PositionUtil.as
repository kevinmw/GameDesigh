package puzzlegame.utils
{
	import flash.geom.Point;
	
	import puzzlegame.GameData;

	public class PositionUtil
	{
		public static function checkPositioValid(position:Point):Boolean
		{
			if(position.x<0 || position.x>=GameData.blockCols || position.y<0 || position.y>=GameData.blockRows)
			{
				return false;
			}
//			if(!GameData.blockTypeArray2.get(position.x, position.y))
//			{
//				return false;
//			}
			return true;
		}
	}
}