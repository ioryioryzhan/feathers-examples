package org.josht.starling.foxhole.gallery
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;

	import org.josht.starling.foxhole.controls.List;
	import org.josht.starling.foxhole.controls.renderers.IListItemRenderer;
	import org.josht.starling.foxhole.core.FoxholeControl;
	import org.osflash.signals.ISignal;
	import org.osflash.signals.Signal;

	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class GalleryItemRenderer extends FoxholeControl implements IListItemRenderer
	{
		/**
		 * @private
		 */
		private static const LOADER_CONTEXT:LoaderContext = new LoaderContext(true);

		/**
		 * Constructor.
		 */
		public function GalleryItemRenderer()
		{
			this.addEventListener(TouchEvent.TOUCH, touchHandler);
		}

		/**
		 * @private
		 */
		protected var image:Image;

		/**
		 * @private
		 */
		protected var currentImageURL:String;

		/**
		 * @private
		 */
		protected var loader:Loader;

		/**
		 * @private
		 */
		protected var touchPointID:int = -1;

		/**
		 * @private
		 */
		private var _index:int = -1;

		/**
		 * @inheritDoc
		 */
		public function get index():int
		{
			return this._index;
		}

		/**
		 * @private
		 */
		public function set index(value:int):void
		{
			if(this._index == value)
			{
				return;
			}
			this._index = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		/**
		 * @private
		 */
		protected var _owner:List;

		/**
		 * @inheritDoc
		 */
		public function get owner():List
		{
			return List(this._owner);
		}

		/**
		 * @private
		 */
		public function set owner(value:List):void
		{
			if(this._owner == value)
			{
				return;
			}
			this._owner = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		/**
		 * @private
		 */
		private var _data:GalleryItem;

		/**
		 * @inheritDoc
		 */
		public function get data():Object
		{
			return this._data;
		}

		/**
		 * @private
		 */
		public function set data(value:Object):void
		{
			if(this._data == value)
			{
				return;
			}
			this._data = GalleryItem(value);
			this.invalidate(INVALIDATION_FLAG_DATA);
		}

		/**
		 * @private
		 */
		private var _isSelected:Boolean;

		/**
		 * @inheritDoc
		 */
		public function get isSelected():Boolean
		{
			return this._isSelected;
		}

		/**
		 * @private
		 */
		public function set isSelected(value:Boolean):void
		{
			if(this._isSelected == value)
			{
				return;
			}
			this._isSelected = value;
			this._onChange.dispatch(this);
		}

		/**
		 * @private
		 */
		protected var _onChange:Signal = new Signal(GalleryItemRenderer);

		/**
		 * @inheritDoc
		 */
		public function get onChange():ISignal
		{
			return this._onChange;
		}

		/**
		 * @private
		 */
		override protected function draw():void
		{
			const dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);
			const selectionInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SELECTED);
			var sizeInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_SIZE);

			if(dataInvalid)
			{
				if(this._data)
				{
					if(this.currentImageURL != this._data.thumbURL)
					{
						if(this.loader)
						{
							this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loader_completeHandler);
							this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
							this.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
							this.loader = null;
						}

						if(this.image)
						{
							this.image.visible = false;
						}

						this.currentImageURL = this._data.thumbURL;
						this.loader = new Loader();
						this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loader_completeHandler);
						this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
						this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
						this.loader.load(new URLRequest(this._data.thumbURL), LOADER_CONTEXT);
					}
				}
				else
				{
					if(this.loader)
					{
						this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loader_completeHandler);
						this.loader = null;
					}
					if(this.image)
					{
						this.image.texture.dispose();
						this.removeChild(this.image, true);
						this.image = null;
					}
					this.currentImageURL = null;
				}
			}

			sizeInvalid = this.autoSizeIfNeeded() || sizeInvalid;

			if(sizeInvalid)
			{
				if(this.image)
				{
					this.image.x = (this.actualWidth - this.image.width) / 2;
					this.image.y = (this.actualHeight - this.image.height) / 2;
				}
			}
		}

		/**
		 * @private
		 */
		protected function autoSizeIfNeeded():Boolean
		{
			const needsWidth:Boolean = isNaN(this.explicitWidth);
			const needsHeight:Boolean = isNaN(this.explicitHeight);
			if(!needsWidth && !needsHeight)
			{
				return false;
			}
			var newWidth:Number = this.explicitWidth;
			if(needsWidth)
			{
				if(this.image)
				{
					newWidth = this.image.width;
				}
			}
			var newHeight:Number = this.explicitHeight;
			if(needsHeight)
			{
				if(this.image)
				{
					newHeight = this.image.height;
				}
			}
			return this.setSizeInternal(newWidth, newHeight, false);
		}

		/**
		 * @private
		 */
		protected function touchHandler(event:TouchEvent):void
		{
			const touches:Vector.<Touch> = event.getTouches(this.stage);
			if(touches.length == 0)
			{
				return;
			}
			if(this.touchPointID >= 0)
			{
				var touch:Touch;
				for each(var currentTouch:Touch in touches)
				{
					if(currentTouch.id == this.touchPointID)
					{
						touch = currentTouch;
						break;
					}
				}
				if(!touch)
				{
					return;
				}
				if(touch.phase == TouchPhase.ENDED)
				{
					this.touchPointID = -1;
					this.isSelected = !this._isSelected;
					return;
				}
			}
			else
			{
				for each(touch in touches)
				{
					if(touch.phase == TouchPhase.BEGAN)
					{
						this.touchPointID = touch.id;
						return;
					}
				}
			}
		}

		/**
		 * @private
		 */
		protected function loader_completeHandler(event:Event):void
		{
			const bitmap:Bitmap = Bitmap(this.loader.content);
			this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loader_completeHandler);
			this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
			this.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
			this.loader = null;

			const texture:Texture = Texture.fromBitmap(bitmap);
			if(this.image)
			{
				this.image.texture.dispose();
				this.image.texture = texture;
				this.image.readjustSize();
			}
			else
			{
				this.image = new Image(texture);
				this.addChild(this.image);
			}
			this.image.visible = true;
			this.invalidate(INVALIDATION_FLAG_SIZE);
		}

		/**
		 * @private
		 */
		protected function loader_errorHandler(event:ErrorEvent):void
		{
			this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loader_completeHandler);
			this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loader_errorHandler);
			this.loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, loader_errorHandler);
			this.loader = null;
			
			//can't load the image at this time
			//TODO: maybe show a placeholder?
		}

	}
}
