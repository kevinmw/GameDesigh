package starling_demos.official
{
    import starling.animation.Transitions;
    import starling.animation.Tween;
    import starling.display.Button;
    import starling.display.Image;
    import starling.events.Event;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.Color;
    import starling.utils.deg2rad;
    
    import starling_demos.StarlingDemoBase;

    public class AnimationDemo extends StarlingDemoBase
    {

        [Embed(source = "starling_demos/official/media/textures/button_normal.png")]
        private static const ButtonNormal:Class;
        [Embed(source = "starling_demos/official/media/textures/egg_opened.png")]
        private static const EggOpened:Class;

        private var mStartButton:Button;
        private var mDelayButton:Button;
        private var mEgg:Image;
        private var mTransitionLabel:TextField;
        private var mTransitions:Array;

        [After]
        public function tearDown():void
        {
            mStartButton.removeEventListener(Event.TRIGGERED, onStartButtonTriggered);
            mDelayButton.removeEventListener(Event.TRIGGERED, onDelayButtonTriggered);
        }

        [Test]
        public function test():void
        {
            mTransitions = [Transitions.EASE_IN_OUT_ELASTIC];

            var buttonTexture:Texture = Texture.fromBitmap(new ButtonNormal());

            // create a button that starts the tween
            mStartButton = new Button(buttonTexture, "Start animation");
            mStartButton.addEventListener(Event.TRIGGERED, onStartButtonTriggered);
            display(mStartButton, 20, 30);

            // this button will show you how to call a method with a delay
            mDelayButton = new Button(buttonTexture, "Delayed call");
            mDelayButton.addEventListener(Event.TRIGGERED, onDelayButtonTriggered);
            display(mDelayButton, mStartButton.x, mStartButton.y + 40);

            // the egg will be tweened
            mEgg = new Image(Texture.fromBitmap(new EggOpened()));
            display(mEgg);
            resetEgg();

            mTransitionLabel = new TextField(320, 30, "");
            mTransitionLabel.alpha = 0.0; // invisible, will be shown later
            display(mTransitionLabel, 0, mDelayButton.y + 40);
        }


        private function resetEgg():void
        {
            mEgg.x = 120;
            mEgg.y = 220;
            mEgg.scaleX = mEgg.scaleY = 1.0;
            mEgg.rotation = 0.0;
			mEgg.pivotX = mEgg.width/2;
			mEgg.pivotY = mEgg.height/2;
        }

        private function colorizeEgg(colorize:Boolean):void
        {
            mEgg.color = colorize ? Color.PURPLE : Color.WHITE;
        }

        private function onStartButtonTriggered(event:Event):void
        {
            mStartButton.enabled = false;
            resetEgg();

            // get next transition style from array and enqueue it at the end
            var transition:String = mTransitions.shift();
            mTransitions.push(transition);

            // to animate any numeric property of an arbitrary object (not just display objects!),
            // you can create a 'Tween'. One tween object animates one target for a certain time,
            // a with certain transition function.
            var tween:Tween = new Tween(mEgg, 1, transition);

            // you can animate any property as long as it's numeric (int, uint, Number).
            // it is animated from it's current value to a target value.
//            tween.animate("rotation", deg2rad(90)); // conventional 'animate' call
//            tween.moveTo(300, 380);                 // convenience method for animating 'x' and 'y'
            tween.scaleTo(0.9);                     // convenience method for 'scaleX' and 'scaleY'
            tween.onComplete = function():void { mStartButton.enabled = true; };

            // the tween alone is useless -- for an animation to be carried out, it has to be
            // advance once in every frame.
            // This is done by the 'Juggler'. It receives the tween and will carry it out.
            // We use the default juggler here, but you can create your own jugglers, as well.
            // That way, you can group animations into logical parts.
            starling.juggler.add(tween);

            // show which tweening function is used
            mTransitionLabel.text = transition;
            mTransitionLabel.alpha = 1.0;

            var hideTween:Tween = new Tween(mTransitionLabel, 3.0, Transitions.EASE_IN);
            hideTween.animate("alpha", 0.0);
            starling.juggler.add(hideTween);
        }
        private function onDelayButtonTriggered(event:Event):void
        {
            mDelayButton.enabled = false;

            // Using the juggler, you can delay a method call. This is especially useful when
            // you use your own juggler in a component of your game, because it gives you perfect
            // control over the flow of time and animations.

            starling.juggler.delayCall(colorizeEgg, 1.0, true);
            starling.juggler.delayCall(colorizeEgg, 2.0, false);
            starling.juggler.delayCall(function():void { mDelayButton.enabled = true; }, 2.0);
        }
    }
}