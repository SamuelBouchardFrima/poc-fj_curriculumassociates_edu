package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class GamePOC extends Sprite
	{
		private static const VERSION:String = "v1.2";
		
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
			
			var version:CurvedBox = new CurvedBox(new Point(16, 16), 0xCCCCCC, new BoxLabel(VERSION, 12, 0x000000), 1, null, Axis.HORIZONTAL, 8);
			version.x = (version.width / 2) + 2;
			version.y = (version.height / 2) + 2;
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