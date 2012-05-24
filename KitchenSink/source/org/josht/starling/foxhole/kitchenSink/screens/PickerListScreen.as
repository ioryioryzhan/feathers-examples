package org.josht.starling.foxhole.kitchenSink.screens
{
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.PickerList;
	import org.josht.starling.foxhole.controls.Screen;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.data.ListCollection;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;

	public class PickerListScreen extends Screen
	{
		public function PickerListScreen()
		{
			super();
		}
		
		private var _header:ScreenHeader;
		private var _backButton:Button;
		private var _list:PickerList;
		
		private var _onBack:Signal = new Signal(PickerListScreen);
		
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

			this._list = new PickerList();
			this._list.dataProvider = new ListCollection(items);
			this.addChildAt(this._list, 0);
			this._list.typicalItem = "Item 1000";
			//we need to do this separately. the one above applies to the picker
			//list's button, while the one below applies to the picker list's
			//pop up list
			this._list.setListProperty("typicalItem", "Item 1000");

			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);

			this._header = new ScreenHeader();
			this._header.title = "Picker List";
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
			this._header.width = this.actualWidth;
			this._header.validate();
			
			this._list.validate();
			this._list.x = (this.actualWidth - this._list.width) / 2;
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
	}
}