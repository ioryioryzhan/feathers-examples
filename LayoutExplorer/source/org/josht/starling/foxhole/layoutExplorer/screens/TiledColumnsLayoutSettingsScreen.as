package org.josht.starling.foxhole.layoutExplorer.screens
{
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.List;
	import org.josht.starling.foxhole.controls.PickerList;
	import org.josht.starling.foxhole.controls.Screen;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.controls.Slider;
	import org.josht.starling.foxhole.data.ListCollection;
	import org.josht.starling.foxhole.layout.TiledColumnsLayout;
	import org.josht.starling.foxhole.layoutExplorer.data.TiledColumnsLayoutSettings;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;

	public class TiledColumnsLayoutSettingsScreen extends Screen
	{
		public function TiledColumnsLayoutSettingsScreen()
		{
		}

		public var settings:TiledColumnsLayoutSettings;

		private var _header:ScreenHeader;
		private var _list:List;
		private var _backButton:Button;

		private var _itemCountSlider:Slider;
		private var _gapSlider:Slider;
		private var _paddingTopSlider:Slider;
		private var _paddingRightSlider:Slider;
		private var _paddingBottomSlider:Slider;
		private var _paddingLeftSlider:Slider;
		private var _horizontalAlignPicker:PickerList;
		private var _verticalAlignPicker:PickerList;
		private var _tileHorizontalAlignPicker:PickerList;
		private var _tileVerticalAlignPicker:PickerList;

		private var _onBack:Signal = new Signal(TiledColumnsLayoutSettingsScreen);

		public function get onBack():ISignal
		{
			return this._onBack;
		}

		override protected function initialize():void
		{
			this._itemCountSlider = new Slider();
			this._itemCountSlider.direction = Slider.DIRECTION_HORIZONTAL;
			this._itemCountSlider.minimum = 1;
			this._itemCountSlider.maximum = 100;
			this._itemCountSlider.step = 1;
			this._itemCountSlider.value = this.settings.itemCount;
			this._itemCountSlider.onChange.add(itemCountSlider_onChange);

			this._horizontalAlignPicker = new PickerList();
			this._horizontalAlignPicker.typicalItem = TiledColumnsLayout.HORIZONTAL_ALIGN_CENTER;
			this._horizontalAlignPicker.dataProvider = new ListCollection(new <String>
			[
				TiledColumnsLayout.HORIZONTAL_ALIGN_LEFT,
				TiledColumnsLayout.HORIZONTAL_ALIGN_CENTER,
				TiledColumnsLayout.HORIZONTAL_ALIGN_RIGHT
			]);
			this._horizontalAlignPicker.selectedItem = this.settings.horizontalAlign;
			this._horizontalAlignPicker.onChange.add(horizontalAlignPicker_onChange);

			this._verticalAlignPicker = new PickerList();
			this._verticalAlignPicker.typicalItem = TiledColumnsLayout.VERTICAL_ALIGN_BOTTOM;
			this._verticalAlignPicker.dataProvider = new ListCollection(new <String>
			[
				TiledColumnsLayout.VERTICAL_ALIGN_TOP,
				TiledColumnsLayout.VERTICAL_ALIGN_MIDDLE,
				TiledColumnsLayout.VERTICAL_ALIGN_BOTTOM
			]);
			this._verticalAlignPicker.selectedItem = this.settings.verticalAlign;
			this._verticalAlignPicker.onChange.add(verticalAlignPicker_onChange);

			this._tileHorizontalAlignPicker = new PickerList();
			this._tileHorizontalAlignPicker.typicalItem = TiledColumnsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
			this._tileHorizontalAlignPicker.dataProvider = new ListCollection(new <String>
			[
				TiledColumnsLayout.TILE_HORIZONTAL_ALIGN_LEFT,
				TiledColumnsLayout.TILE_HORIZONTAL_ALIGN_CENTER,
				TiledColumnsLayout.TILE_HORIZONTAL_ALIGN_RIGHT,
				TiledColumnsLayout.TILE_HORIZONTAL_ALIGN_JUSTIFY
			]);
			this._tileHorizontalAlignPicker.selectedItem = this.settings.tileHorizontalAlign;
			this._tileHorizontalAlignPicker.onChange.add(tileHorizontalAlignPicker_onChange);

			this._tileVerticalAlignPicker = new PickerList();
			this._tileVerticalAlignPicker.typicalItem = TiledColumnsLayout.TILE_VERTICAL_ALIGN_BOTTOM;
			this._tileVerticalAlignPicker.dataProvider = new ListCollection(new <String>
			[
				TiledColumnsLayout.TILE_VERTICAL_ALIGN_TOP,
				TiledColumnsLayout.TILE_VERTICAL_ALIGN_MIDDLE,
				TiledColumnsLayout.TILE_VERTICAL_ALIGN_BOTTOM,
				TiledColumnsLayout.TILE_VERTICAL_ALIGN_JUSTIFY
			]);
			this._tileVerticalAlignPicker.selectedItem = this.settings.tileVerticalAlign;
			this._tileVerticalAlignPicker.onChange.add(tileVerticalAlignPicker_onChange);

			this._gapSlider = new Slider();
			this._gapSlider.direction = Slider.DIRECTION_HORIZONTAL;
			this._gapSlider.minimum = 0;
			this._gapSlider.maximum = 100;
			this._gapSlider.step = 1;
			this._gapSlider.value = this.settings.gap;
			this._gapSlider.onChange.add(gapSlider_onChange);

			this._paddingTopSlider = new Slider();
			this._paddingTopSlider.direction = Slider.DIRECTION_HORIZONTAL;
			this._paddingTopSlider.minimum = 0;
			this._paddingTopSlider.maximum = 100;
			this._paddingTopSlider.step = 1;
			this._paddingTopSlider.value = this.settings.paddingTop;
			this._paddingTopSlider.onChange.add(paddingTopSlider_onChange);

			this._paddingRightSlider = new Slider();
			this._paddingRightSlider.direction = Slider.DIRECTION_HORIZONTAL;
			this._paddingRightSlider.minimum = 0;
			this._paddingRightSlider.maximum = 100;
			this._paddingRightSlider.step = 1;
			this._paddingRightSlider.value = this.settings.paddingRight;
			this._paddingRightSlider.onChange.add(paddingRightSlider_onChange);

			this._paddingBottomSlider = new Slider();
			this._paddingBottomSlider.direction = Slider.DIRECTION_HORIZONTAL;
			this._paddingBottomSlider.minimum = 0;
			this._paddingBottomSlider.maximum = 100;
			this._paddingBottomSlider.step = 1;
			this._paddingBottomSlider.value = this.settings.paddingBottom;
			this._paddingBottomSlider.onChange.add(paddingBottomSlider_onChange);

			this._paddingLeftSlider = new Slider();
			this._paddingLeftSlider.direction = Slider.DIRECTION_HORIZONTAL;
			this._paddingLeftSlider.minimum = 0;
			this._paddingLeftSlider.maximum = 100;
			this._paddingLeftSlider.step = 1;
			this._paddingLeftSlider.value = this.settings.paddingLeft;
			this._paddingLeftSlider.onChange.add(paddingLeftSlider_onChange);

			this._list = new List();
			this._list.isSelectable = false;
			this._list.dataProvider = new ListCollection(
			[
				{ label: "Item Count", accessory: this._itemCountSlider },
				{ label: "horizontalAlign", accessory: this._horizontalAlignPicker },
				{ label: "verticalAlign", accessory: this._verticalAlignPicker },
				{ label: "tileHorizontalAlign", accessory: this._tileHorizontalAlignPicker },
				{ label: "tileVerticalAlign", accessory: this._tileVerticalAlignPicker },
				{ label: "gap", accessory: this._gapSlider },
				{ label: "paddingTop", accessory: this._paddingTopSlider },
				{ label: "paddingRight", accessory: this._paddingRightSlider },
				{ label: "paddingBottom", accessory: this._paddingBottomSlider },
				{ label: "paddingLeft", accessory: this._paddingLeftSlider },
			]);
			this.addChild(this._list);

			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);

			this._header = new ScreenHeader();
			this._header.title = "Tiled Rows Layout Settings";
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

		private function itemCountSlider_onChange(slider:Slider):void
		{
			this.settings.itemCount = slider.value;
		}

		private function horizontalAlignPicker_onChange(picker:PickerList):void
		{
			this.settings.horizontalAlign = this._horizontalAlignPicker.selectedItem as String;
		}

		private function verticalAlignPicker_onChange(picker:PickerList):void
		{
			this.settings.verticalAlign = this._verticalAlignPicker.selectedItem as String;
		}

		private function tileHorizontalAlignPicker_onChange(picker:PickerList):void
		{
			this.settings.tileHorizontalAlign = this._tileHorizontalAlignPicker.selectedItem as String;
		}

		private function tileVerticalAlignPicker_onChange(picker:PickerList):void
		{
			this.settings.tileVerticalAlign = this._tileVerticalAlignPicker.selectedItem as String;
		}

		private function gapSlider_onChange(slider:Slider):void
		{
			this.settings.gap = this._gapSlider.value;
		}

		private function paddingTopSlider_onChange(slider:Slider):void
		{
			this.settings.paddingTop = this._paddingTopSlider.value;
		}

		private function paddingRightSlider_onChange(slider:Slider):void
		{
			this.settings.paddingRight = this._paddingRightSlider.value;
		}

		private function paddingBottomSlider_onChange(slider:Slider):void
		{
			this.settings.paddingBottom = this._paddingBottomSlider.value;
		}

		private function paddingLeftSlider_onChange(slider:Slider):void
		{
			this.settings.paddingLeft = this._paddingLeftSlider.value;
		}
	}
}
