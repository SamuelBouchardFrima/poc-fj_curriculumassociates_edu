package com.frimastudio.fj_curriculumassociates_edu.rpt_wordcrafting
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class RPT_WordCrafting extends Sprite
	{
		public function RPT_WordCrafting():void
		{
			stage ? Init() : addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(aEvent:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			// entry point
			
			var version:TextField = new TextField();
			version.text = "v2.1";
			version.selectable = false;
			version.x = 5;
			version.y = 5;
			addChild(version);
			
			var miniFeedingDemo:MiniFeedingDemo = new MiniFeedingDemo();
			addChild(miniFeedingDemo);
		}
	}
}