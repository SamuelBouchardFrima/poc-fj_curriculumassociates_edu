package com.frimastudio.fj_curriculumassociates_edu.sound
{
	import flash.events.Event;
	
	public class SoundUnitEvent extends Event
	{
		public static const COMPLETE:String = "com.frimastudio.fj_curriculumassociates_edu.sound.SoundUnitEvent::COMPLETE";
		
		public function SoundUnitEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new SoundUnitEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("SoundUnitEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}