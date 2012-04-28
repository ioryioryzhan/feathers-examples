package org.josht.starling.foxhole.displayObjects
{
	import com.gskinner.motion.easing.Cubic;

	import flash.ui.Mouse;

	import org.josht.starling.foxhole.controls.ScreenNavigator;
	import org.josht.starling.foxhole.controls.ScreenNavigatorItem;
	import org.josht.starling.foxhole.controls.TabBar;
	import org.josht.starling.foxhole.core.AddedWatcher;
	import org.josht.starling.foxhole.data.ListCollection;
	import org.josht.starling.foxhole.displayObjects.screens.Scale3ImageScreen;
	import org.josht.starling.foxhole.displayObjects.screens.Scale9ImageScreen;
	import org.josht.starling.foxhole.displayObjects.screens.TiledImageScreen;
	import org.josht.starling.foxhole.themes.AzureTheme;
	import org.josht.starling.foxhole.themes.IFoxholeTheme;
	import org.josht.starling.foxhole.transitions.TabBarSlideTransitionManager;

	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;

	public class DisplayObjectExplorerRoot extends Sprite
	{
		private static const SCALE_9_IMAGE:String = "scale9Image";
		private static const SCALE_3_IMAGE:String = "scale3Image";
		private static const TILED_IMAGE:String = "tiledImage";

		public function DisplayObjectExplorerRoot()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		private var _theme:IFoxholeTheme;
		private var _navigator:ScreenNavigator;
		private var _tabBar:TabBar;
		private var _transitionManager:TabBarSlideTransitionManager;

		private function layout(w:Number, h:Number):void
		{
			this._tabBar.width = w;
			this._tabBar.x = (w - this._tabBar.width) / 2;
			this._tabBar.y = h - this._tabBar.height;
		}

		private function addedToStageHandler(event:Event):void
		{
			this.stage.addEventListener(ResizeEvent.RESIZE, stage_resizeHandler);
			const isDesktop:Boolean = Mouse.supportsCursor;
			this._theme = new AzureTheme(this.stage, !isDesktop);

			//the screens can use the theme's original DPI to scale other
			//content by the same amount with the dpiScale property.
			const originalThemeDPI:int = this._theme.originalDPI;

			this._navigator = new ScreenNavigator();
			this._navigator.onChange.add(navigator_onChange);
			this.addChild(this._navigator);

			this._navigator.addScreen(SCALE_9_IMAGE, new ScreenNavigatorItem(Scale9ImageScreen,
			{
				onTest: SCALE_3_IMAGE
			},
			{
				originalDPI: originalThemeDPI
			}));

			this._navigator.addScreen(SCALE_3_IMAGE, new ScreenNavigatorItem(Scale3ImageScreen,
			{
			},
			{
				originalDPI: originalThemeDPI
			}));

			this._navigator.addScreen(TILED_IMAGE, new ScreenNavigatorItem(TiledImageScreen,
			{
			},
			{
				originalDPI: originalThemeDPI
			}));

			this._tabBar = new TabBar();
			this._tabBar.onChange.add(tabBar_onChange);
			this.addChild(this._tabBar);
			this._tabBar.dataProvider = new ListCollection(
			[
				{ label: "Scale 9", action: SCALE_9_IMAGE },
				{ label: "Scale 3", action: SCALE_3_IMAGE },
				{ label: "Tiled", action: TILED_IMAGE }
			]);
			this._tabBar.validate();
			this.layout(this.stage.stageWidth, this.stage.stageHeight);

			this._navigator.showScreen(SCALE_9_IMAGE);

			this._transitionManager = new TabBarSlideTransitionManager(this._navigator, this._tabBar);
			this._transitionManager.duration = 0.4;
			this._transitionManager.ease = Cubic.easeOut;
		}

		private function navigator_onChange(navigator:ScreenNavigator, activeScreen:DisplayObject):void
		{
			const dataProvider:ListCollection = this._tabBar.dataProvider;
			const itemCount:int = dataProvider.length;
			for(var i:int = 0; i < itemCount; i++)
			{
				var item:Object = dataProvider.getItemAt(i);
				if(navigator.activeScreenID == item.action)
				{
					this._tabBar.selectedIndex = i;
					break;
				}
			}
		}

		private function tabBar_onChange(tabBar:TabBar):void
		{
			this._navigator.showScreen(tabBar.selectedItem.action);
		}

		private function stage_resizeHandler(event:ResizeEvent):void
		{
			this.layout(event.width, event.height);
		}
	}
}
