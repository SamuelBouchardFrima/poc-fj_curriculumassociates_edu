package com.frimastudio.fj_curriculumassociates_edu.ui
{
	import flash.events.Event;
	
	public class DecayingButtonEvent extends Event
	{
		public static const DECAY_COMPLETE:String = "com.frimastudio.fj_curriculumassociates_edu.ui.DecayingButtonEvent::DECAY_COMPLETE";
		
		public function DecayingButtonEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new DecayingButtonEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("DecayingButtonEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}