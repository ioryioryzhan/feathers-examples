package org.josht.starling.foxhole.displayObjects.screens
{
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import org.josht.starling.display.Image;
	import org.josht.starling.display.Scale9Image;
	import org.josht.starling.display.Screen;
	import org.josht.starling.display.TiledImage;
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.osflash.signals.Signal;

	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	import starling.textures.Texture;

	public class TiledImageScreen extends Screen
	{
		[Embed(source="/../assets/images/tile-pattern.png")]
		private static const TILE_TEXTURE:Class;

		[Embed(source="/../assets/images/horizontal-grip.png")]
		private static const HORIZONTAL_GRIP:Class;

		[Embed(source="/../assets/images/vertical-grip.png")]
		private static const VERTICAL_GRIP:Class;

		public function TiledImageScreen()
		{
		}

		private var _header:ScreenHeader;
		private var _image:TiledImage;
		private var _rightButton:Button;
		private var _bottomButton:Button;

		private var _minWidth:Number;
		private var _minHeight:Number;
		private var _maxWidth:Number;
		private var _maxHeight:Number;
		private var _startX:Number;
		private var _startY:Number;
		private var _startWidth:Number;
		private var _startHeight:Number;
		private var _rightTouchPointID:int = -1;
		private var _bottomTouchPointID:int = -1;

		override protected function initialize():void
		{
			this._header = new ScreenHeader();
			this._header.title = "Tiled Image";
			this.addChild(this._header);

			this._image = new TiledImage(Texture.fromBitmap(new TILE_TEXTURE(), false));
			this._image.textureScale = this.dpiScale;
			this._image.clipContent = true;
			this._minWidth = this._image.width;
			this._minHeight = this._image.height;
			this.addChild(this._image);

			this._rightButton = new Button();
			this._rightButton.addEventListener(TouchEvent.TOUCH, rightButton_touchHandler);
			this.addChild(this._rightButton);
			this._rightButton.defaultSkin = new Image(Texture.fromBitmap(new VERTICAL_GRIP(), false));
			this._rightButton.upSkin = this._rightButton.downSkin = null;

			this._bottomButton = new Button();
			this._bottomButton.addEventListener(TouchEvent.TOUCH, bottomButton_touchHandler);
			this.addChild(this._bottomButton);
			this._bottomButton.defaultSkin = new Image(Texture.fromBitmap(new HORIZONTAL_GRIP(), false));
			this._bottomButton.upSkin = this._bottomButton.downSkin = null;
		}

		override protected function layout():void
		{
			this._header.width = this.stage.stageWidth;
			this._header.validate();

			this._image.x = 30 * this.dpiScale;
			this._image.y = this._header.height + 30 * this.dpiScale;

			this.layoutButtons();
			this._maxWidth = this.stage.stageWidth - this._rightButton.width - this._image.x;
			this._maxHeight = this.stage.stageHeight - this._bottomButton.height - this._image.y;
		}

		private function layoutButtons():void
		{
			this._rightButton.validate();
			this._rightButton.x = this._image.x + this._image.width;
			this._rightButton.y = this._image.y + (this._image.height - this._rightButton.height) / 2;

			this._bottomButton.validate();
			this._bottomButton.x = this._image.x + (this._image.width - this._bottomButton.width) / 2;
			this._bottomButton.y = this._image.y + this._image.height;
		}

		private function rightButton_touchHandler(event:TouchEvent):void
		{
			const touch:Touch = event.getTouch(this._rightButton);
			if(!touch || (this._rightTouchPointID >= 0 && touch.id != this._rightTouchPointID))
			{
				return;
			}

			if(touch.phase == TouchPhase.BEGAN)
			{
				this._rightTouchPointID = touch.id;
				this._startX = touch.globalX;
				this._startWidth = this._image.width;
			}
			else if(touch.phase == TouchPhase.MOVED)
			{
				this._image.width = Math.min(this._maxWidth, Math.max(this._minWidth, this._startWidth + touch.globalX - this._startX));
				this.layoutButtons()
			}
			else if(touch.phase == TouchPhase.ENDED)
			{
				this._rightTouchPointID = -1;
			}
		}

		private function bottomButton_touchHandler(event:TouchEvent):void
		{
			const touch:Touch = event.getTouch(this._bottomButton);
			if(!touch || (this._bottomTouchPointID >= 0 && touch.id != this._bottomTouchPointID))
			{
				return;
			}

			if(touch.phase == TouchPhase.BEGAN)
			{
				this._bottomTouchPointID = touch.id;
				this._startY = touch.globalY;
				this._startHeight = this._image.height;
			}
			else if(touch.phase == TouchPhase.MOVED)
			{
				this._image.height = Math.min(this._maxHeight, Math.max(this._minHeight, this._startHeight + touch.globalY - this._startY));
				this.layoutButtons()
			}
			else if(touch.phase == TouchPhase.ENDED)
			{
				this._bottomTouchPointID = -1;
			}
		}
	}
}
