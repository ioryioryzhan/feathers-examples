package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.ui.ContextMenu;
	import flash.utils.getDefinitionByName;

	import org.josht.system.PhysicalCapabilities;

	import starling.core.Starling;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	[SWF(width="960",height="640",frameRate="60",backgroundColor="#f3f3f3")]
	public class KitchenSinkWeb extends MovieClip
	{
		public function KitchenSinkWeb()
		{
			var menu:ContextMenu = new ContextMenu();
			menu.hideBuiltInItems();
			this.contextMenu = menu;
			
			if(this.stage)
			{
				this.stage.align = StageAlign.TOP_LEFT;
				this.stage.scaleMode = StageScaleMode.NO_SCALE;
			}

			PhysicalCapabilities.CUSTOM_SCREEN_WIDTH = 960;
			PhysicalCapabilities.CUSTOM_SCREEN_HEIGHT = 640;
			PhysicalCapabilities.CUSTOM_SCREEN_DPI = 326;
			
			this.loaderInfo.addEventListener(Event.COMPLETE, loaderInfo_completeHandler);
		}
		
		private var _starling:Starling;
		
		private function start():void
		{
			this.gotoAndStop(2);
			this.graphics.clear();
			
			Starling.handleLostContext = true;
			Starling.multitouchEnabled = true;
			const MainType:Class = getDefinitionByName("org.josht.starling.foxhole.kitchenSink.KitchenSinkRoot") as Class;
			this._starling = new Starling(MainType, this.stage);
			this._starling.enableErrorChecking = false;
			//this._starling.showStats = true;
			//this._starling.showStatsAt(HAlign.LEFT, VAlign.BOTTOM);
			this._starling.start();
		}
		
		private function loaderInfo_completeHandler(event:Event):void
		{
			this.start();
		}
	}
}