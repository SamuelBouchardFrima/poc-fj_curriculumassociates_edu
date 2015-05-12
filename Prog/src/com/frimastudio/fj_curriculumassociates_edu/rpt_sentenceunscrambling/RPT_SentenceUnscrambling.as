package com.frimastudio.fj_curriculumassociates_edu.rpt_sentenceunscrambling
{
	import com.frimastudio.fj_curriculumassociates_edu.rpt_sentenceunscrambling.WordDraggingDemo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class RPT_SentenceUnscrambling extends Sprite
	{
		public function RPT_SentenceUnscrambling():void
		{
			stage ? Init() : addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(aEvent:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			// entry point
			
			var version:TextField = new TextField();
			version.text = "v0.4";
			version.selectable = false;
			version.x = 5;
			version.y = 5;
			addChild(version);
			
			var wordDraggingDemo:WordDraggingDemo = new WordDraggingDemo();
			addChild(wordDraggingDemo);
		}
	}
}