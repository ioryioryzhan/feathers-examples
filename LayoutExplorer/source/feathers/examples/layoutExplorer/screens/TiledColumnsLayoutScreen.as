package feathers.examples.layoutExplorer.screens
{
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.controls.ScreenHeader;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.layout.TiledColumnsLayout;
	import feathers.examples.layoutExplorer.data.TiledColumnsLayoutSettings;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.DisplayObject;
	import starling.display.Quad;

	public class TiledColumnsLayoutScreen extends Screen
	{
		public function TiledColumnsLayoutScreen()
		{
			super();
		}

		public var settings:TiledColumnsLayoutSettings;

		private var _container:ScrollContainer;
		private var _header:ScreenHeader;
		private var _backButton:Button;
		private var _settingsButton:Button;

		private var _onBack:Signal = new Signal(TiledColumnsLayoutScreen);

		public function get onBack():ISignal
		{
			return this._onBack;
		}

		private var _onSettings:Signal = new Signal(TiledColumnsLayoutScreen);

		public function get onSettings():ISignal
		{
			return this._onSettings;
		}

		override protected function initialize():void
		{
			const layout:TiledColumnsLayout = new TiledColumnsLayout();
			layout.paging = this.settings.paging;
			layout.gap = this.settings.gap;
			layout.paddingTop = this.settings.paddingTop;
			layout.paddingRight = this.settings.paddingRight;
			layout.paddingBottom = this.settings.paddingBottom;
			layout.paddingLeft = this.settings.paddingLeft;
			layout.horizontalAlign = this.settings.horizontalAlign;
			layout.verticalAlign = this.settings.verticalAlign;
			layout.tileHorizontalAlign = this.settings.tileHorizontalAlign;
			layout.tileVerticalAlign = this.settings.tileVerticalAlign;

			this._container = new ScrollContainer();
			this._container.layout = layout;
			this._container.scrollerProperties.snapToPages = this.settings.paging != TiledColumnsLayout.PAGING_NONE;
			this._container.scrollerProperties.snapScrollPositionsToPixels = true;
			if(this.settings.paging == TiledColumnsLayout.PAGING_VERTICAL)
			{
				this._container.scrollerProperties.horizontalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			}
			else
			{
				this._container.scrollerProperties.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			}
			this.addChild(this._container);
			for(var i:int = 0; i < this.settings.itemCount; i++)
			{
				var size:Number = (44 + 88 * Math.random()) * this.dpiScale;
				var quad:Quad = new Quad(size, size, 0x194966);
				this._container.addChild(quad);
			}

			this._backButton = new Button();
			this._backButton.label = "Back";
			this._backButton.onRelease.add(backButton_onRelease);

			this._settingsButton = new Button();
			this._settingsButton.label = "Settings";
			this._settingsButton.onRelease.add(settingsButton_onRelease);

			this._header = new ScreenHeader();
			this._header.title = "Tiled Columns Layout";
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

			this._container.y = this._header.height;
			this._container.width = this.actualWidth;
			this._container.height = this.actualHeight - this._container.y;
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
