package com.frimastudio.fj_curriculumassociates_edu.poc
{
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
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
			
			var quest:POCQuest = new POCQuest();
			quest.addEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			addChild(quest);
			
			var version:TextField = new TextField();
			version.text = "v0.3";
			version.selectable = false;
			version.x = 5;
			version.y = 5;
			addChild(version);
		}
		
		private function OnCompleteQuest(aEvent:QuestEvent):void
		{
			var quest:POCQuest = aEvent.currentTarget as POCQuest;
			quest.removeEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			removeChild(quest);
			
			quest = new POCQuest();
			quest.addEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			addChild(quest);
		}
	}
}