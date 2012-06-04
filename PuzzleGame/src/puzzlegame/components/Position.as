package puzzlegame.components
{
	import flash.geom.Point;

	public class Position
	{
		public var point:Point;
		
		public function Position(x:Number, y:Number)
		{
			point = new Point(x, y);
		}
	}
}