package com.frimastudio.fj_curriculumassociates_edu.quest
{
	import flash.events.Event;
	
	public class QuestEvent extends Event
	{
		public static const COMPLETE:String = "com.frimastudio.fj_curriculumassociates_edu.quest.QuestEvent::COMPLETE";
		public static const OPEN_MAP:String = "com.frimastudio.fj_curriculumassociates_edu.quest.QuestEvent::OPEN_MAP";
		public static const RESET_POC:String = "com.frimastudio.fj_curriculumassociates_edu.quest.QuestEvent::RESET_POC";
		
		public function QuestEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new QuestEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("QuestEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}