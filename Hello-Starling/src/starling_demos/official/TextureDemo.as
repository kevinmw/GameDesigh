package starling_demos.official
{
    import starling.display.Image;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    import starling_demos.StarlingDemoBase;
    public class TextureDemo extends StarlingDemoBase
    {

        [Embed(source="starling_demos/official/media/textures/atlas.png")]
        private static const AtlasTexture:Class;
        [Embed(source="starling_demos/official/media/textures/atlas.xml", mimeType="application/octet-stream")]
        private static const AtlasXml:Class;

        [Embed(source = "starling_demos/official/media/textures/compressed_texture.atf", mimeType="application/octet-stream")]
        private static const CompressedTexture:Class;

        [Test(order=1)]
        public function load_textures_from_an_atlas():void
        {
            var atlasTexture:Texture = Texture.fromBitmap(new AtlasTexture());
            var atlasXML:XML = XML(new AtlasXml());
            var atlas:TextureAtlas = new TextureAtlas(atlasTexture, atlasXML);

            var image1:Image = new Image(atlas.getTexture("walk_00"));
            display(image1, 30, 30);

            var image2:Image = new Image(atlas.getTexture("walk_01"));
            display(image2, 90, 60);

            var image3:Image = new Image(atlas.getTexture("walk_03"));
            display(image3, 150, 90);

            var image4:Image = new Image(atlas.getTexture("walk_05"));
            display(image4, 210, 120);
        }

        [Test(order=2)]
        public function display_a_compressed_texture():void
        {
            var compressedTexture:Texture = Texture.fromAtfData(new CompressedTexture());
            var image:Image = new Image(compressedTexture);
            display(image, 100, 100);
        }
    }
}