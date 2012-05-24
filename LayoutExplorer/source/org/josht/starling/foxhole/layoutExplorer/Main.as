package org.josht.starling.foxhole.layoutExplorer
{
	import com.gskinner.motion.easing.Cubic;

	import flash.ui.Mouse;

	import org.josht.starling.foxhole.controls.FPSDisplay;
	import org.josht.starling.foxhole.controls.ScreenNavigator;
	import org.josht.starling.foxhole.controls.ScreenNavigatorItem;
	import org.josht.starling.foxhole.layoutExplorer.data.HorizontalLayoutSettings;
	import org.josht.starling.foxhole.layoutExplorer.data.TiledColumnsLayoutSettings;
	import org.josht.starling.foxhole.layoutExplorer.data.TiledRowsLayoutSettings;
	import org.josht.starling.foxhole.layoutExplorer.data.VerticalLayoutSettings;
	import org.josht.starling.foxhole.layoutExplorer.screens.HorizontalLayoutScreen;
	import org.josht.starling.foxhole.layoutExplorer.screens.HorizontalLayoutSettingsScreen;
	import org.josht.starling.foxhole.layoutExplorer.screens.MainMenuScreen;
	import org.josht.starling.foxhole.layoutExplorer.screens.TiledColumnsLayoutScreen;
	import org.josht.starling.foxhole.layoutExplorer.screens.TiledColumnsLayoutSettingsScreen;
	import org.josht.starling.foxhole.layoutExplorer.screens.TiledRowsLayoutScreen;
	import org.josht.starling.foxhole.layoutExplorer.screens.TiledRowsLayoutSettingsScreen;
	import org.josht.starling.foxhole.layoutExplorer.screens.VerticalLayoutScreen;
	import org.josht.starling.foxhole.layoutExplorer.screens.VerticalLayoutSettingsScreen;
	import org.josht.starling.foxhole.themes.AzureTheme;
	import org.josht.starling.foxhole.themes.IFoxholeTheme;
	import org.josht.starling.foxhole.transitions.ScreenSlidingStackTransitionManager;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;

	public class Main extends Sprite
	{
		private static const MAIN_MENU:String = "mainMenu";
		private static const HORIZONTAL:String = "horizontal";
		private static const VERTICAL:String = "vertical";
		private static const TILED_ROWS:String = "tiledRows";
		private static const TILED_COLUMNS:String = "tiledColumns";
		private static const HORIZONTAL_SETTINGS:String = "horizontalSettings";
		private static const VERTICAL_SETTINGS:String = "verticalSettings";
		private static const TILED_ROWS_SETTINGS:String = "tiledRowsSettings";
		private static const TILED_COLUMNS_SETTINGS:String = "tiledColumnsSettings";

		public function Main()
		{
			super()
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}

		private var _theme:IFoxholeTheme;
		private var _navigator:ScreenNavigator;
		private var _transitionManager:ScreenSlidingStackTransitionManager;
		private var _fps:FPSDisplay;

		private function addedToStageHandler(event:Event):void
		{
			//this is supposed to be an example mobile app, but it is also shown
			//as a preview in Flash Player on the web. we're making a special
			//case to pretend that the web SWF is running in the theme's "ideal"
			//DPI. official themes usually target an iPhone Retina display.
			const isDesktop:Boolean = Mouse.supportsCursor;
			this._theme = new AzureTheme(this.stage, !isDesktop);
			const originalThemeDPI:int = this._theme.originalDPI;

			this._navigator = new ScreenNavigator();
			this.addChild(this._navigator);

			this._navigator.addScreen(MAIN_MENU, new ScreenNavigatorItem(MainMenuScreen,
			{
				onHorizontal: HORIZONTAL,
				onVertical: VERTICAL,
				onTiledRows: TILED_ROWS,
				onTiledColumns: TILED_COLUMNS
			},
			{
				//the screens can use the theme's original DPI to scale other
				//content by the same amount with the dpiScale property.
				originalDPI: originalThemeDPI
			}));

			const horizontalLayoutSettings:HorizontalLayoutSettings = new HorizontalLayoutSettings();
			this._navigator.addScreen(HORIZONTAL, new ScreenNavigatorItem(HorizontalLayoutScreen,
			{
				onBack: MAIN_MENU,
				onSettings: HORIZONTAL_SETTINGS
			},
			{
				settings: horizontalLayoutSettings,
				originalDPI: originalThemeDPI
			}));
			this._navigator.addScreen(HORIZONTAL_SETTINGS, new ScreenNavigatorItem(HorizontalLayoutSettingsScreen,
			{
				onBack: HORIZONTAL
			},
			{
				settings: horizontalLayoutSettings,
				originalDPI: originalThemeDPI
			}));

			const verticalLayoutSettings:VerticalLayoutSettings = new VerticalLayoutSettings();
			this._navigator.addScreen(VERTICAL, new ScreenNavigatorItem(VerticalLayoutScreen,
			{
				onBack: MAIN_MENU,
				onSettings: VERTICAL_SETTINGS
			},
			{
				settings: verticalLayoutSettings,
				originalDPI: originalThemeDPI
			}));
			this._navigator.addScreen(VERTICAL_SETTINGS, new ScreenNavigatorItem(VerticalLayoutSettingsScreen,
			{
				onBack: VERTICAL
			},
			{
				settings: verticalLayoutSettings,
				originalDPI: originalThemeDPI
			}));

			const tiledRowsLayoutSettings:TiledRowsLayoutSettings = new TiledRowsLayoutSettings();
			this._navigator.addScreen(TILED_ROWS, new ScreenNavigatorItem(TiledRowsLayoutScreen,
			{
				onBack: MAIN_MENU,
				onSettings: TILED_ROWS_SETTINGS
			},
			{
				settings: tiledRowsLayoutSettings,
				originalDPI: originalThemeDPI
			}));
			this._navigator.addScreen(TILED_ROWS_SETTINGS, new ScreenNavigatorItem(TiledRowsLayoutSettingsScreen,
			{
				onBack: TILED_ROWS
			},
			{
				settings: tiledRowsLayoutSettings,
				originalDPI: originalThemeDPI
			}));

			const tiledColumnsLayoutSettings:TiledColumnsLayoutSettings = new TiledColumnsLayoutSettings();
			this._navigator.addScreen(TILED_COLUMNS, new ScreenNavigatorItem(TiledColumnsLayoutScreen,
			{
				onBack: MAIN_MENU,
				onSettings: TILED_COLUMNS_SETTINGS
			},
			{
				settings: tiledColumnsLayoutSettings,
				originalDPI: originalThemeDPI
			}));
			this._navigator.addScreen(TILED_COLUMNS_SETTINGS, new ScreenNavigatorItem(TiledColumnsLayoutSettingsScreen,
			{
				onBack: TILED_COLUMNS
			},
			{
				settings: tiledColumnsLayoutSettings,
				originalDPI: originalThemeDPI
			}));

			this._navigator.showScreen(MAIN_MENU);

			this._transitionManager = new ScreenSlidingStackTransitionManager(this._navigator);
			this._transitionManager.duration = 0.4;
			this._transitionManager.ease = Cubic.easeOut;

			this._fps = new FPSDisplay();
			this.stage.addChild(this._fps);
			this._fps.validate();
			this._fps.y = this.stage.stageHeight - this._fps.height;
			this.stage.addEventListener(ResizeEvent.RESIZE, stage_resizeHandler);
		}

		private function stage_resizeHandler(event:ResizeEvent):void
		{
			this._fps.validate();
			this._fps.y = this.stage.stageHeight - this._fps.height;
		}
	}
}
