package starling_demos.official
{
    import flash.system.System;
    
    import starling.display.Button;
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.EnterFrameEvent;
    import starling.events.Event;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.formatString;
    
    import starling_demos.StarlingDemoBase;

    public class BenchmarkDemo extends StarlingDemoBase
    {
        [Embed(source = "starling_demos/official/media/textures/button_normal.png")]
        private static const ButtonNormal:Class;
        [Embed(source = "starling_demos/official/media/textures/benchmark_object.png")]
        private static const BenchmarkObject:Class;

        private var mStartButton:Button;
        private var mResultText:TextField;

        private var mContainer:Sprite;
        private var mFrameCount:int;
        private var mElapsed:Number;
        private var mStarted:Boolean;
        private var mFailCount:int;
        private var mWaitFrames:int;
		private var logoTexture:Texture;

        [After]
        public function tearDown():void
        {
            root.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            mStartButton.removeEventListener(Event.TRIGGERED, onStartButtonTriggered);
        }

        [Test]
        public function test():void
        {
            // the container will hold all test objects
            mContainer = new Sprite();
            mContainer.touchable = false; // we do not need touch events on the test objects --
                                          // thus, it is more efficient to disable them.
            display(mContainer);

            mStartButton = new Button(Texture.fromBitmap(new ButtonNormal()), "Start benchmark");
            mStartButton.addEventListener(Event.TRIGGERED, onStartButtonTriggered);
            display(mStartButton, 20, 30);
			
			logoTexture = Texture.fromBitmap(new BenchmarkObject());

            mStarted = false;
            mElapsed = 0.0;

            root.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }
        private function onEnterFrame(event:EnterFrameEvent):void
        {
            if (!mStarted) return;

            mElapsed += event.passedTime;
            mFrameCount++;

            if (mFrameCount % mWaitFrames == 0)
            {
                var fps:Number = mWaitFrames / mElapsed;

                if (Math.ceil(fps) >= starling.nativeStage.frameRate)
                {
                    mFailCount = 0;
                    addTestObject();
                }
                else
                {
                    mFailCount++;

                    if (mFailCount > 20)
                        mWaitFrames = 5; // slow down creation process to be more exact
                    if (mFailCount > 30)
                        mWaitFrames = 10;
                    if (mFailCount == 40)
                        benchmarkComplete(); // target fps not reached for a while
                }

                mElapsed = mFrameCount = 0;
            }

            var numObjects:int = mContainer.numChildren;
            var passedTime:Number = event.passedTime;

            for (var i:int=0; i<numObjects; ++i)
                mContainer.getChildAt(i).rotation += Math.PI / 2 * passedTime;
        }

        private function addTestObject():void
        {
            var padding:int = 15;
            var egg:Image = new Image(logoTexture);
            egg.x = padding + Math.random() * (500 - 2 * padding);
            egg.y = padding + Math.random() * (500 - 2 * padding);
            mContainer.addChild(egg);
        }

        private function benchmarkComplete():void
        {
            mStarted = false;
            mStartButton.visible = true;

            const FPS:int = starling.nativeStage.frameRate;

            trace("Benchmark complete!");
            trace("FPS: " + FPS);
            trace("Number of objects: " + mContainer.numChildren);

            var resultString:String = formatString("Result:\n{0} objects\nwith {1} fps",
                                                   mContainer.numChildren, FPS);
            mResultText = new TextField(240, 200, resultString);
            mResultText.fontSize = 30;
            display(mResultText, 20, 100);

            mContainer.removeChildren();
            System.pauseForGCIfCollectionImminent();
        }
        private function onStartButtonTriggered(event:Event):void
        {
            trace("Starting benchmark");

            mStartButton.visible = false;
            mStarted = true;
            mFailCount = 0;
            mWaitFrames = 1;
            mFrameCount = 0;

            if (mResultText)
            {
                mResultText.removeFromParent(true);
                mResultText = null;
            }

            addTestObject();
        }

    }
}