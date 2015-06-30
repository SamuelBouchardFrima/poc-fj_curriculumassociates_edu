package com.frimastudio.fj_curriculumassociates_edu.activity
{
	import flash.events.Event;
	
	public class ActivityBoxEvent extends Event
	{
		public static const LAUNCH_ACTIVITY:String = "com.frimastudio.fj_curriculumassociates_edu.activity.ActivityBoxEvent::LAUNCH_ACTIVITY";
		
		private var mActivityToLaunch:ActivityType;
		
		public function get ActivityToLaunch():ActivityType	{ return mActivityToLaunch; }
		
		public function ActivityBoxEvent(aType:String, aActivityToLaunch:ActivityType = null, aBubbles:Boolean = false,
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