package com.frimastudio.fj_curriculumassociates_edu.quest
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import flash.events.Event;
	
	public class QuestStepEvent extends Event
	{
		public static const LAUNCH_ACTIVITY:String = "com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent::LAUNCH_ACTIVITY";
		public static const LAUNCH_LUCU_TAMING:String = "com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent::LAUNCH_LUCU_TAMING";
		public static const LEAVE:String = "com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent::LEAVE";
		public static const COMPLETE:String = "com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent::COMPLETE";
		
		private var mActivityToLaunch:ActivityTemplate;
		private var mWordList:Vector.<WordTemplate>;
		
		public function get ActivityToLaunch():ActivityTemplate	{ return mActivityToLaunch; }
		public function get WordList():Vector.<WordTemplate>	{ return mWordList; }
		
		public function QuestStepEvent(aType:String, aActivityToLaunch:ActivityTemplate = null, aWordList:Vector.<WordTemplate> = null,
			aBubbles:Boolean = false, aCancelable:Boolean = false)
		{
			super(aType, aBubbles, aCancelable);
			
			mActivityToLaunch = aActivityToLaunch;
			mWordList = aWordList;
		}
		
		public override function clone():Event
		{
			return new QuestStepEvent(type, mActivityToLaunch, mWordList, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("QuestStepEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}