package org.josht.starling.foxhole.kitchenSink.screens
{
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.List;
	import org.josht.starling.foxhole.controls.PickerList;
	import org.josht.starling.foxhole.controls.Screen;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.controls.Slider;
	import org.josht.starling.foxhole.controls.ToggleSwitch;
	import org.josht.starling.foxhole.data.ListCollection;
	import org.josht.starling.foxhole.kitchenSink.data.SliderSettings;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;

	public class SliderSettingsScreen extends Screen
	{
		public function SliderSettingsScreen()
		{
		}

		public var settings:SliderSettings;

		private var _header:ScreenHeader;
		private var _list:List;
		private var _backButton:Button;
		private var _directionPicker:PickerList;
		private var _liveDraggingToggle:ToggleSwitch;
		private var _stepSlider:Slider;

		private var _onBack:Signal = new Signal(SliderSettingsScreen);

		public function get onBack():ISignal
		{
			return this._onBack;
		}

		override protected function initialize():void
		{
			this._directionPicker = new PickerList();
			this._directionPicker.typicalItem = Slider.DIRECTION_HORIZONTAL;
			this._directionPicker.dataProvider = new ListCollection(new <String>
			[
				Slider.DIRECTION_HORIZONTAL,
				Slider.DIRECTION_VERTICAL
			]);
			this._directionPicker.selectedItem = this.settings.direction;
			this._directionPicker.onChange.add(directionPicker_onChange);

			this._liveDraggingToggle = new ToggleSwitch();
			this._liveDraggingToggle.isSelected = this.settings.liveDragging;
			this._liveDraggingToggle.onChange.add(liveDraggingToggle_onChange);

			this._stepSlider = new Slider();
			this._stepSlider.minimum = 1;
			this._stepSlider.maximum = 20;
			this._stepSlider.step = 1;
			this._stepSlider.value = this.settings.step;
			this._stepSlider.onChange.add(stepSlider_onChange);

			this._list = new List();
			this._list.isSelectable = false;
			this._list.dataProvider = new ListCollection(
			[
				{ label: "direction", accessory: this._directionPicker },
				{ label: "liveDragging", accessory: this._liveDraggingToggle },
				{ label: "step", accessory: this._stepSlider },
			]);
			this.addChild(this._list);

			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);

			this._header = new ScreenHeader();
			this._header.title = "Slider Settings";
			this.addChild(this._header);
			this._header.leftItems = new <DisplayObject>
			[
				this._backButton
			];

			this.backButtonHandler = this.onBackButton;
		}

		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._header.validate();

			this._list.y = this._header.height;
			this._list.width = this.actualWidth;
			this._list.height = this.actualHeight - this._list.y;
		}

		private function directionPicker_onChange(list:PickerList):void
		{
			this.settings.direction = this._directionPicker.selectedItem as String;
		}

		private function liveDraggingToggle_onChange(toggle:ToggleSwitch):void
		{
			this.settings.liveDragging = this._liveDraggingToggle.isSelected;
		}

		private function stepSlider_onChange(slider:Slider):void
		{
			this.settings.step = this._stepSlider.value;
		}

		private function onBackButton():void
		{
			this._onBack.dispatch(this);
		}

		private function backButton_onRelease(button:Button):void
		{
			this.onBackButton();
		}
	}
}
