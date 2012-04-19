package org.josht.starling.foxhole.kitchenSink.screens
{
	import org.josht.starling.foxhole.controls.Screen;
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.Label;
	import org.josht.starling.foxhole.controls.List;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.controls.Slider;
	import org.josht.starling.foxhole.controls.ToggleSwitch;
	import org.josht.starling.foxhole.data.ListCollection;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;

	public class ListScreen extends Screen
	{
		public function ListScreen()
		{
			super();
		}
		
		private var _backButton:Button;
		private var _header:ScreenHeader;
		private var _list:List;
		
		private var _widthLabel:Label;
		private var _widthSlider:Slider;
		private var _heightLabel:Label;
		private var _heightSlider:Slider;
		private var _isSelectableLabel:Label;
		private var _isSelectableToggle:ToggleSwitch;
		private var _clipContentLabel:Label;
		private var _clipContentToggle:ToggleSwitch;
		private var _hasElasticEdgesLabel:Label;
		private var _hasElasticEdgesToggle:ToggleSwitch;
		
		private var _minX:Number;
		
		private var _onBack:Signal = new Signal(ListScreen);
		
		public function get onBack():ISignal
		{
			return this._onBack;
		}
		
		override protected function initialize():void
		{
			var items:Vector.<String> = new <String>[];
			for(var i:int = 0; i < 150; i++)
			{
				var label:String = "Item " + (i + 1).toString();
				items.push(label);
			}
			items.fixed = true;
			
			this._list = new List();
			this._list.dataProvider = new ListCollection(items);
			this._list.typicalItem = "Item 1000";
			this._list.height = 350 * this.dpiScale;
			this._list.clipContent = true;
			this.addChildAt(this._list, 0);
			
			//validate to get the width and height for the sliders
			this._list.validate();
			
			this._widthLabel = new Label();
			this._widthLabel.text = "width";
			this.addChild(this._widthLabel);
			this._widthSlider = new Slider();
			this._widthSlider.minimum = this._list.width;
			this._widthSlider.maximum = this.actualWidth;
			this._widthSlider.step = 1;
			this._widthSlider.value = this._list.width;
			this._widthSlider.onChange.add(widthSlider_onChange);
			this.addChild(this._widthSlider);
			
			this._heightLabel = new Label();
			this._heightLabel.text = "height";
			this.addChild(this._heightLabel);
			this._heightSlider = new Slider();
			this._heightSlider.minimum = this._list.height;
			this._heightSlider.maximum = this.actualHeight;
			this._heightSlider.step = 1;
			this._heightSlider.value = this._list.height;
			this._heightSlider.onChange.add(heightSlider_onChange);
			this.addChild(this._heightSlider);
			
			this._isSelectableLabel = new Label();
			this._isSelectableLabel.text = "isSelectable";
			this.addChild(this._isSelectableLabel);
			this._isSelectableToggle = new ToggleSwitch();
			this._isSelectableToggle.isSelected = this._list.isSelectable;
			this._isSelectableToggle.onChange.add(isSelectableToggle_onChange);
			this.addChild(this._isSelectableToggle);
			
			this._clipContentLabel = new Label();
			this._clipContentLabel.text = "clipContent";
			this.addChild(this._clipContentLabel);
			this._clipContentToggle = new ToggleSwitch();
			this._clipContentToggle.isSelected = this._list.clipContent;
			this._clipContentToggle.onChange.add(clipContentToggle_onChange);
			this.addChild(this._clipContentToggle);
			
			this._hasElasticEdgesLabel = new Label();
			this._hasElasticEdgesLabel.text = "hasElasticEdges";
			this.addChild(this._hasElasticEdgesLabel);
			this._hasElasticEdgesToggle = new ToggleSwitch();
			this._hasElasticEdgesToggle.isSelected = true;
			this._hasElasticEdgesToggle.onChange.add(hasElasticEdgesToggle_onChange);
			this.addChild(this._hasElasticEdgesToggle);

			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);

			this._header = new ScreenHeader();
			this._header.title = "List";
			this.addChild(this._header);
			this._header.leftItems = new <DisplayObject>
			[
				this._backButton
			];
			
			// handles the back hardware key on android
			this.backButtonHandler = this.onBackButton;
		}
		
		override protected function draw():void
		{
			const margin:Number = this.originalHeight * 0.04 * this.dpiScale;
			const spacing:Number = this.originalHeight * 0.02 * this.dpiScale;
			const spacingX:Number = this.originalHeight * 0.02 * this.dpiScale;

			this._header.width = this.actualWidth;
			this._header.validate();
			
			this._widthSlider.validate();
			this._widthSlider.x = this.actualWidth - this._widthSlider.width - margin;
			this._widthSlider.y = this._header.y + this._header.height + spacing;
			this._widthLabel.validate();
			this._widthLabel.x = this._widthSlider.x - this._widthLabel.width - spacingX;
			this._widthLabel.y = this._widthSlider.y + (this._widthSlider.height - this._widthLabel.height) / 2;
			
			this._heightSlider.maximum = this.actualHeight;
			this._heightSlider.validate();
			this._heightSlider.x = this.actualWidth - this._heightSlider.width - margin;
			this._heightSlider.y = this._widthSlider.y + this._widthSlider.height + spacing;
			this._heightLabel.validate();
			this._heightLabel.x = this._heightSlider.x - this._heightLabel.width - spacingX;
			this._heightLabel.y = this._heightSlider.y + (this._heightSlider.height - this._heightLabel.height) / 2;
			
			this._isSelectableToggle.validate();
			this._isSelectableToggle.x = this.actualWidth - this._isSelectableToggle.width - margin;
			this._isSelectableToggle.y = this._heightSlider.y + this._heightSlider.height + spacing;
			this._isSelectableLabel.validate();
			this._isSelectableLabel.x = this._isSelectableToggle.x - this._isSelectableLabel.width - spacingX;
			this._isSelectableLabel.y = this._isSelectableToggle.y + (this._isSelectableToggle.height - this._isSelectableLabel.height) / 2;
			
			this._clipContentToggle.validate();
			this._clipContentToggle.x = this.actualWidth - this._clipContentToggle.width - margin;
			this._clipContentToggle.y = this._isSelectableToggle.y + this._isSelectableToggle.height + spacing;
			this._clipContentLabel.validate();
			this._clipContentLabel.x = this._clipContentToggle.x - this._clipContentLabel.width - spacingX;
			this._clipContentLabel.y = this._clipContentToggle.y + (this._clipContentToggle.height - this._clipContentLabel.height) / 2;
			
			this._hasElasticEdgesToggle.validate();
			this._hasElasticEdgesToggle.x = this.actualWidth - this._clipContentToggle.width - margin;
			this._hasElasticEdgesToggle.y = this._clipContentToggle.y + this._clipContentToggle.height + spacing;
			this._hasElasticEdgesLabel.validate();
			this._hasElasticEdgesLabel.x = this._hasElasticEdgesToggle.x - this._hasElasticEdgesLabel.width - spacingX;
			this._hasElasticEdgesLabel.y = this._hasElasticEdgesToggle.y + (this._hasElasticEdgesToggle.height - this._hasElasticEdgesLabel.height) / 2;
			
			this._minX = Math.min(this._widthLabel.x, this._heightLabel.x, this._isSelectableLabel.x,
				this._clipContentLabel.x, this._hasElasticEdgesLabel.x) - spacingX;
			this._widthSlider.maximum = this._minX;
			this._list.validate();
			this._list.x = (this._minX - this._list.width) / 2;
			this._list.y = (this.actualHeight - this._list.height) / 2;
		}
		
		private function onBackButton():void
		{
			this._onBack.dispatch(this);
		}
		
		private function backButton_onRelease(button:Button):void
		{
			this.onBackButton();
		}
		
		private function widthSlider_onChange(slider:Slider):void
		{
			this._list.width = this._widthSlider.value;
			this._list.x = (this._minX - this._list.width) / 2;
		}
		
		private function heightSlider_onChange(slider:Slider):void
		{
			this._list.height = this._heightSlider.value;
			this._list.y = (this.actualHeight - this._list.height) / 2;
		}
		
		private function isSelectableToggle_onChange(toggle:ToggleSwitch):void
		{
			this._list.isSelectable = this._isSelectableToggle.isSelected;
		}
		
		private function clipContentToggle_onChange(toggle:ToggleSwitch):void
		{
			this._list.clipContent = this._clipContentToggle.isSelected;
		}
		
		private function hasElasticEdgesToggle_onChange(toggle:ToggleSwitch):void
		{
			this._list.setScrollerProperty("hasElasticEdges", this._hasElasticEdgesToggle.isSelected);
		}
	}
}