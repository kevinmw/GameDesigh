package
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class BasketBall extends Sprite
	{
		[Embed(source="basketball.png")]
		private var basketball:Class;
		
		public function BasketBall()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
		}
		
		private function onAdd(event:Event):void
		{
			addChild(Image.fromBitmap(new basketball()));
			this.pivotX = this.width>>1;
			this.pivotY = this.height>>1;
		}
	}
}