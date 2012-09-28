package feathers.examples.youtube.screens
{
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;

	import org.osflash.signals.ISignal;

	import org.osflash.signals.Signal;

	public class MainMenuScreen extends Screen
	{
		public function MainMenuScreen()
		{
		}

		private var _header:Header;
		private var _list:List;

		private var _onList:Signal = new Signal(MainMenuScreen, Object);

		public function get onList():ISignal
		{
			return this._onList;
		}

		override protected function initialize():void
		{
			this._list = new List();
			this._list.dataProvider = new ListCollection(
			[
				{ name: "Top Rated", url: "https://gdata.youtube.com/feeds/api/standardfeeds/top_rated?fields=entry[link/@rel='http://gdata.youtube.com/schemas/2007%23mobile']" },
				{ name: "Top Favorites", url: "https://gdata.youtube.com/feeds/api/standardfeeds/top_favorites?fields=entry[link/@rel='http://gdata.youtube.com/schemas/2007%23mobile']" },
				{ name: "Most Shared", url: "https://gdata.youtube.com/feeds/api/standardfeeds/most_shared?fields=entry[link/@rel='http://gdata.youtube.com/schemas/2007%23mobile']" },
				{ name: "Most Popular", url: "https://gdata.youtube.com/feeds/api/standardfeeds/most_popular?fields=entry[link/@rel='http://gdata.youtube.com/schemas/2007%23mobile']" },
				{ name: "Most Recent", url: "https://gdata.youtube.com/feeds/api/standardfeeds/most_recent?fields=entry[link/@rel='http://gdata.youtube.com/schemas/2007%23mobile']" },
				{ name: "Most Discussed", url: "https://gdata.youtube.com/feeds/api/standardfeeds/most_discussed?fields=entry[link/@rel='http://gdata.youtube.com/schemas/2007%23mobile']" },
				{ name: "Most Responded", url: "https://gdata.youtube.com/feeds/api/standardfeeds/most_responded?fields=entry[link/@rel='http://gdata.youtube.com/schemas/2007%23mobile']" },
				{ name: "Recently Featured", url: "https://gdata.youtube.com/feeds/api/standardfeeds/recently_featured?fields=entry[link/@rel='http://gdata.youtube.com/schemas/2007%23mobile']" },
				{ name: "Trending Videos", url: "https://gdata.youtube.com/feeds/api/standardfeeds/on_the_web?fields=entry[link/@rel='http://gdata.youtube.com/schemas/2007%23mobile']" },
			]);
			this._list.itemRendererProperties.labelField = "name";
			this._list.onChange.add(list_onChange);
			this.addChild(this._list);

			this._header = new Header();
			this._header.title = "YouTube Feeds";
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
			this._onList.dispatch(this, this._list.selectedItem);
		}
	}
}
