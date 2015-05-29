package com.frimastudio.fj_curriculumassociates_edu.poc_lesson
{
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	public class LessonPOC extends Sprite
	{
		private var mSpotlight:CurvedBox;
		private var mFlashlight:CurvedBox;
		private var mQuest:Quest
		
		public function LessonPOC():void
		{
			stage ? Init() : addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(aEvent:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			// entry point
			
			var version:TextField = new TextField();
			version.text = "v0.1";
			version.selectable = false;
			version.x = 5;
			version.y = 5;
			addChild(version);
			
			mSpotlight = new CurvedBox(new Point(100, 52), Palette.GREAT_BTN,
				new BoxLabel("Spotlight", 39, Palette.BTN_CONTENT), 12, null, Axis.HORIZONTAL);
			mSpotlight.x = 512;
			mSpotlight.y = 356;
			mSpotlight.addEventListener(MouseEvent.CLICK, OnClickSpotlight);
			addChild(mSpotlight);
			
			//mFlashlight = new CurvedBox(new Point(100, 52), Palette.GREAT_BTN,
				//new BoxLabel("Flashlight", 39, Palette.BTN_CONTENT), 12, null, Axis.HORIZONTAL);
			//mFlashlight.x = 512;
			//mFlashlight.y = mSpotlight.y + 62;
			//mFlashlight.addEventListener(MouseEvent.CLICK, OnClickFlashlight);
			//addChild(mFlashlight);
		}
		
		private function OnClickSpotlight(aEvent:MouseEvent):void
		{
			removeChild(mSpotlight);
			//removeChild(mFlashlight);
			
			mQuest = new LessonPOCSpotlightQuest();
			mQuest.addEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			addChild(mQuest);
		}
		
		//private function OnClickFlashlight(aEvent:MouseEvent):void
		//{
			//removeChild(mSpotlight);
			//removeChild(mFlashlight);
			//
			//mQuest = new LessonPOCFlashlightQuest();
			//mQuest.addEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			//addChild(mQuest);
		//}
		
		private function OnCompleteQuest(aEvent:QuestEvent):void
		{
			mQuest.removeEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			removeChild(mQuest);
			mQuest = null;
			
			addChild(mSpotlight);
			//addChild(mFlashlight);
		}
	}
}