package
{
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.ui.ContextMenu;
	import flash.utils.getDefinitionByName;
	
	import feathers.system.DeviceCapabilities;
	
	import starling.core.Starling;

	[SWF(width="960",height="640",frameRate="60",backgroundColor="#ffffff")]
	public class TileList extends MovieClip
	{
		public function TileList()
		{
			var menu:ContextMenu = new ContextMenu();
			menu.hideBuiltInItems();
			this.contextMenu = menu;

			if(this.stage)
			{
				this.stage.align = StageAlign.TOP_LEFT;
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
				this.stage.mouseChildren = false;
			}
			this.mouseEnabled = this.mouseChildren = false;
			
			DeviceCapabilities.screenPixelWidth = 960;
			DeviceCapabilities.screenPixelHeight = 640;
			DeviceCapabilities.dpi = 326;

			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
		}

		private var _starling:Starling;

		private function start():void
		{
			this.gotoAndStop(2);
			this.graphics.clear();

			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;
			const MainType:Class = getDefinitionByName("feathers.examples.tileList.Main") as Class;
			this._starling = new Starling(MainType, this.stage);
			this._starling.start();
		}

		private function enterFrameHandler(event:Event):void
		{
			if(this.stage.stageWidth > 0 && this.stage.stageHeight > 0)
			{
				this.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				this.start();
			}
		}

		private function loaderInfo_completeHandler(event:Event):void
		{
			if(this.stage.stageWidth == 0 || this.stage.stageHeight == 0)
			{
				this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
				return;
			}
			this.start();
		}
	}
}