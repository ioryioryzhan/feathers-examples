package feathers.examples.youtube.screens
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.examples.youtube.models.YouTubeModel;

	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;

	public class ListVideosScreen extends Screen
	{
		public function ListVideosScreen()
		{
		}

		private var _header:Header;
		private var _backButton:Button;
		private var _list:List;
		private var _message:Label;

		private var _model:YouTubeModel;

		public function get model():YouTubeModel
		{
			return this._model;
		}

		public function set model(value:YouTubeModel):void
		{
			if(this._model == value)
			{
				return;
			}
			this._model = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		private var _loader:URLLoader;

		private var _onComplete:Signal = new Signal(ListVideosScreen);

		public function get onComplete():ISignal
		{
			return this._onComplete;
		}

		private var _onVideo:Signal = new Signal(ListVideosScreen, Object);

		public function get onVideo():ISignal
		{
			return this._onVideo;
		}

		override protected function initialize():void
		{
			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(onBackButton);

			this._header = new Header();
			this.addChild(this._header);
			this._header.leftItems = new <DisplayObject>
			[
				this._backButton
			];

			this._list = new List();
			this._list.itemRendererProperties.labelField = "title";
			this._list.itemRendererProperties.accessoryLabelField = "author";
			this._list.onChange.add(list_onChange);
			this.addChild(this._list);

			this._message = new Label();
			this._message.text = "Loading...";
			this.addChild(this._message);

			this.backButtonHandler = onBackButton;
		}

		override protected function draw():void
		{
			const dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);

			this._header.width = this.actualWidth;
			this._header.validate();

			this._list.y = this._header.height;
			this._list.width = this.actualWidth;
			this._list.height = this.actualHeight - this._list.y;

			this._message.width = this.actualWidth - this._header.paddingLeft - this._header.paddingRight;
			this._message.x = (this.actualWidth = this._message.width) / 2;
			this._message.y = this._list.y + this._message.x;

			if(dataInvalid)
			{
				this._list.dataProvider = null;
				if(this._model && this._model.selectedList)
				{
					this._header.title = this._model.selectedList.name;
					if(this._loader)
					{
						this.cleanUpLoader();
					}
					this._loader = new URLLoader();
					this._loader.addEventListener(Event.COMPLETE, loader_completeHandler);
					this._loader.addEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
					this._loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
					this._loader.load(new URLRequest(this._model.selectedList.url));
				}
			}
		}

		private function onBackButton(button:Button = null):void
		{
			this._onComplete.dispatch(this);
		}

		private function cleanUpLoader():void
		{
			this._loader.removeEventListener(Event.COMPLETE, loader_completeHandler);
			this._loader.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
			this._loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
		}

		private function list_onChange(list:List):void
		{
			if(this._list.selectedIndex < 0)
			{
				return;
			}
			this._onVideo.dispatch(this, this._list.selectedItem);
		}

		private function loader_completeHandler(event:Event):void
		{
			this._message.visible = false;

			const feed:XML = new XML(this._loader.data);
			const atom:Namespace = feed.namespace();
			const media:Namespace = feed.namespace("media");

			const items:Array = [];
			const entries:XMLList = feed.atom::entry;
			const entryCount:int = entries.length();
			for(var i:int = 0; i < entryCount; i++)
			{
				var entry:XML = entries[i];
				var item:Object = {};
				item.title = entry.atom::title[0].toString();
				item.author = entry.atom::author[0].atom::name[0].toString();
				item.url = entry.media::group[0].media::player[0].@url.toString();
				item.description = entry.media::group[0].media::description[0].toString();
				items.push(item);
			}
			this._list.dataProvider = new ListCollection(items);

			this.cleanUpLoader();
		}

		private function loader_errorHandler(event:ErrorEvent):void
		{
			this.cleanUpLoader();
			this._message.text = "Unable to load data. Please try again later."
			this._message.visible = true;
			this.invalidate(INVALIDATION_FLAG_STYLES);
		}
	}
}
