package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestEvent;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class GamePOC extends Sprite
	{
		public function GamePOC():void
		{
			stage ? Init() : addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(aEvent:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			// entry point
			
			var quest:GamePOCQuest = new GamePOCQuest();
			quest.addEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			addChild(quest);
			
			var version:TextField = new TextField();
			version.text = "v0.5";
			version.selectable = false;
			version.x = 5;
			version.y = 5;
			addChild(version);
		}
		
		private function OnCompleteQuest(aEvent:QuestEvent):void
		{
			var quest:GamePOCQuest = aEvent.currentTarget as GamePOCQuest;
			quest.removeEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			removeChild(quest);
			
			quest = new GamePOCQuest();
			quest.addEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			addChild(quest);
		}
	}
}