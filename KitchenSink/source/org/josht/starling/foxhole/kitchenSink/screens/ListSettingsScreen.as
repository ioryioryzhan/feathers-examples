package org.josht.starling.foxhole.kitchenSink.screens
{
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.List;
	import org.josht.starling.foxhole.controls.Screen;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.controls.ToggleSwitch;
	import org.josht.starling.foxhole.data.ListCollection;
	import org.josht.starling.foxhole.kitchenSink.data.ListSettings;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;

	public class ListSettingsScreen extends Screen
	{
		public function ListSettingsScreen()
		{
		}

		public var settings:ListSettings;

		private var _header:ScreenHeader;
		private var _list:List;
		private var _backButton:Button;

		private var _isSelectableToggle:ToggleSwitch;
		private var _hasElasticEdgesToggle:ToggleSwitch;

		private var _onBack:Signal = new Signal(ListSettingsScreen);

		public function get onBack():ISignal
		{
			return this._onBack;
		}

		override protected function initialize():void
		{
			this._isSelectableToggle = new ToggleSwitch();
			this._isSelectableToggle.isSelected = this.settings.isSelectable;
			this._isSelectableToggle.onChange.add(isSelectableToggle_onChange);

			this._hasElasticEdgesToggle = new ToggleSwitch();
			this._hasElasticEdgesToggle.isSelected = this.settings.hasElasticEdges;
			this._hasElasticEdgesToggle.onChange.add(hasElasticEdgesToggle_onChange);

			this._list = new List();
			this._list.isSelectable = false;
			this._list.dataProvider = new ListCollection(
			[
				{ label: "isSelectable", accessory: this._isSelectableToggle },
				{ label: "hasElasticEdges", accessory: this._hasElasticEdgesToggle },
			]);
			this.addChild(this._list);

			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);

			this._header = new ScreenHeader();
			this._header.title = "List Settings";
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

		private function onBackButton():void
		{
			this._onBack.dispatch(this);
		}

		private function backButton_onRelease(button:Button):void
		{
			this.onBackButton();
		}

		private function isSelectableToggle_onChange(toggle:ToggleSwitch):void
		{
			this.settings.isSelectable = this._isSelectableToggle.isSelected;
		}

		private function hasElasticEdgesToggle_onChange(toggle:ToggleSwitch):void
		{
			this.settings.hasElasticEdges = this._hasElasticEdgesToggle.isSelected;
		}
	}
}
