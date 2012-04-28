package org.josht.starling.foxhole.kitchenSink
{
	import com.gskinner.motion.easing.Cubic;

	import flash.ui.Mouse;

	import org.josht.starling.foxhole.controls.FPSDisplay;
	import org.josht.starling.foxhole.controls.ScreenNavigator;
	import org.josht.starling.foxhole.controls.ScreenNavigatorItem;
	import org.josht.starling.foxhole.kitchenSink.screens.ButtonScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.ListScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.MainMenuScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.PickerListScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.ProgressBarScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.SliderScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.TextInputScreen;
	import org.josht.starling.foxhole.kitchenSink.screens.ToggleSwitchScreen;
	import org.josht.starling.foxhole.themes.IFoxholeTheme;
	import org.josht.starling.foxhole.themes.MinimalTheme;
	import org.josht.starling.foxhole.transitions.ScreenSlidingStackTransitionManager;

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;

	public class KitchenSinkRoot extends Sprite
	{
		private static const MAIN_MENU:String = "mainMenu";
		private static const BUTTON:String = "button";
		private static const LIST:String = "list";
		private static const PICKER_LIST:String = "pickerList";
		private static const PROGRESS_BAR:String = "progressBar";
		private static const SLIDER:String = "slider";
		private static const TEXT_INPUT:String = "textInput";
		private static const TOGGLE_SWITCH:String = "toggleSwitch";
		
		public function KitchenSinkRoot()
		{
			super();
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
			this._theme = new MinimalTheme(this.stage, !isDesktop);
			const originalThemeDPI:int = this._theme.originalDPI;
			
			this._navigator = new ScreenNavigator();
			this.addChild(this._navigator);
			
			this._navigator.addScreen(MAIN_MENU, new ScreenNavigatorItem(MainMenuScreen,
			{
				onButton: BUTTON,
				onList: LIST,
				onPickerList: PICKER_LIST,
				onProgressBar: PROGRESS_BAR,
				onSlider: SLIDER,
				onTextInput: TEXT_INPUT,
				onToggleSwitch: TOGGLE_SWITCH
			},
			{
				//the screens can use the theme's original DPI to scale other
				//content by the same amount with the dpiScale property.
				originalDPI: originalThemeDPI
			}));
			
			this._navigator.addScreen(BUTTON, new ScreenNavigatorItem(ButtonScreen,
			{
				onBack: MAIN_MENU
			},
			{
				originalDPI: originalThemeDPI
			}));
			
			this._navigator.addScreen(SLIDER, new ScreenNavigatorItem(SliderScreen,
			{
				onBack: MAIN_MENU
			},
			{
				originalDPI: originalThemeDPI
			}));
			
			this._navigator.addScreen(TOGGLE_SWITCH, new ScreenNavigatorItem(ToggleSwitchScreen,
			{
				onBack: MAIN_MENU
			},
			{
				originalDPI: originalThemeDPI
			}));
			
			this._navigator.addScreen(LIST, new ScreenNavigatorItem(ListScreen,
			{
				onBack: MAIN_MENU
			},
			{
				originalDPI: originalThemeDPI
			}));
			
			this._navigator.addScreen(PICKER_LIST, new ScreenNavigatorItem(PickerListScreen,
			{
				onBack: MAIN_MENU
			},
			{
				originalDPI: originalThemeDPI
			}));

			this._navigator.addScreen(TEXT_INPUT, new ScreenNavigatorItem(TextInputScreen,
			{
				onBack: MAIN_MENU
			},
			{
				originalDPI: originalThemeDPI
			}));

			this._navigator.addScreen(PROGRESS_BAR, new ScreenNavigatorItem(ProgressBarScreen,
			{
				onBack: MAIN_MENU
			},
			{
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