package org.josht.starling.foxhole.kitchenSink.screens
{
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.GroupedList;
	import org.josht.starling.foxhole.controls.Screen;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.data.HierarchicalCollection;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;

	public class GroupedListScreen extends Screen
	{
		public function GroupedListScreen()
		{
			super();
		}

		private var _list:GroupedList;
		private var _header:ScreenHeader;
		private var _backButton:Button;
		
		private var _onBack:Signal = new Signal(GroupedListScreen);
		
		public function get onBack():ISignal
		{
			return this._onBack;
		}
		
		override protected function initialize():void
		{
			var groups:Array =
			[
				{
					header: "A",
					children:
					[
						{ text: "Aardvark" },
						{ text: "Alligator" },
						{ text: "Alpaca" },
						{ text: "Anteater" },
					]
				},
				{
					header: "B",
					children:
					[
						{ text: "Baboon" },
						{ text: "Bear" },
						{ text: "Beaver" },
					]
				},
				{
					header: "C",
					children:
					[
						{ text: "Canary" },
						{ text: "Cat" },
					]
				},
				{
					header: "D",
					children:
					[
						{ text: "Deer" },
						{ text: "Dingo" },
						{ text: "Dog" },
						{ text: "Dolphin" },
						{ text: "Donkey" },
						{ text: "Dragonfly" },
						{ text: "Duck" },
						{ text: "Dung Beetle" },
					]
				},
				{
					header: "E",
					children:
					[
						{ text: "Eagle" },
						{ text: "Earthworm" },
						{ text: "Eel" },
						{ text: "Elk" },
					]
				}
			];
			groups.fixed = true;
			
			this._list = new GroupedList();
			this._list.dataProvider = new HierarchicalCollection(groups);
			this._list.typicalItem = { text: "Item 1000" };
			this._list.typicalHeader = { text: "Group 10" };
			this._list.typicalFooter = { text: "Footer 10" };
			this._list.isSelectable = true;
			this._list.itemRendererProperties.labelField = "text";
			this._list.onChange.add(list_onChange);
			this.addChildAt(this._list, 0);

			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);

			this._header = new ScreenHeader();
			this._header.title = "Grouped List";
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

		private function list_onChange(list:GroupedList):void
		{
			trace("GroupedList onChange:", this._list.selectedGroupIndex, this._list.selectedItemIndex);
		}
	}
}