package org.josht.starling.foxhole.kitchenSink.screens
{
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.List;
	import org.josht.starling.foxhole.controls.Screen;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.data.ListCollection;
	import org.josht.starling.foxhole.kitchenSink.data.ListSettings;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;

	public class ListScreen extends Screen
	{
		public function ListScreen()
		{
			super();
		}

		public var settings:ListSettings;

		private var _list:List;
		private var _header:ScreenHeader;
		private var _backButton:Button;
		private var _settingsButton:Button;
		
		private var _onBack:Signal = new Signal(ListScreen);
		
		public function get onBack():ISignal
		{
			return this._onBack;
		}

		private var _onSettings:Signal = new Signal(ListScreen);

		public function get onSettings():ISignal
		{
			return this._onSettings;
		}
		
		override protected function initialize():void
		{
			var items:Array = [];
			for(var i:int = 0; i < 150; i++)
			{
				var item:Object = {text: "Item " + (i + 1).toString()};
				items.push(item);
			}
			items.fixed = true;
			
			this._list = new List();
			this._list.dataProvider = new ListCollection(items);
			this._list.typicalItem = {text: "Item 1000"};
			this._list.scrollerProperties =
			{
				hasElasticEdges: this.settings.hasElasticEdges
			};
			this._list.isSelectable = this.settings.isSelectable;
			this._list.itemRendererProperties.labelField = "text";
			this.addChildAt(this._list, 0);

			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);

			this._settingsButton = new Button();
			this._settingsButton.label = "Settings";
			this._settingsButton.onRelease.add(settingsButton_onRelease);

			this._header = new ScreenHeader();
			this._header.title = "List";
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

		private function settingsButton_onRelease(button:Button):void
		{
			this._onSettings.dispatch(this);
		}
	}
}