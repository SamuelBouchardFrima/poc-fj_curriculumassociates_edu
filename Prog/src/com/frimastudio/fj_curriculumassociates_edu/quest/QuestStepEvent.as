package com.frimastudio.fj_curriculumassociates_edu.quest
{
	import flash.events.Event;
	
	public class QuestStepEvent extends Event
	{
		public static const COMPLETE:String = "com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent::COMPLETE";
		
		public function QuestStepEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new QuestStepEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("QuestStepEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}