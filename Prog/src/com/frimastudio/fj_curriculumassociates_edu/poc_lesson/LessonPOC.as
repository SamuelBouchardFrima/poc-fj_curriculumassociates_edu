package com.frimastudio.fj_curriculumassociates_edu.poc_lesson
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class LessonPOC extends Sprite
	{
		private var mSpotlight:CurvedBox;
		private var mFlashlight:CurvedBox;
		private var mCircuit:CurvedBox;
		private var mQuest:Quest
		private var mVersion:TextField;
		
		public function LessonPOC():void
		{
			stage ? Init() : addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(aEvent:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			// entry point
			
			mVersion = new TextField();
			mVersion.text = "v0.4";
			mVersion.selectable = false;
			mVersion.x = 5;
			mVersion.y = 5;
			
			mSpotlight = new CurvedBox(new Point(200, 52), Palette.GREAT_BTN,
				new BoxLabel("Spotlight", 39, Palette.BTN_CONTENT), 12);
			mSpotlight.x = 512;
			mSpotlight.y = 325;
			mSpotlight.addEventListener(MouseEvent.CLICK, OnClickSpotlight);
			mSpotlight.EnableMouseOver();
			addChild(mSpotlight);
			
			mFlashlight = new CurvedBox(new Point(200, 52), Palette.GREAT_BTN,
				new BoxLabel("Flashlight", 39, Palette.BTN_CONTENT), 12);
			mFlashlight.x = 512;
			mFlashlight.y = mSpotlight.y + 62;
			mFlashlight.addEventListener(MouseEvent.CLICK, OnClickFlashlight);
			mFlashlight.EnableMouseOver();
			addChild(mFlashlight);
			
			mCircuit = new CurvedBox(new Point(200, 52), Palette.GREAT_BTN,
				new BoxLabel("Circuit", 39, Palette.BTN_CONTENT), 12);
			mCircuit.x = 512;
			mCircuit.y = mFlashlight.y + 62;
			mCircuit.addEventListener(MouseEvent.CLICK, OnClickCircuit);
			mCircuit.EnableMouseOver();
			addChild(mCircuit);
			
			addChild(mVersion);
			
			var instruction:Sound = new Asset.HUBInstructionSound() as Sound;
			instruction.play();
			var instructionTimer:Timer = new Timer(instruction.length, 1);
			instructionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnInstructionTimerComplete);
			instructionTimer.start();
		}
		
		private function OnInstructionTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnInstructionTimerComplete);
		}
		
		private function OnClickSpotlight(aEvent:MouseEvent):void
		{
			(new Asset.ClickSound() as Sound).play();
			
			removeChild(mSpotlight);
			removeChild(mFlashlight);
			removeChild(mCircuit);
			
			mQuest = new LessonPOCSpotlightQuest();
			mQuest.addEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			addChild(mQuest);
			
			addChild(mVersion);
		}
		
		private function OnClickFlashlight(aEvent:MouseEvent):void
		{
			(new Asset.ClickSound() as Sound).play();
			
			removeChild(mSpotlight);
			removeChild(mFlashlight);
			removeChild(mCircuit);
			
			mQuest = new LessonPOCFlashlightQuest();
			mQuest.addEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			addChild(mQuest);
			
			addChild(mVersion);
		}
		
		private function OnClickCircuit(aEvent:MouseEvent):void
		{
			(new Asset.ClickSound() as Sound).play();
			
			removeChild(mSpotlight);
			removeChild(mFlashlight);
			removeChild(mCircuit);
			
			mQuest = new LessonPOCCircuitQuest();
			mQuest.addEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			addChild(mQuest);
			
			addChild(mVersion);
		}
		
		private function OnCompleteQuest(aEvent:QuestEvent):void
		{
			mQuest.removeEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			removeChild(mQuest);
			mQuest = null;
			
			addChild(mSpotlight);
			addChild(mFlashlight);
			addChild(mCircuit);
			
			addChild(mVersion);
			
			var instruction:Sound = new Asset.HUBInstructionSound() as Sound;
			instruction.play();
			var instructionTimer:Timer = new Timer(instruction.length, 1);
			instructionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnInstructionTimerComplete);
			instructionTimer.start();
		}
	}
}