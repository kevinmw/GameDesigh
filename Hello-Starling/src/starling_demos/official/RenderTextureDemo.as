package starling_demos.official
{
    import starling.display.Image;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;
    import starling.text.TextField;
    import starling.textures.RenderTexture;
    import starling.textures.Texture;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    import starling_demos.StarlingDemoBase;

    import flash.geom.Point;


    public class RenderTextureDemo extends StarlingDemoBase
    {
        [Embed(source = "starling_demos/official/media/textures/egg_opened.png")]
        private static const EggOpened:Class;

        private var mRenderTexture:RenderTexture;
        private var mBrush:Image;

        [After]
        public function tearDown():void
        {
            mRenderTexture.dispose();
        }

        [Test]
        public function test():void
        {
            var description:String = "Touch the screen to draw eggs!";
            var infoText:TextField = new TextField(300, 50, description);
            infoText.vAlign = VAlign.TOP;
            infoText.hAlign = HAlign.CENTER;
            display(infoText, 10, 30);

            mBrush = new Image(Texture.fromBitmap(new EggOpened()));
            mBrush.pivotX = mBrush.width / 2;
            mBrush.pivotY = mBrush.height / 2;
            mBrush.scaleX = mBrush.scaleY = 0.5;

            mRenderTexture = new RenderTexture(800, 600);

            var canvas:Image = new Image(mRenderTexture);
            canvas.addEventListener(TouchEvent.TOUCH, onTouch);
            display(canvas);
        }

        private function onTouch(event:TouchEvent):void
        {
            var touches:Vector.<Touch> = event.getTouches(root);

            for each (var touch:Touch in touches)
            {
                if (touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.ENDED)
                    continue;

                var location:Point = touch.getLocation(root);
                mBrush.x = location.x;
                mBrush.y = location.y;

                mRenderTexture.draw(mBrush);
            }
        }
    }
}