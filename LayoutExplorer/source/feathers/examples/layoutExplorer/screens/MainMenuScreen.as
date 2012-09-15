package feathers.examples.layoutExplorer.screens
{
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.controls.ScreenHeader;
	import feathers.data.ListCollection;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	public class MainMenuScreen extends Screen
	{
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
		private var _list:List;

		override protected function initialize():void
		{
			this._list = new List();
			this._list.dataProvider = new ListCollection(
			[
				{ text: "Horizontal", signal: this._onHorizontal },
				{ text: "Vertical", signal: this._onVertical },
				{ text: "Tiled Rows", signal: this._onTiledRows },
				{ text: "Tiled Columns", signal: this._onTiledColumns },
			]);
			this._list.itemRendererProperties.labelField = "text";
			this._list.onChange.add(list_onChange);
			this.addChild(this._list);

			this._header = new ScreenHeader();
			this._header.title = "Layouts in Feathers";
			this.addChild(this._header);
		}

		override protected function draw():void
		{
			this._header.width = this.actualWidth;
			this._header.validate();

			this._list.y = this._header.height;
			this._list.width = this.actualWidth;
			this._list.height = this.actualHeight - this._list.y;
		}

		private function list_onChange(list:List):void
		{
			const signal:Signal = this._list.selectedItem.signal;
			signal.dispatch(this);
		}
	}
}
