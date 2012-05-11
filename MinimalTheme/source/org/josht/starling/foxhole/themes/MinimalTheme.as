package org.josht.starling.foxhole.themes
{
	import flash.geom.Rectangle;
	import flash.system.Capabilities;

	import org.josht.starling.display.Image;
	import org.josht.starling.display.Scale9Image;
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.FPSDisplay;
	import org.josht.starling.foxhole.controls.Label;
	import org.josht.starling.foxhole.controls.List;
	import org.josht.starling.foxhole.controls.PickerList;
	import org.josht.starling.foxhole.controls.ProgressBar;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.controls.DefaultItemRenderer;
	import org.josht.starling.foxhole.controls.Slider;
	import org.josht.starling.foxhole.controls.TextInput;
	import org.josht.starling.foxhole.controls.ToggleSwitch;
	import org.josht.starling.foxhole.core.AddedWatcher;
	import org.josht.starling.foxhole.text.BitmapFontTextFormat;
	import org.josht.utils.math.roundToNearest;

	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;

	public class MinimalTheme extends AddedWatcher implements IFoxholeTheme
	{
		[Embed(source="/../assets/images/minimal.png")]
		private static const ATLAS_IMAGE:Class;
		
		[Embed(source="/../assets/images/minimal.xml",mimeType="application/octet-stream")]
		private static const ATLAS_XML:Class;
		
		private static const ATLAS:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new ATLAS_IMAGE(), false), XML(new ATLAS_XML()));

		private static const TOOLBAR_BUTTON_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("toolbar-button-up-skin");

		private static const TOOLBAR_BUTTON_DOWN_SKIN_TEXTURE:Texture = ATLAS.getTexture("toolbar-button-down-skin");

		private static const TOOLBAR_BUTTON_SELECTED_SKIN_TEXTURE:Texture = ATLAS.getTexture("toolbar-button-selected-skin");

		private static const BUTTON_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("button-up-skin");
		
		private static const BUTTON_DOWN_SKIN_TEXTURE:Texture = ATLAS.getTexture("button-down-skin");

		private static const BUTTON_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("button-disabled-skin");
		
		private static const BUTTON_SELECTED_SKIN_TEXTURE:Texture = ATLAS.getTexture("button-selected-skin");

		private static const TAB_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("tab-up-skin");

		private static const TAB_DOWN_SKIN_TEXTURE:Texture = ATLAS.getTexture("tab-down-skin");

		private static const TAB_SELECTED_SKIN_TEXTURE:Texture = ATLAS.getTexture("tab-selected-skin");
		
		private static const THUMB_SKIN_TEXTURE:Texture = ATLAS.getTexture("thumb-skin");
		
		private static const INSET_BACKGROUND_SKIN_TEXTURE:Texture = ATLAS.getTexture("inset-background-skin");

		private static const INSET_BACKGROUND_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("inset-background-disabled-skin");
		
		private static const DROP_DOWN_ARROW_TEXTURE:Texture = ATLAS.getTexture("drop-down-arrow");
		
		private static const LIST_ITEM_UP_TEXTURE:Texture = ATLAS.getTexture("list-item-up");
		
		private static const LIST_ITEM_DOWN_TEXTURE:Texture = ATLAS.getTexture("list-item-down");
		
		private static const LIST_ITEM_SELECTED_TEXTURE:Texture = ATLAS.getTexture("list-item-selected");

		private static const HEADER_SKIN_TEXTURE:Texture = ATLAS.getTexture("header-skin");
		
		[Embed(source="/../assets/fonts/pf_ronda_seven.fnt",mimeType="application/octet-stream")]
		private static const ATLAS_FONT_XML:Class;
		
		private static const BITMAP_FONT:BitmapFont = new BitmapFont(ATLAS.getTexture("pf_ronda_seven_0"), XML(new ATLAS_FONT_XML()));
		
		private static const SCALE_9_GRID:Rectangle = new Rectangle(9, 9, 2, 2);

		private static const TAB_SCALE_9_GRID:Rectangle = new Rectangle(25, 25, 2, 2);

		private static const BACKGROUND_COLOR:uint = 0xf3f3f3;
		private static const PRIMARY_TEXT_COLOR:uint = 0x666666;
		private static const SELECTED_TEXT_COLOR:uint = 0x333333;
		private static const INSET_TEXT_COLOR:uint = 0x333333;

		private static const ORIGINAL_DPI:int = 326;
		
		public function MinimalTheme(root:DisplayObject, scaleToDPI:Boolean = true)
		{
			super(root);
			Starling.current.nativeStage.color = BACKGROUND_COLOR;
			if(root.stage)
			{
				root.stage.color = BACKGROUND_COLOR;
			}
			else
			{
				root.addEventListener(Event.ADDED_TO_STAGE, root_addedToStageHandler);
			}
			this.initialize(scaleToDPI);
		}

		private var _originalDPI:int;

		public function get originalDPI():int
		{
			return this._originalDPI;
		}
		
		private var _scale:Number;
		private var _fontSize:int;
		
		private function initialize(scaleToDPI:Boolean):void
		{
			this._originalDPI = scaleToDPI ? ORIGINAL_DPI : Capabilities.screenDPI;
			this._scale = Capabilities.screenDPI / this._originalDPI;
			
			//since it's a pixel font, we want a multiple of the original size,
			//which, in this case, is 8.
			this._fontSize = Math.max(4, roundToNearest(24 * this._scale, 8));
			
			this.setInitializerForClass(Label, labelInitializer);
			this.setInitializerForClass(FPSDisplay, labelInitializer);
			this.setInitializerForClass(Button, buttonInitializer);
			this.setInitializerForClass(Slider, sliderInitializer);
			this.setInitializerForClass(ToggleSwitch, toggleSwitchInitializer);
			this.setInitializerForClass(DefaultItemRenderer, itemRendererInitializer);
			this.setInitializerForClass(PickerList, pickerListInitializer);
			this.setInitializerForClass(ScreenHeader, screenHeaderInitializer);
			this.setInitializerForClass(TextInput, textInputInitializer);
			this.setInitializerForClass(ProgressBar, progressBarInitializer)
		}
		
		private function labelInitializer(label:Label):void
		{
			label.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			//since it's a pixel font, we don't want to smooth it.
			label.smoothing = TextureSmoothing.NONE;
		}
		
		private function buttonInitializer(button:Button):void
		{
			button.minTouchWidth = button.minTouchHeight = 88 * this._scale;
			if(button.nameList.contains("foxhole-slider-thumb"))
			{
				const sliderThumbDefaultSkin:Scale9Image = new Scale9Image(THUMB_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
				sliderThumbDefaultSkin.width = 66 * this._scale;
				sliderThumbDefaultSkin.height = 66 * this._scale;
				button.defaultSkin = sliderThumbDefaultSkin;
			}
			else if(button.nameList.contains("foxhole-slider-minimum-track") || button.nameList.contains("foxhole-slider-maximum-track"))
			{
				//no skin is defined here. we're taking care of these based on
				//the slider's direction.
			}
			else if(button.nameList.contains("foxhole-toggle-switch-thumb"))
			{
				const toggleSwitchThumbDefaultSkin:Scale9Image = new Scale9Image(THUMB_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
				toggleSwitchThumbDefaultSkin.width = 66 * this._scale;
				toggleSwitchThumbDefaultSkin.height = 66 * this._scale;
				button.defaultSkin = toggleSwitchThumbDefaultSkin;
			}
			else if(button.nameList.contains("foxhole-tabbar-tab"))
			{
				const tabDefaultSkin:Scale9Image = new Scale9Image(TAB_UP_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
				tabDefaultSkin.width = 88 * this._scale;
				tabDefaultSkin.height = 88 * this._scale;
				tabDefaultSkin.blendMode = BlendMode.NONE;
				button.defaultSkin = tabDefaultSkin;

				const tabDownSkin:Scale9Image = new Scale9Image(TAB_DOWN_SKIN_TEXTURE, TAB_SCALE_9_GRID, this._scale);
				tabDownSkin.width = 88 * this._scale;
				tabDownSkin.height = 88 * this._scale;
				tabDownSkin.blendMode = BlendMode.NONE;
				button.downSkin = tabDownSkin;

				const tabDefaultSelectedSkin:Scale9Image = new Scale9Image(TAB_SELECTED_SKIN_TEXTURE, TAB_SCALE_9_GRID, this._scale);
				tabDefaultSelectedSkin.width = 88 * this._scale;
				tabDefaultSelectedSkin.height = 88 * this._scale;
				tabDefaultSelectedSkin.blendMode = BlendMode.NONE;
				button.defaultSelectedSkin = tabDefaultSelectedSkin;

				button.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
				button.defaultSelectedTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);

				button.iconPosition = Button.ICON_POSITION_TOP;
				button.paddingTop = button.paddingRight = button.paddingBottom =
					button.paddingLeft = 28 * this._scale;
				button.gap = 12 * this._scale;
				button.minWidth = 88 * this._scale;
				button.minHeight = 88 * this._scale;
			}
			else if(button.nameList.contains("foxhole-header-item"))
			{
				const toolbarDefaultSkin:Scale9Image = new Scale9Image(TOOLBAR_BUTTON_UP_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
				toolbarDefaultSkin.width = 60 * this._scale;
				toolbarDefaultSkin.height = 60 * this._scale;
				button.defaultSkin = toolbarDefaultSkin;

				const toolbarDownSkin:Scale9Image = new Scale9Image(TOOLBAR_BUTTON_DOWN_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
				toolbarDownSkin.width = 60 * this._scale;
				toolbarDownSkin.height = 60 * this._scale;
				button.downSkin = toolbarDownSkin;

				const toolbarDefaultSelectedSkin:Scale9Image = new Scale9Image(TOOLBAR_BUTTON_SELECTED_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
				toolbarDefaultSelectedSkin.width = 60 * this._scale;
				toolbarDefaultSelectedSkin.height = 60 * this._scale;
				button.defaultSelectedSkin = toolbarDefaultSelectedSkin;

				button.selectedDownSkin = toolbarDownSkin;

				button.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
				button.defaultSelectedTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);

				button.paddingTop = button.paddingBottom = 8 * this._scale;
				button.paddingLeft = button.paddingRight = 16 * this._scale;
				button.gap = 12 * this._scale;
				button.minWidth = 60 * this._scale;
				button.minHeight = 60 * this._scale;
			}
			else
			{
				const defaultSkin:Scale9Image = new Scale9Image(BUTTON_UP_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
				defaultSkin.width = 66 * this._scale;
				defaultSkin.height = 66 * this._scale;
				defaultSkin.blendMode = BlendMode.NONE;
				button.defaultSkin = defaultSkin;

				const downSkin:Scale9Image = new Scale9Image(BUTTON_DOWN_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
				downSkin.width = 66 * this._scale;
				downSkin.height = 66 * this._scale;
				downSkin.blendMode = BlendMode.NONE;
				button.downSkin = downSkin;

				const disabledSkin:Scale9Image = new Scale9Image(BUTTON_DISABLED_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
				disabledSkin.width = 66 * this._scale;
				disabledSkin.height = 66 * this._scale;
				disabledSkin.blendMode = BlendMode.NONE;
				button.disabledSkin = disabledSkin;

				const defaultSelectedSkin:Scale9Image = new Scale9Image(BUTTON_SELECTED_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
				defaultSelectedSkin.width = 66 * this._scale;
				defaultSelectedSkin.height = 66 * this._scale;
				defaultSelectedSkin.blendMode = BlendMode.NONE;
				button.defaultSelectedSkin = defaultSelectedSkin;

				button.selectedDownSkin = downSkin;

				button.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
				button.defaultSelectedTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);

				button.paddingTop = button.paddingBottom = 8 * this._scale;
				button.paddingLeft = button.paddingRight = 16 * this._scale;
				button.gap = 12 * this._scale;
				button.minWidth = 66 * this._scale;
				button.minHeight = 66 * this._scale;
			}

			//we're tweaking the normal button styles
			if(button.nameList.contains("foxhole-pickerlist-button"))
			{
				const pickerListButtonDefaultIcon:Image = new Image(DROP_DOWN_ARROW_TEXTURE);
				pickerListButtonDefaultIcon.scaleX = pickerListButtonDefaultIcon.scaleY = this._scale;
				button.defaultIcon = pickerListButtonDefaultIcon;
				button.gap = Number.POSITIVE_INFINITY, //fill as completely as possible
				button.iconPosition = Button.ICON_POSITION_RIGHT;
				button.horizontalAlign =  Button.HORIZONTAL_ALIGN_LEFT;
			}
		}

		private function sliderInitializer(slider:Slider):void
		{
			slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_SINGLE;

			const sliderTrackDefaultSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
			sliderTrackDefaultSkin.blendMode = BlendMode.NONE;
			if(slider.direction == Slider.DIRECTION_VERTICAL)
			{
				sliderTrackDefaultSkin.width = 66 * this._scale;
				sliderTrackDefaultSkin.height = 198 * this._scale;
			}
			else //horizontal
			{
				sliderTrackDefaultSkin.width = 198 * this._scale;
				sliderTrackDefaultSkin.height = 66 * this._scale;
			}
			slider.setMinimumTrackProperty("defaultSkin", sliderTrackDefaultSkin);
		}
		
		private function toggleSwitchInitializer(toggleSwitch:ToggleSwitch):void
		{
			toggleSwitch.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_SINGLE;

			const trackSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
			trackSkin.width = 132 * this._scale;
			trackSkin.height = 66 * this._scale;
			trackSkin.blendMode = BlendMode.NONE;
			toggleSwitch.onTrackSkin = trackSkin;
			
			toggleSwitch.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			toggleSwitch.onTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);
		}
		
		private function itemRendererInitializer(renderer:DefaultItemRenderer):void
		{
			const defaultSkin:Image = new Image(LIST_ITEM_UP_TEXTURE);
			//no smoothing. it's a solid color and we'll be stretching it
			//quite a bit
			defaultSkin.smoothing = TextureSmoothing.NONE;
			defaultSkin.width = 88 * this._scale;
			defaultSkin.height = 88 * this._scale;
			defaultSkin.blendMode = BlendMode.NONE;
			renderer.defaultSkin = defaultSkin;
			
			const downSkin:Image = new Image(LIST_ITEM_DOWN_TEXTURE);
			downSkin.smoothing = TextureSmoothing.NONE;
			downSkin.width = 88 * this._scale;
			downSkin.height = 88 * this._scale;
			downSkin.blendMode = BlendMode.NONE;
			renderer.downSkin = downSkin;
			
			const defaultSelectedSkin:Image = new Image(LIST_ITEM_SELECTED_TEXTURE);
			defaultSelectedSkin.smoothing = TextureSmoothing.NONE;
			defaultSelectedSkin.width = 88 * this._scale;
			defaultSelectedSkin.height = 88 * this._scale;
			defaultSelectedSkin.blendMode = BlendMode.NONE;
			renderer.defaultSelectedSkin = defaultSelectedSkin;

			renderer.paddingTop = renderer.paddingRight = renderer.paddingBottom =
				renderer.paddingLeft = 20 * this._scale;
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.minWidth = renderer.minHeight = 88 * this._scale;
		}
		
		private function pickerListInitializer(list:PickerList):void
		{
			list.listProperties =
			{
				verticalAlign: List.VERTICAL_ALIGN_BOTTOM,
				clipContent: true
			}
		}

		private function screenHeaderInitializer(header:ScreenHeader):void
		{
			header.minWidth = 88 * this._scale;
			header.minHeight = 88 * this._scale;
			header.paddingTop = header.paddingRight = header.paddingBottom =
				header.paddingLeft = 14 * this._scale;
			const backgroundSkin:Scale9Image = new Scale9Image(HEADER_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
			backgroundSkin.width = 88 * this._scale;
			backgroundSkin.height = 88 * this._scale;
			backgroundSkin.blendMode = BlendMode.NONE;
			header.backgroundSkin = backgroundSkin;
			header.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
		}

		private function textInputInitializer(input:TextInput):void
		{
			input.minWidth = 88 * this._scale;
			input.minHeight = 88 * this._scale;
			input.paddingTop = input.paddingRight = input.paddingBottom =
				input.paddingLeft = 22 * this._scale;
			input.stageTextProperties =
			{
				fontFamily: "Helvetica",
				fontSize: 36 * this._scale,
				color: INSET_TEXT_COLOR
			};

			const backgroundSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
			backgroundSkin.width = 264 * this._scale;
			backgroundSkin.height = 88 * this._scale;
			input.backgroundSkin = backgroundSkin;

			const backgroundDisabledSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_DISABLED_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
			backgroundDisabledSkin.width = 264 * this._scale;
			backgroundDisabledSkin.height = 88 * this._scale;
			input.backgroundDisabledSkin = backgroundDisabledSkin;
		}

		private function progressBarInitializer(progress:ProgressBar):void
		{
			const backgroundSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
			backgroundSkin.width = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 264 : 22) * this._scale;
			backgroundSkin.height = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 22 : 264) * this._scale;
			backgroundSkin.blendMode = BlendMode.NONE;
			progress.backgroundSkin = backgroundSkin;

			const backgroundDisabledSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_DISABLED_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
			backgroundDisabledSkin.width = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 264 : 22) * this._scale;
			backgroundDisabledSkin.height = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 22 : 264) * this._scale;
			backgroundDisabledSkin.blendMode = BlendMode.NONE;
			progress.backgroundDisabledSkin = backgroundDisabledSkin;

			const fillSkin:Scale9Image = new Scale9Image(BUTTON_UP_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
			fillSkin.width = 12 * this._scale;
			fillSkin.height = 12 * this._scale;
			fillSkin.blendMode = BlendMode.NONE;
			progress.fillSkin = fillSkin;

			const fillDisabledSkin:Scale9Image = new Scale9Image(BUTTON_DISABLED_SKIN_TEXTURE, SCALE_9_GRID, this._scale);
			fillDisabledSkin.width = 12 * this._scale;
			fillDisabledSkin.height = 12 * this._scale;
			fillDisabledSkin.blendMode = BlendMode.NONE;
			progress.fillDisabledSkin = fillDisabledSkin;
		}

		private function root_addedToStageHandler(event:Event):void
		{
			DisplayObject(event.currentTarget).stage.color = BACKGROUND_COLOR;
		}
	}
}