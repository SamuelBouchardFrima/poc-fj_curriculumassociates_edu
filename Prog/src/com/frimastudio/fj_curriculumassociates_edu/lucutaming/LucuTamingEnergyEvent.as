package com.frimastudio.fj_curriculumassociates_edu.lucutaming
{
	import flash.events.Event;
	
	public class LucuTamingEnergyEvent extends Event
	{
		public static const CHARGED:String = "com.frimastudio.fj_curriculumassociates_edu.lucutaming.LucuTamingEnergyEvent::CHARGED";
		public static const DISCHARGED:String = "com.frimastudio.fj_curriculumassociates_edu.lucutaming.LucuTamingEnergyEvent::DISCHARGED";
		
		public function LucuTamingEnergyEvent(aType:String, aBubbles:Boolean = false, aCancelable:Boolean = false)
		{
			super(aType, aBubbles, aCancelable);
		}
		
		override public function clone():Event
		{
			return new LucuTamingEnergyEvent(type, bubbles, cancelable);
		}
		
		override public function toString():String
		{
			return formatToString("LucuTamingEnergyEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}