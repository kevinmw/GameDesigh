package starling_demos.official
{
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    import starling_demos.StarlingDemoBase;

    public class CustomHitTestDemo extends StarlingDemoBase
    {
        [Embed(source = "starling_demos/official/media/textures/egg_closed.png")]
        private static const EggClosed:Class;

        [Test]
        public function test():void
        {
            var description:String =
                "Pushing the egg only works when the touch occurs within a circle." +
                "This can be accomplished by overriding the method 'hitTest'.";

            var infoText:TextField = new TextField(300, 100, description);
            infoText.vAlign = VAlign.TOP;
            infoText.hAlign = HAlign.CENTER;
            display(infoText, 10, 30);

            // 'RoundButton' is a helper class of the Demo, not a part of Starling!
            // Have a look at its code (inner class below) to understand this sample.

            var button:RoundButton = new RoundButton(Texture.fromBitmap(new EggClosed()));
            display(button, 100, 150);
        }
    }
}
import starling.display.Button;
import starling.display.DisplayObject;
import starling.textures.Texture;

import flash.geom.Point;
import flash.geom.Rectangle;
internal class RoundButton extends Button
{
    public function RoundButton(upState:Texture, text:String="", downState:Texture=null)
    {
        super(upState, text, downState);
    }

    public override function hitTest(localPoint:Point, forTouch:Boolean=false):DisplayObject
    {
        // When the user touches the screen, this method is used to find out if an object was
        // hit. By default, this method uses the bounding box, but by overriding it,
        // we can change the box (rectangle) to a circle (or whatever necessary).

        // when the hit test is done to check if a touch is hitting the object, invisible or
        // untouchable objects must cause the hit test to fail.
        if (forTouch && (!visible || !touchable))
            return null;

        // get center of button
        var bounds:Rectangle = this.bounds;
        var centerX:Number = bounds.width / 2;
        var centerY:Number = bounds.height / 2;

        // calculate distance of localPoint to center.
        // we keep it squared, since we want to avoid the 'sqrt()'-call.
        var sqDist:Number = Math.pow(localPoint.x - centerX, 2) +
                            Math.pow(localPoint.y - centerY, 2);

        // when the squared distance is smaller than the squared radius,
        // the point is inside the circle
        var radius:Number = bounds.width / 2;
        if (sqDist < Math.pow(radius, 2)) return this;
        else return null;
    }
}