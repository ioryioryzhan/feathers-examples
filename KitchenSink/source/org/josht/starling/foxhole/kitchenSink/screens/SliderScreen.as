package org.josht.starling.foxhole.kitchenSink.screens
{
	import org.josht.starling.foxhole.controls.Screen;
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.Label;
	import org.josht.starling.foxhole.controls.PickerList;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.controls.Slider;
	import org.josht.starling.foxhole.controls.ToggleSwitch;
	import org.josht.starling.foxhole.data.ListCollection;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;

	public class SliderScreen extends Screen
	{
		public function SliderScreen()
		{
			super();
		}

		private var _slider:Slider;
		private var _header:ScreenHeader;
		private var _backButton:Button;
		private var _settingsButton:Button;
		private var _valueLabel:Label;
		
		private var _onBack:Signal = new Signal(SliderScreen);
		
		public function get onBack():ISignal
		{
			return this._onBack;
		}

		private var _onSettings:Signal = new Signal(SliderScreen);

		public function get onSettings():ISignal
		{
			return this._onSettings;
		}
		
		override protected function initialize():void
		{
			this._slider = new Slider();
			this._slider.minimum = 0;
			this._slider.maximum = 100;
			this._slider.step = 1;
			this._slider.value = 50;
			this._slider.direction = Slider.DIRECTION_VERTICAL;
			this._slider.onChange.add(slider_onChange);
			this.addChild(this._slider);
			
			this._valueLabel = new Label();
			this._valueLabel.text = this._slider.value.toString();
			this.addChild(this._valueLabel);

			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);

			this._settingsButton = new Button();
			this._settingsButton.label = "Settings";
			this._settingsButton.onRelease.add(settingsButton_onRelease);

			this._header = new ScreenHeader();
			this._header.title = "Slider";
			this.addChild(this._header);
			this._header.leftItems = new <DisplayObject>
			[
				this._backButton
			];
			this._header.rightItems = new <DisplayObject>
			[
				this._settingsButton
			];
			
			// handles the back hardware key on android
			this.backButtonHandler = this.onBackButton;
		}
		
		override protected function draw():void
		{
			const spacingX:Number = this.originalHeight * 0.02 * this.dpiScale;

			this._header.width = this.actualWidth;
			this._header.validate();

			//auto-size the slider and label so that we can position them properly
			this._slider.validate();
			this._valueLabel.validate();

			const contentWidth:Number = this._slider.width + spacingX + this._valueLabel.width;
			this._slider.x = (this.actualWidth - contentWidth) / 2;
			this._slider.y = (this.actualHeight - this._slider.height) / 2;
			this._valueLabel.x = this._slider.x + this._slider.width + spacingX;
			this._valueLabel.y = this._slider.y + (this._slider.height - this._valueLabel.height) / 2;
		}
		
		private function onBackButton():void
		{
			this._onBack.dispatch(this);
		}
		
		private function slider_onChange(slider:Slider):void
		{
			this._valueLabel.text = this._slider.value.toString();
		}
		
		private function backButton_onRelease(button:Button):void
		{
			this.onBackButton();
		}

		private function settingsButton_onRelease(button:Button):void
		{
			this._onSettings.dispatch(this);
		}
	}
}