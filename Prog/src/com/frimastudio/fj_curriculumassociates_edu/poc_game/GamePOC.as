package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.inventory.Inventory;
	import com.frimastudio.fj_curriculumassociates_edu.lucutaming.LucuTamingConfig;
	import com.frimastudio.fj_curriculumassociates_edu.navigation.ExplorableLevel;
	import com.frimastudio.fj_curriculumassociates_edu.navigation.NavigationManager;
	import com.frimastudio.fj_curriculumassociates_edu.navigation.NavigationManagerConfig;
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
		private static const VERSION:String = "v4.1";
		
		public function GamePOC():void
		{
			stage ? Init() : addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(aEvent:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			// entry point
			
			TweenPlugin.activate([GlowFilterPlugin]);
			
			//var quest:GamePOCQuest = new GamePOCQuest();
			//quest.addEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			//addChild(quest);
			
			var navigationContainer:Sprite = new Sprite();
			addChild(navigationContainer);
			NavigationManagerConfig.Container = navigationContainer;
			
			var lucuTamingContainer:Sprite = new Sprite();
			addChild(lucuTamingContainer);
			LucuTamingConfig.Container = lucuTamingContainer;
			
			var version:CurvedBox = new CurvedBox(new Point(16, 16), 0xCCCCCC,
				new BoxLabel(VERSION, 12, 0x000000), 1, null, Axis.HORIZONTAL, 8, 0);
			version.x = (version.width / 2) + 2;
			version.y = (version.height / 2) + 2;
			addChild(version);
			
			//NavigationManager.Unlock(ExplorableLevel.THE_LAB);
			NavigationManager.Navigate(ExplorableLevel.THE_LAB);
			ExplorableLevel.THE_LAB.Start();
		}
		
		//private function OnCompleteQuest(aEvent:QuestEvent):void
		//{
			//var quest:GamePOCQuest = aEvent.currentTarget as GamePOCQuest;
			//quest.removeEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			//
			//Inventory.Reset();
			//
			//var newQuest:GamePOCQuest = new GamePOCQuest();
			//newQuest.addEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			//addChildAt(newQuest, getChildIndex(quest));
			//
			//removeChild(quest);
		//}
	}
}