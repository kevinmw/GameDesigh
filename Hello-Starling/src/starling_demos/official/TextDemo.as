package starling_demos.official
{
    import starling.text.BitmapFont;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.utils.Color;
    import starling.utils.HAlign;
    import starling.utils.VAlign;

    import starling_demos.StarlingDemoBase;
    public class TextDemo extends StarlingDemoBase
    {
        [Embed(source="starling_demos/official/media/fonts/desyrel.fnt", mimeType="application/octet-stream")]
        private static const DesyrelXml:Class;
        [Embed(source = "starling_demos/official/media/fonts/desyrel.png")]
        private static const DesyrelTexture:Class;

        private static var isBitmapFontReady:Boolean = false;

        [Test(order=1)]
        public function TrueType_fonts():void
        {
            var offset:int = 10;
            var ttFont:String = "Ubuntu";
            var ttFontSize:int = 19;

            var colorTF:TextField = new TextField(300, 80,
                "TextFields can have a border and a color. They can be aligned in different ways, ...",
                ttFont, ttFontSize);
            colorTF.border = true;
            colorTF.color = 0x333399;
            display(colorTF, offset, 30);

            var leftTF:TextField = new TextField(145, 80,
                "... e.g.\ntop-left ...", ttFont, ttFontSize);
            leftTF.hAlign = HAlign.LEFT;
            leftTF.vAlign = VAlign.TOP;
            leftTF.border = true;
            leftTF.color = 0x993333;
            display(leftTF, offset, colorTF.y + colorTF.height + offset);

            var rightTF:TextField = new TextField(145, 80,
                "... or\nbottom right ...", ttFont, ttFontSize);
            rightTF.hAlign = HAlign.RIGHT;
            rightTF.vAlign = VAlign.BOTTOM;
            rightTF.color = 0x228822;
            rightTF.border = true;
            display(rightTF, 2 * offset + leftTF.width, leftTF.y);

            var fontTF:TextField = new TextField(300, 80,
                "... or centered. Embedded fonts are detected automatically.",
                ttFont, ttFontSize, 0x0, true);
            fontTF.border = true;
            display(fontTF, offset, leftTF.y + leftTF.height + offset);
        }
        [Test(order=2)]
        public function Bitmap_fonts():void
        {
            // First, you will need to create a bitmap font texture.
            //
            // E.g. with this tool: www.angelcode.com/products/bmfont/ or one that uses the same
            // data format. Export the font data as an XML file, and the texture as a png with white
            // characters on a transparent background (32 bit).
            //
            // Then, you just have to register the font at the TextField class.
            // After that, you can use them just like a conventional TrueType font.
            if (!isBitmapFontReady)
            {
                var bitmapFontsTexture:Texture = Texture.fromBitmap(new DesyrelTexture());
                var bitmapFontsXML:XML = XML(new DesyrelXml());
                TextField.registerBitmapFont(new BitmapFont(bitmapFontsTexture, bitmapFontsXML));

                isBitmapFontReady = true;
            }

            var bmpFontTF:TextField = new TextField(300, 150,
                "It is very easy to use Bitmap fonts, as well!", "Desyrel");

            bmpFontTF.fontSize = BitmapFont.NATIVE_SIZE; // the native bitmap font size, no scaling
            bmpFontTF.color = Color.WHITE; // use white to use the texture as it is (no tinting)
            display(bmpFontTF, 10, 30);

            // A tip: you can add the font-texture to your standard texture atlas and reference
            // it from there. That way, you save texture space and avoid another texture-switch.
        }
    }
}