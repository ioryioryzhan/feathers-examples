package org.josht.starling.foxhole.kitchenSink.screens
{
	import org.josht.starling.foxhole.controls.Screen;
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class MainMenuScreen extends Screen
	{
		private static const LABELS:Vector.<String> = new <String>
		[
			"Button",
			"List",
			"Picker List",
			"Progress Bar",
			"Slider",
			"Text Input",
			"Toggle Switch",
		];
		
		public function MainMenuScreen()
		{
			super();
		}
		
		private var _onButton:Signal = new Signal(MainMenuScreen);
		
		public function get onButton():ISignal
		{
			return this._onButton;
		}
		
		private var _onSlider:Signal = new Signal(MainMenuScreen);
		
		public function get onSlider():ISignal
		{
			return this._onSlider;
		}
		
		private var _onToggleSwitch:Signal = new Signal(MainMenuScreen);
		
		public function get onToggleSwitch():ISignal
		{
			return this._onToggleSwitch;
		}
		
		private var _onList:Signal = new Signal(MainMenuScreen);
		
		public function get onList():ISignal
		{
			return this._onList;
		}
		
		private var _onPickerList:Signal = new Signal(MainMenuScreen);
		
		public function get onPickerList():ISignal
		{
			return this._onPickerList;
		}

		private var _onTextInput:Signal = new Signal(MainMenuScreen);

		public function get onTextInput():ISignal
		{
			return this._onTextInput;
		}

		private var _onProgressBar:Signal = new Signal(MainMenuScreen);

		public function get onProgressBar():ISignal
		{
			return this._onProgressBar;
		}
		
		private var _header:ScreenHeader;
		private var _buttons:Vector.<Button> = new <Button>[];
		
		override protected function initialize():void
		{
			const signals:Vector.<Signal> = new <Signal>[this._onButton, this._onList, this._onPickerList, this._onProgressBar, this._onSlider, this._onTextInput, this._onToggleSwitch];
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
			}

			this._header = new ScreenHeader();
			this._header.title = "Foxhole for Starling";
			this.addChild(this._header);
		}
		
		override protected function draw():void
		{
			const margin:Number = this.originalHeight * 0.04 * this.dpiScale;
			const spacingX:Number = this.originalHeight * 0.02 * this.dpiScale;
			const spacingY:Number = this.originalHeight * 0.02 * this.dpiScale;

			this._header.width = this.actualWidth;
			this._header.validate();

			const contentMaxWidth:Number = this.actualWidth - 2 * margin;
			const buttonCount:int = this._buttons.length;
			const buttonWidth:Number = 220 * this.dpiScale;
			var horizontalButtonCount:int = 1;
			var horizontalButtonCombinedWidth:Number = buttonWidth;
			while((horizontalButtonCombinedWidth + buttonWidth + spacingX) < contentMaxWidth)
			{
				horizontalButtonCombinedWidth += buttonWidth + spacingX;
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
				button.width = buttonWidth;
				button.height = 88 * this.dpiScale;
				button.x = positionX;
				button.y = positionY;
				positionX += buttonWidth + spacingX;
				if(positionX + buttonWidth >= contentMaxWidth)
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