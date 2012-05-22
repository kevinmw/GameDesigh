package starling_demos.official
{
    import starling.display.Image;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    import starling_demos.StarlingDemoBase;

    public class TouchDemo extends StarlingDemoBase
    {
        [Embed(source = "starling_demos/official/media/textures/egg_closed.png")]
        private static const EggClosed:Class;
        [Embed(source = "starling_demos/official/media/textures/egg_opened.png")]
        private static const EggOpened:Class;

        [Test]
        public function test():void
        {
            var description:String =
                "- touch and drag to move the images \n" +
                "- pinch with 2 fingers to scale and rotate \n" +
                "- double tap brings an image to the front \n" +
                "- use Ctrl/Cmd & Shift to simulate multi-touch";

            var infoText:TextField = new TextField(300, 75, description);
            infoText.vAlign = VAlign.TOP;
            infoText.hAlign = HAlign.LEFT;
            display(infoText, 10, 30);

            var eggClosed:Image = new Image(Texture.fromBitmap(new EggClosed()));
            var eggOpened:Image = new Image(Texture.fromBitmap(new EggOpened()));

            // to find out how to react to touch events have a look at the TouchSheet class!
            // It's an internal class below.

            var sheet1:TouchSheet = new TouchSheet(eggClosed);
            display(sheet1, 380, 250);

            var sheet2:TouchSheet = new TouchSheet(eggOpened);
            display(sheet2, 450, 345);
        }
    }
}
import starling.display.DisplayObject;
import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

import flash.geom.Point;

internal class TouchSheet extends Sprite
{
    public function TouchSheet(contents:DisplayObject = null)
    {
        addEventListener(TouchEvent.TOUCH, onTouch);

        if (contents)
        {
            contents.x = contents.width / -2;
            contents.y = contents.height / -2;
            addChild(contents);
        }
    }
    private function onTouch(event:TouchEvent):void
    {
        var touches:Vector.<Touch> = event.getTouches(this, TouchPhase.MOVED);

        if (touches.length == 1)
        {
            var touch:Touch = touches[0];
            var currentPos:Point = touch.getLocation(parent);
            var previousPos:Point = touch.getPreviousLocation(parent);
            var delta:Point = currentPos.subtract(previousPos);

            x += delta.x;
            y += delta.y;
        }
        else if (touches.length == 2)
        {
            var touchA:Touch = touches[0];
            var touchB:Touch = touches[1];

            var currentPosA:Point = touchA.getLocation(parent);
            var previousPosA:Point = touchA.getPreviousLocation(parent);
            var currentPosB:Point = touchB.getLocation(parent);
            var previousPosB:Point = touchB.getPreviousLocation(parent);

            var currentVector:Point = currentPosA.subtract(currentPosB);
            var previousVector:Point = previousPosA.subtract(previousPosB);

            var currentAngle:Number = Math.atan2(currentVector.y, currentVector.x);
            var previousAngle:Number = Math.atan2(previousVector.y, previousVector.x);
            var deltaAngle:Number = currentAngle - previousAngle;

            // rotate
            rotation += deltaAngle;

            // scale
            var sizeDiff:Number = currentVector.length / previousVector.length;
            scaleX *= sizeDiff;
            scaleY *= sizeDiff;
        }

        touch = event.getTouch(this, TouchPhase.ENDED);

        if (touch && touch.tapCount == 2)
            parent.addChild(this);
        // bring self to front

        // enable this code to see when you're hovering over the object
        // touch = event.getTouch(this, TouchPhase.HOVER);
        // alpha = touch ? 0.8 : 1.0;
    }
    public override function dispose():void
    {
        removeEventListener(TouchEvent.TOUCH, onTouch);
        super.dispose();
    }
}