package org.josht.starling.foxhole.kitchenSink.data
{
	import org.josht.starling.foxhole.controls.Slider;

	public class SliderSettings
	{
		public function SliderSettings()
		{
		}

		public var direction:String = Slider.DIRECTION_HORIZONTAL;
		public var step:Number = 1;
		public var liveDragging:Boolean = true;
	}
}
