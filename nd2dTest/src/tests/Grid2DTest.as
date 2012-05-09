/*
 * ND2D - A Flash Molehill GPU accelerated 2D engine
 *
 * Author: Lars Gerckens
 * Copyright (c) nulldesign 2011
 * Repository URL: http://github.com/nulldesign/nd2d
 * Getting started: https://github.com/nulldesign/nd2d/wiki
 *
 *
 * Licence Agreement
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package tests {

	import de.nulldesign.nd2d.display.Grid2D;
	import de.nulldesign.nd2d.display.Scene2D;
	import de.nulldesign.nd2d.materials.texture.Texture2D;

	import tests.objects.MorphGrid;

	public class Grid2DTest extends Scene2D {

        [Embed(source="/assets/water_texture.jpg")]
        private var spriteTexture:Class;

        private var grid:Grid2D;

        public function Grid2DTest() {

            grid = new MorphGrid(16, 16, Texture2D.textureFromBitmapData(new spriteTexture().bitmapData));
            addChild(grid);
        }

        override protected function step(elapsed:Number):void {
            grid.x = stage.stageWidth * 0.5;
            grid.y = stage.stageHeight * 0.5;
            grid.width = stage.stageWidth;
            grid.height = stage.stageHeight;
        }
    }
}
