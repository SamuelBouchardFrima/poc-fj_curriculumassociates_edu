package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestEvent;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class GamePOC extends Sprite
	{
		private static const VERSION:String = "v0.6";
		
		public function GamePOC():void
		{
			stage ? Init() : addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(aEvent:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			// entry point
			
			TweenPlugin.activate([GlowFilterPlugin]);
			
			var quest:GamePOCQuest = new GamePOCQuest();
			quest.addEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			addChild(quest);
			
			var version:TextField = new TextField();
			version.text = VERSION;
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