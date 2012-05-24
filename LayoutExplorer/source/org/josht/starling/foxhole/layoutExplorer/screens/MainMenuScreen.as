package org.josht.starling.foxhole.layoutExplorer.screens
{
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.Screen;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class MainMenuScreen extends Screen
	{
		private static const LABELS:Vector.<String> = new <String>
		[
			"Horizontal",
			"Vertical",
			"Tiled Rows",
			"Tiled Columns"
		];

		public function MainMenuScreen()
		{
			super();
		}

		private var _onHorizontal:Signal = new Signal(MainMenuScreen);

		public function get onHorizontal():ISignal
		{
			return this._onHorizontal;
		}

		private var _onVertical:Signal = new Signal(MainMenuScreen);

		public function get onVertical():ISignal
		{
			return this._onVertical;
		}

		private var _onTiledRows:Signal = new Signal(MainMenuScreen);

		public function get onTiledRows():ISignal
		{
			return this._onTiledRows;
		}

		private var _onTiledColumns:Signal = new Signal(MainMenuScreen);

		public function get onTiledColumns():ISignal
		{
			return this._onTiledColumns;
		}

		private var _header:ScreenHeader;
		private var _buttons:Vector.<Button> = new <Button>[];
		private var _buttonMaxWidth:Number = 0;

		override protected function initialize():void
		{
			const signals:Vector.<Signal> = new <Signal>[this._onHorizontal, this._onVertical, this._onTiledRows, this._onTiledColumns];
			const buttonCount:int = LABELS.length;
			for(var i:int = 0; i < buttonCount; i++)
			{
				var label:String = LABELS[i];
				var signal:Signal = signals[i];
				var button:Button = new Button();
				button.label = label;
				this.triggerSignalOnButtonRelease(button, signal);
				this.addChild(button);
				this._buttons.push(button);
				button.validate();
				this._buttonMaxWidth = Math.max(this._buttonMaxWidth, button.width);
			}

			this._header = new ScreenHeader();
			this._header.title = "Layouts in Foxhole";
			this.addChild(this._header);
		}

		override protected function draw():void
		{
			const margin:Number = this.originalHeight * 0.06 * this.dpiScale;
			const spacingX:Number = this.originalHeight * 0.03 * this.dpiScale;
			const spacingY:Number = this.originalHeight * 0.03 * this.dpiScale;

			this._header.width = this.actualWidth;
			this._header.validate();

			const contentMaxWidth:Number = this.actualWidth - 2 * margin;
			const buttonCount:int = this._buttons.length;
			var horizontalButtonCount:int = 1;
			var horizontalButtonCombinedWidth:Number = this._buttonMaxWidth;
			while((horizontalButtonCombinedWidth + this._buttonMaxWidth + spacingX) <= contentMaxWidth)
			{
				horizontalButtonCombinedWidth += this._buttonMaxWidth + spacingX;
				horizontalButtonCount++;
				if(horizontalButtonCount == buttonCount)
				{
					break;
				}
			}

			const startX:Number = (this.actualWidth - horizontalButtonCombinedWidth) / 2;
			var positionX:Number = startX;
			var positionY:Number = this._header.y + this._header.height + spacingY;
			for(var i:int = 0; i < buttonCount; i++)
			{
				var button:Button = this._buttons[i];
				button.width = this._buttonMaxWidth;
				button.x = positionX;
				button.y = positionY;
				positionX += this._buttonMaxWidth + spacingX;
				if(positionX + this._buttonMaxWidth > margin + contentMaxWidth)
				{
					positionX = startX;
					positionY += button.height + spacingY;
				}
			}
		}

		private function triggerSignalOnButtonRelease(button:Button, signal:Signal):void
		{
			const self:MainMenuScreen = this;
			button.onRelease.add(function(button:Button):void
			{
				signal.dispatch(self);
			});
		}
	}
}
