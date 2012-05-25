package
{
	import flash.display.Sprite;
	
	import starling.core.Starling;

	[SWF(frameRate="60", width="760", height="600")]
	public class StarlingNape extends Sprite
	{
		public function StarlingNape()
		{
			var xstarling:Starling = new Starling(Main, stage);
			xstarling.start();
		}
	}
}