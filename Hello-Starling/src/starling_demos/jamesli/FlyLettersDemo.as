package starling_demos.jamesli
{
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;
    import starling.textures.Texture;

    import starling_demos.StarlingDemoBase;

    public class FlyLettersDemo extends StarlingDemoBase
    {
        [Embed("starling_demos/jamesli/media/textures/ring.png")]
        private static const ringClass:Class;

        private var step:int = 0;
        private var interval:int = 1;

        override protected function getTopLabel():String
        {
            return "Demo from James Li ( http://jamesli.cn/blog/?p=1140 )";
        }

        [After]
        public function tearDown():void
        {
            root.touchable = true;
            root.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
        }

        [Test]
        public function test():void
        {
            root.touchable = false;
            createNewText();
            root.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
        }

        private function createNewText():void
        {
            var sprite:Sprite = new Sprite();
            var color:Number = (Math.round(Math.random() * 255) << 16) + (Math.round(Math.random() * 255) << 8) + Math.round(Math.random() * 255);
            if (Math.random() > .4)
            {
                var image:Image = new Image(Texture.fromBitmap(new ringClass()));
                sprite.addChild(image);
                image.color = color;
                image.x = -image.width / 2;
                image.y = -image.height / 2;
            }
            else
            {
                var textfield:TextField = new TextField(80, 80, getRandomText(), "Impact", 50, color);
                sprite.addChild(textfield);
                textfield.x = -textfield.width / 2;
                textfield.y = -textfield.height / 2;
                sprite.addChild(textfield);
            }

            root.addChild(sprite);
            sprite.name = String(Math.round(Math.random() * 10));
            sprite.rotation = Math.PI * 2 * Math.random();
            sprite.x = 300;
            sprite.y = 300;
            sprite.scaleX = sprite.scaleY = .5;
            sprite.alpha = 0;
        }
        private function updateAllTexts():void
        {
            for (var i:int = 0;i < root.numChildren;i++)
            {
                var sprite:Sprite = root.getChildAt(i) as Sprite;
                if (sprite)
                {
                    sprite.rotation += (Number(sprite.name) > 5) ? .01 : -.01;
                    sprite.x += 3 * sprite.scaleX * Math.cos(sprite.rotation);
                    sprite.y += 3 * sprite.scaleY * Math.sin(sprite.rotation);
                    sprite.alpha += .03;
                    sprite.scaleX += .05;
                    sprite.scaleY = sprite.scaleX;
                    if (sprite.x > 600 + sprite.width / 2 || sprite.x < -sprite.width / 2 || sprite.y > 400 + sprite.height / 2 || sprite.y < -sprite.height / 2)
                    {
                        root.removeChild(sprite);
                        i--;
                    }
                }
            }
        }
        private function getRandomText():String
        {
            // return String.fromCharCode(Math.random()*100000);
            var source:String = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ";
            return source.charAt(Math.random() * source.length);
        }
        private function enterFrameHandler(pEvent:Event):void
        {
            if (step > interval)
            {
                step = 0;
                createNewText();
            }
            step++;
            updateAllTexts();
        }
    }
}