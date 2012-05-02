package org.josht.starling.foxhole.themes
{
	import flash.geom.Rectangle;
	import flash.system.Capabilities;

	import org.josht.starling.display.Image;
	import org.josht.starling.display.Scale3Image;
	import org.josht.starling.display.Scale9Image;
	import org.josht.starling.foxhole.controls.Button;
	import org.josht.starling.foxhole.controls.FPSDisplay;
	import org.josht.starling.foxhole.controls.Label;
	import org.josht.starling.foxhole.controls.List;
	import org.josht.starling.foxhole.controls.PickerList;
	import org.josht.starling.foxhole.controls.ProgressBar;
	import org.josht.starling.foxhole.controls.ScreenHeader;
	import org.josht.starling.foxhole.controls.SimpleItemRenderer;
	import org.josht.starling.foxhole.controls.Slider;
	import org.josht.starling.foxhole.controls.TextInput;
	import org.josht.starling.foxhole.controls.ToggleSwitch;
	import org.josht.starling.foxhole.core.AddedWatcher;
	import org.josht.starling.foxhole.text.BitmapFontTextFormat;
	import org.josht.starling.text.BitmapFont;

	import starling.core.Starling;
	import starling.display.BlendMode;

	import starling.display.DisplayObject;

	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class AzureTheme extends AddedWatcher implements IFoxholeTheme
	{
		[Embed(source="/../assets/images/azure.png")]
		private static const ATLAS_IMAGE:Class;

		[Embed(source="/../assets/images/azure.xml",mimeType="application/octet-stream")]
		private static const ATLAS_XML:Class;

		private static const ATLAS:TextureAtlas = new TextureAtlas(Texture.fromBitmap(new ATLAS_IMAGE(), false), XML(new ATLAS_XML()));

		private static const BUTTON_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("button-up-skin");

		private static const BUTTON_DOWN_SKIN_TEXTURE:Texture = ATLAS.getTexture("button-down-skin");

		private static const BUTTON_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("button-disabled-skin");

		private static const TOOLBAR_BUTTON_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("toolbar-button-up-skin");

		private static const TOOLBAR_BUTTON_DOWN_SKIN_TEXTURE:Texture = ATLAS.getTexture("toolbar-button-down-skin");

		private static const TOOLBAR_BUTTON_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("toolbar-button-disabled-skin");

		private static const SLIDER_MINIMUM_TRACK_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("slider-minimum-track-up-skin");

		private static const SLIDER_MINIMUM_TRACK_DOWN_SKIN_TEXTURE:Texture = ATLAS.getTexture("slider-minimum-track-down-skin");

		private static const SLIDER_MINIMUM_TRACK_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("slider-minimum-track-disabled-skin");

		private static const SLIDER_MAXIMUM_TRACK_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("slider-maximum-track-up-skin");

		private static const SLIDER_MAXIMUM_TRACK_DOWN_SKIN_TEXTURE:Texture = ATLAS.getTexture("slider-maximum-track-down-skin");

		private static const SLIDER_MAXIMUM_TRACK_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("slider-maximum-track-disabled-skin");

		private static const SLIDER_THUMB_UP_SKIN_TEXTURE:Texture = ATLAS.getTexture("slider-thumb-up-skin");

		private static const SLIDER_THUMB_DOWN_SKIN_TEXTURE:Texture = ATLAS.getTexture("slider-thumb-down-skin");

		private static const SLIDER_THUMB_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("slider-thumb-disabled-skin");

		private static const PROGRESS_BAR_BACKGROUND_SKIN_TEXTURE:Texture = ATLAS.getTexture("progress-bar-background-skin");

		private static const PROGRESS_BAR_BACKGROUND_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("progress-bar-background-disabled-skin");

		private static const PROGRESS_BAR_FILL_SKIN_TEXTURE:Texture = ATLAS.getTexture("progress-bar-fill-skin");

		private static const PROGRESS_BAR_FILL_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("progress-bar-fill-disabled-skin");

		private static const INSET_BACKGROUND_SKIN_TEXTURE:Texture = ATLAS.getTexture("inset-skin");

		private static const INSET_BACKGROUND_DISABLED_SKIN_TEXTURE:Texture = ATLAS.getTexture("inset-disabled-skin");

		private static const INSET_BACKGROUND_LEFT_TEXTURE:Texture = ATLAS.getTexture("inset-left");

		private static const INSET_BACKGROUND_RIGHT_TEXTURE:Texture = ATLAS.getTexture("inset-right");

		private static const PICKER_ICON_TEXTURE:Texture = ATLAS.getTexture("picker-icon");

		private static const LIST_ITEM_UP_TEXTURE:Texture = ATLAS.getTexture("list-item-up-skin");

		private static const LIST_ITEM_DOWN_TEXTURE:Texture = ATLAS.getTexture("list-item-down-skin");

		private static const TOOLBAR_BACKGROUND_SKIN_TEXTURE:Texture = ATLAS.getTexture("toolbar-background-skin");

		private static const TAB_SELECTED_SKIN_TEXTURE:Texture = ATLAS.getTexture("tab-selected-skin");

		[Embed(source="/../assets/fonts/lato30.fnt",mimeType="application/octet-stream")]
		private static const ATLAS_FONT_XML:Class;

		private static const BITMAP_FONT:BitmapFont = new BitmapFont(ATLAS.getTexture("lato30_0"), XML(new ATLAS_FONT_XML()));

		private static const PROGRESS_BAR_SCALE_3_FIRST_REGION:Number = 12;
		private static const PROGRESS_BAR_SCALE_3_SECOND_REGION:Number = 12;
		private static const BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(8, 8, 15, 71);
		private static const TOOLBAR_BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(22, 22, 15, 71);
		private static const INSET_LEFT_SCALE_9_GRID:Rectangle = new Rectangle(8, 8, 8, 71);
		private static const INSET_RIGHT_SCALE_9_GRID:Rectangle = new Rectangle(0, 8, 8, 71);
		private static const SLIDER_FIRST:Number = 16;
		private static const SLIDER_SECOND:Number = 8;

		private static const BACKGROUND_COLOR:uint = 0x13171a;
		private static const PRIMARY_TEXT_COLOR:uint = 0xe5e5e5;
		private static const SELECTED_TEXT_COLOR:uint = 0xffffff;

		private static const ORIGINAL_DPI:int = 326;

		public function AzureTheme(root:DisplayObject, scaleToDPI:Boolean = true)
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

			this._fontSize = 30 * this._scale;

			this.setInitializerForClass(Label, labelInitializer);
			this.setInitializerForClass(FPSDisplay, labelInitializer);
			this.setInitializerForClass(Button, buttonInitializer);
			this.setInitializerForClass(Slider, sliderInitializer)
			this.setInitializerForClass(ToggleSwitch, toggleSwitchInitializer);
			this.setInitializerForClass(SimpleItemRenderer, itemRendererInitializer);
			this.setInitializerForClass(PickerList, pickerListInitializer);
			this.setInitializerForClass(ScreenHeader, screenHeaderInitializer);
			this.setInitializerForClass(TextInput, textInputInitializer);
			this.setInitializerForClass(ProgressBar, progressBarInitializer);
		}

		private function labelInitializer(label:Label):void
		{
			if(label.name)
			{
				return;
			}
			label.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
		}

		private function buttonInitializer(button:Button):void
		{
			if(button.nameList.contains("foxhole-tabbar-tab"))
			{
				const tabDefaultSkin:Image = new Image(TOOLBAR_BACKGROUND_SKIN_TEXTURE);
				tabDefaultSkin.width = 88 * this._scale;
				tabDefaultSkin.height = 88 * this._scale;
				button.defaultSkin = tabDefaultSkin;
				const tabDefaultSelectedSkin:Image = new Image(TAB_SELECTED_SKIN_TEXTURE);
				tabDefaultSelectedSkin.width = 88 * this._scale;
				tabDefaultSelectedSkin.height = 88 * this._scale;
				button.defaultSelectedSkin = tabDefaultSelectedSkin;
				button.downSkin = tabDefaultSelectedSkin;

				button.minWidth = 88 * this._scale;
				button.minHeight = 88 * this._scale;
				button.contentPadding = 16 * this._scale;
				button.gap = 12 * this._scale;
				button.iconPosition = Button.ICON_POSITION_TOP;

				button.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
				button.defaultSelectedTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);
			}
			else if(button.nameList.contains("foxhole-header-item"))
			{
				const toolbarDefaultSkin:Scale9Image = new Scale9Image(TOOLBAR_BUTTON_UP_SKIN_TEXTURE, TOOLBAR_BUTTON_SCALE_9_GRID, this._scale);
				toolbarDefaultSkin.width = 88 * this._scale;
				toolbarDefaultSkin.height = 88 * this._scale;
				button.defaultSkin = toolbarDefaultSkin;

				const toolbarDownSkin:Scale9Image = new Scale9Image(TOOLBAR_BUTTON_DOWN_SKIN_TEXTURE, TOOLBAR_BUTTON_SCALE_9_GRID, this._scale);
				toolbarDownSkin.width = 88 * this._scale;
				toolbarDownSkin.height = 88 * this._scale;
				button.downSkin = toolbarDownSkin;

				const toolbarDisabledSkin:Scale9Image = new Scale9Image(TOOLBAR_BUTTON_DISABLED_SKIN_TEXTURE, TOOLBAR_BUTTON_SCALE_9_GRID, this._scale);
				toolbarDisabledSkin.width = 88 * this._scale;
				toolbarDisabledSkin.height = 88 * this._scale;
				button.disabledSkin = toolbarDisabledSkin;

				button.defaultSelectedSkin = toolbarDownSkin;
				button.selectedDownSkin = toolbarDownSkin;

				button.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
				button.defaultSelectedTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);

				button.contentPadding = 30 * this._scale;
				button.gap = 12 * this._scale;
				button.minWidth = 88 * this._scale;
				button.minHeight = 88 * this._scale;
			}
			else if(button.nameList.contains("foxhole-slider-thumb"))
			{
				const sliderThumbDefaultSkin:Image = new Image(SLIDER_THUMB_UP_SKIN_TEXTURE);
				sliderThumbDefaultSkin.width = 88 * this._scale;
				sliderThumbDefaultSkin.height = 88 * this._scale;
				button.defaultSkin = sliderThumbDefaultSkin;
				const sliderThumbDownSkin:Image = new Image(SLIDER_THUMB_DOWN_SKIN_TEXTURE);
				button.downSkin = sliderThumbDownSkin;
				const sliderThumbDisabledSkin:Image = new Image(SLIDER_THUMB_DISABLED_SKIN_TEXTURE);
				button.disabledSkin = sliderThumbDisabledSkin;
			}
			else if(button.nameList.contains("foxhole-slider-minimum-track") || button.nameList.contains("foxhole-slider-maximum-track"))
			{
				//do nothing. we're skinning them based on slider direction
			}
			else
			{
				const defaultSkin:Scale9Image = new Scale9Image(BUTTON_UP_SKIN_TEXTURE, BUTTON_SCALE_9_GRID, this._scale);
				defaultSkin.width = 88 * this._scale;
				defaultSkin.height = 88 * this._scale;
				button.defaultSkin = defaultSkin;

				const downSkin:Scale9Image = new Scale9Image(BUTTON_DOWN_SKIN_TEXTURE, BUTTON_SCALE_9_GRID, this._scale);
				downSkin.width = 88 * this._scale;
				downSkin.height = 88 * this._scale;
				button.downSkin = downSkin;

				const disabledSkin:Scale9Image = new Scale9Image(BUTTON_DISABLED_SKIN_TEXTURE, BUTTON_SCALE_9_GRID, this._scale);
				disabledSkin.width = 88 * this._scale;
				disabledSkin.height = 88 * this._scale;
				button.defaultSelectedSkin = disabledSkin;

				button.defaultSelectedSkin = downSkin;

				button.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
				button.defaultSelectedTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);

				button.contentPadding = 16 * this._scale;
				button.gap = 12 * this._scale;
				button.minWidth = 88 * this._scale;
				button.minHeight = 88 * this._scale;
			}

			//styles for the pickerlist button come from above, and then we're
			//adding a little bit extra.
			if(button.nameList.contains("foxhole-pickerlist-button"))
			{
				const pickerListButtonDefaultIcon:Image = new Image(PICKER_ICON_TEXTURE);
				pickerListButtonDefaultIcon.scaleX = pickerListButtonDefaultIcon.scaleY = this._scale;
				button.defaultIcon = pickerListButtonDefaultIcon
				button.gap = Number.POSITIVE_INFINITY; //fill as completely as possible
				button.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
				button.iconPosition = Button.ICON_POSITION_RIGHT;
			}
		}

		private function sliderInitializer(slider:Slider):void
		{
			slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_STRETCH;
			if(slider.direction == Slider.DIRECTION_VERTICAL)
			{
				throw new Error("Skin not available yet.");
			}
			else //horizontal
			{
				var sliderMinimumTrackDefaultSkin:Scale3Image = new Scale3Image(SLIDER_MINIMUM_TRACK_UP_SKIN_TEXTURE, SLIDER_FIRST, SLIDER_SECOND, Scale3Image.DIRECTION_HORIZONTAL, this._scale);
				sliderMinimumTrackDefaultSkin.width = 220 * this._scale;
				sliderMinimumTrackDefaultSkin.height = 88 * this._scale;
				var sliderMinimumTrackDownSkin:Scale3Image = new Scale3Image(SLIDER_MINIMUM_TRACK_DOWN_SKIN_TEXTURE, SLIDER_FIRST, SLIDER_SECOND, Scale3Image.DIRECTION_HORIZONTAL, this._scale);
				sliderMinimumTrackDefaultSkin.width = 220 * this._scale;
				sliderMinimumTrackDefaultSkin.height = 88 * this._scale;
				var sliderMinimumTrackDisabledSkin:Scale3Image = new Scale3Image(SLIDER_MINIMUM_TRACK_DISABLED_SKIN_TEXTURE, SLIDER_FIRST, SLIDER_SECOND, Scale3Image.DIRECTION_HORIZONTAL, this._scale);
				sliderMinimumTrackDefaultSkin.width = 220 * this._scale;
				sliderMinimumTrackDefaultSkin.height = 88 * this._scale;
				slider.setMinimumTrackProperty("defaultSkin", sliderMinimumTrackDefaultSkin);
				slider.setMinimumTrackProperty("downSkin", sliderMinimumTrackDownSkin);
				slider.setMinimumTrackProperty("disabledSkin", sliderMinimumTrackDisabledSkin);

				var sliderMaximumTrackDefaultSkin:Scale3Image = new Scale3Image(SLIDER_MAXIMUM_TRACK_UP_SKIN_TEXTURE, 0, SLIDER_SECOND, Scale3Image.DIRECTION_HORIZONTAL, this._scale);
				sliderMaximumTrackDefaultSkin.width = 220 * this._scale;
				sliderMaximumTrackDefaultSkin.height = 88 * this._scale;
				var sliderMaximumTrackDownSkin:Scale3Image = new Scale3Image(SLIDER_MAXIMUM_TRACK_DOWN_SKIN_TEXTURE, 0, SLIDER_SECOND, Scale3Image.DIRECTION_HORIZONTAL, this._scale);
				sliderMaximumTrackDownSkin.width = 220 * this._scale;
				sliderMaximumTrackDownSkin.height = 88 * this._scale;
				var sliderMaximumTrackDisabledSkin:Scale3Image = new Scale3Image(SLIDER_MAXIMUM_TRACK_DISABLED_SKIN_TEXTURE, SLIDER_FIRST, SLIDER_SECOND, Scale3Image.DIRECTION_HORIZONTAL, this._scale);
				sliderMaximumTrackDisabledSkin.width = 220 * this._scale;
				sliderMaximumTrackDisabledSkin.height = 88 * this._scale;

				slider.setMaximumTrackProperty("defaultSkin", sliderMaximumTrackDefaultSkin);
				slider.setMaximumTrackProperty("downSkin", sliderMaximumTrackDownSkin);
				slider.setMaximumTrackProperty("disabledSkin", sliderMaximumTrackDisabledSkin);
			}
		}

		private function toggleSwitchInitializer(toggleSwitch:ToggleSwitch):void
		{
			const onSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_LEFT_TEXTURE, INSET_LEFT_SCALE_9_GRID, this._scale);
			onSkin.width = 132 * this._scale;
			onSkin.height = 88 * this._scale;
			toggleSwitch.onTrackSkin = onSkin;

			const offSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_RIGHT_TEXTURE, INSET_RIGHT_SCALE_9_GRID, this._scale);
			offSkin.width = 132 * this._scale;
			offSkin.height = 88 * this._scale;
			toggleSwitch.offTrackSkin = offSkin;

			toggleSwitch.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_STRETCH;

			toggleSwitch.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			toggleSwitch.onTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, SELECTED_TEXT_COLOR);
		}

		private function itemRendererInitializer(renderer:SimpleItemRenderer):void
		{
			const defaultSkin:Image = new Image(LIST_ITEM_UP_TEXTURE);
			defaultSkin.width = 88 * this._scale;
			defaultSkin.height = 88 * this._scale;
			defaultSkin.blendMode = BlendMode.NONE;
			renderer.defaultSkin = defaultSkin;

			const downSkin:Image = new Image(LIST_ITEM_DOWN_TEXTURE);
			downSkin.width = 88 * this._scale;
			downSkin.height = 88 * this._scale;
			downSkin.blendMode = BlendMode.NONE;
			renderer.downSkin = downSkin;

			renderer.defaultSelectedSkin = downSkin;

			renderer.contentPadding = 20 * this._scale;
			renderer.minWidth = 88 * this._scale;
			renderer.minHeight = 88 * this._scale;

			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;

			renderer.defaultTextFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
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
			const backgroundSkin:Image = new Image(TOOLBAR_BACKGROUND_SKIN_TEXTURE);
			backgroundSkin.width = 88 * this._scale;
			backgroundSkin.height = 88 * this._scale;
			backgroundSkin.blendMode = BlendMode.NONE;
			header.backgroundSkin = backgroundSkin;
			header.textFormat = new BitmapFontTextFormat(BITMAP_FONT, this._fontSize, PRIMARY_TEXT_COLOR);
			header.contentPadding = 0;
			header.minHeight = 88 * this._scale;
		}

		private function textInputInitializer(input:TextInput):void
		{
			input.minWidth = 88 * this._scale;
			input.minHeight = 88 * this._scale;
			input.contentPadding = 22 * this._scale;
			input.stageTextProperties =
			{
				fontFamily: "Helvetica",
				fontSize: 36 * this._scale,
				color: 0xffffff
			};

			const backgroundSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_SKIN_TEXTURE, BUTTON_SCALE_9_GRID, this._scale);
			backgroundSkin.width = 264 * this._scale;
			backgroundSkin.height = 88 * this._scale;
			input.backgroundSkin = backgroundSkin;

			const backgroundDisabledSkin:Scale9Image = new Scale9Image(INSET_BACKGROUND_DISABLED_SKIN_TEXTURE, BUTTON_SCALE_9_GRID, this._scale);
			backgroundDisabledSkin.width = 264 * this._scale;
			backgroundDisabledSkin.height = 88 * this._scale;
			input.backgroundDisabledSkin = backgroundDisabledSkin;
		}

		private function progressBarInitializer(progress:ProgressBar):void
		{
			const backgroundSkin:Scale3Image = new Scale3Image(PROGRESS_BAR_BACKGROUND_SKIN_TEXTURE, PROGRESS_BAR_SCALE_3_FIRST_REGION, PROGRESS_BAR_SCALE_3_SECOND_REGION, progress.direction, this._scale);
			backgroundSkin.width = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 264 : 24) * this._scale;
			backgroundSkin.height = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 24 : 264) * this._scale;
			progress.backgroundSkin = backgroundSkin;

			const backgroundDisabledSkin:Scale3Image = new Scale3Image(PROGRESS_BAR_BACKGROUND_DISABLED_SKIN_TEXTURE, PROGRESS_BAR_SCALE_3_FIRST_REGION, PROGRESS_BAR_SCALE_3_SECOND_REGION, progress.direction, this._scale);
			backgroundDisabledSkin.width = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 264 : 24) * this._scale;
			backgroundDisabledSkin.height = (progress.direction == ProgressBar.DIRECTION_HORIZONTAL ? 24 : 264) * this._scale;
			progress.backgroundDisabledSkin = backgroundDisabledSkin;

			const fillSkin:Scale3Image = new Scale3Image(PROGRESS_BAR_FILL_SKIN_TEXTURE, PROGRESS_BAR_SCALE_3_FIRST_REGION, PROGRESS_BAR_SCALE_3_SECOND_REGION, progress.direction, this._scale);
			fillSkin.width = 24 * this._scale;
			fillSkin.height = 24 * this._scale;
			progress.fillSkin = fillSkin;

			const fillDisabledSkin:Scale3Image = new Scale3Image(PROGRESS_BAR_FILL_DISABLED_SKIN_TEXTURE, PROGRESS_BAR_SCALE_3_FIRST_REGION, PROGRESS_BAR_SCALE_3_SECOND_REGION, progress.direction, this._scale);
			fillDisabledSkin.width = 24 * this._scale;
			fillDisabledSkin.height = 24 * this._scale;
			progress.fillDisabledSkin = fillDisabledSkin;
		}

		private function root_addedToStageHandler(event:Event):void
		{
			DisplayObject(event.currentTarget).stage.color = BACKGROUND_COLOR;
		}

	}
}