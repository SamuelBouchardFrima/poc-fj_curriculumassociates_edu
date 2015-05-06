package com.frimastudio.fj_curriculumassociates_edu.poc
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class POC extends Sprite
	{
		public function POC():void
		{
			stage ? Init() : addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(aEvent:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			// entry point
			
		}
	}
}