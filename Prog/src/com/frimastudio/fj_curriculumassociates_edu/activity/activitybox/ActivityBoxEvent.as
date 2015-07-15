package com.frimastudio.fj_curriculumassociates_edu.activity.activitybox
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import flash.events.Event;
	
	public class ActivityBoxEvent extends Event
	{
		public static const LAUNCH_ACTIVITY:String = "com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.ActivityBoxEvent::LAUNCH_ACTIVITY";
		public static const COMPLETE_ACTIVITY:String = "com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.ActivityBoxEvent::COMPLETE_ACTIVITY";
		public static const CHANGE_ACTIVITY_TYPE:String = "com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.ActivityBoxEvent::CHANGE_ACTIVITY_TYPE";
		
		private var mActivityToLaunch:ActivityTemplate;
		
		public function get ActivityToLaunch():ActivityTemplate	{ return mActivityToLaunch; }
		
		public function ActivityBoxEvent(aType:String, aActivityToLaunch:ActivityTemplate = null, aBubbles:Boolean = false,
			aCancelable:Boolean = false)
		{
			super(aType, aBubbles, aCancelable);
			
			mActivityToLaunch = aActivityToLaunch;
		}
		
		public override function clone():Event
		{
			return new ActivityBoxEvent(type, mActivityToLaunch, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("ActivityBoxEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}	
}