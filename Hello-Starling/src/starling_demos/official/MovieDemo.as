package starling_demos.official
{
    import starling.display.MovieClip;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    import starling_demos.StarlingDemoBase;

    import xface.XFace;

    import flash.media.Sound;

    public class MovieDemo extends StarlingDemoBase
    {
        [Embed(source="starling_demos/official/media/textures/atlas.png")]
        private static const AtlasTexture:Class;
        [Embed(source="starling_demos/official/media/textures/atlas.xml", mimeType="application/octet-stream")]
        private static const AtlasXml:Class;
        [Embed(source="starling_demos/official/media/audio/step.mp3")]
        private static const StepSound:Class;

        private var mMovie:MovieClip;

        [After]
        public function tearDown():void
        {
            starling.juggler.remove(mMovie);
        }

        [Test]
        public function test():void
        {
            XFace.newLineForControls();
            XFace.addLabel("Animation provided by angryanimator.com");

            var atlasTexture:Texture = Texture.fromBitmap(new AtlasTexture());
            var atlasXML:XML = XML(new AtlasXml());
            var atlas:TextureAtlas = new TextureAtlas(atlasTexture, atlasXML);
            var frames:Vector.<Texture> = atlas.getTextures("walk_");
            mMovie = new MovieClip(frames, 12);
            display(mMovie, 100, 100);

            // add sounds
            var stepSound:Sound = new StepSound();
            mMovie.setFrameSound(1, stepSound);
            mMovie.setFrameSound(7, stepSound);

            // like any animation, the movie needs to be added to the juggler!
            starling.juggler.add(mMovie);
        }
    }
}