package com.frimastudio.fj_curriculumassociates_edu.poc_lesson
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.Box;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxIcon;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import com.frimastudio.fj_curriculumassociates_edu.util.Random;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
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
		private static const VERSION:String = "v2.1";
		
		private var mContainer:Sprite;
		private var mQuestList:Vector.<Class>;
		private var mQuestNameList:Vector.<String>;
		private var mQuestTitleAudioList:Vector.<Class>;
		private var mQuestIndex:int;
		private var mCompletedQuest:Vector.<int>;
		private var mQuest:Quest
		private var mLessonList:Vector.<Sprite>;
		private var mCurtainList:Vector.<Sprite>;
		private var mCurtainSignList:Vector.<Sprite>;
		private var mCurtainSignBoxList:Vector.<CurvedBox>;
		private var mDialog:Box;
		private var mBlocker:Sprite;
		private var mVersion:TextField;
		private var mLaunchQuestTimer:Timer;
		
		public function LessonPOC():void
		{
			stage ? Init() : addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(aEvent:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			// entry point
			
			mContainer = new Sprite();
			addChild(mContainer);
			
			var lucu:Bitmap = new Asset.LabLucuBitmap();
			lucu.x = -50;
			lucu.y = 210;
			mContainer.addChild(lucu);
			
			var counter:Bitmap = new Asset.LabCounterBitmap();
			counter.x = 290;
			counter.y = 600;
			mContainer.addChild(counter);
			
			mQuestList = new <Class>[LessonPOCSpotlightQuest, LessonPOCFlashlightQuest, LessonPOCCircuitQuest];
			mQuestNameList = new <String>["LISTEN UP", "FLASHLIGHT", "MAKE A CIRCUIT"];
			mQuestTitleAudioList = new <Class>[Asset.SpotlightTitleSound, Asset.FlashlightTitleSound, Asset.CircuitTitleSound];
			
			//mQuestList = new <Class>[LessonPOCSpotlightQuest, LessonPOCFlashlightQuest, LessonPOCCircuitQuest, LessonPOCFamilySortQuest];
			//mQuestNameList = new <String>["LISTEN UP", "FLASHLIGHT", "MAKE A CIRCUIT", "FAMILY"];
			//mQuestTitleAudioList = new <Class>[Asset.SpotlightTitleSound, Asset.FlashlightTitleSound, Asset.CircuitTitleSound, Asset.FamilySortTitleSound];
			
			//mQuestList = new <Class>[LessonPOCFamilySortQuest];
			//mQuestNameList = new <String>["FAMILY"];
			//mQuestTitleAudioList = new <Class>[Asset.FamilySortTitleSound];
			
			var i:int, endi:int;
			
			mLessonList = new Vector.<Sprite>();
			var lesson:Sprite;
			var lessonBitmap:Bitmap;
			for (i = 0, endi = Math.min(mQuestList.length, 5); i < endi; ++i)
			{
				lesson = new Sprite();
				lesson.x = 388 + (i * 135);
				lesson.y = 615;
				lessonBitmap = new Asset.LessonBitmap[i]();
				lessonBitmap.smoothing = true;
				lessonBitmap.width = Math.min(lessonBitmap.width, 100);
				lessonBitmap.scaleY = lessonBitmap.scaleX;
				lessonBitmap.x = -lessonBitmap.width / 2;
				lessonBitmap.y = -lessonBitmap.height;
				lesson.addChild(lessonBitmap);
				mContainer.addChild(lesson);
				mLessonList.push(lesson);
			}
			
			mCurtainList = new Vector.<Sprite>();
			var curtain:Sprite;
			var curtainBitmap:Bitmap;
			for (i = 0, endi = Math.min(mQuestList.length, 5); i < endi; ++i)
			{
				curtain = new Sprite();
				curtain.x = 388 + (i * 135);
				curtain.y = 285;
				curtain.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOverCurtain);
				curtain.addEventListener(MouseEvent.MOUSE_OUT, OnMouseOutCurtain);
				curtain.addEventListener(MouseEvent.CLICK, OnClickCurtain);
				curtainBitmap = new Asset.CurtainBitmap();
				curtainBitmap.x = -curtainBitmap.width / 2;
				curtainBitmap.y = -curtainBitmap.height / 2;
				curtain.addChild(curtainBitmap);
				mContainer.addChild(curtain);
				mCurtainList.push(curtain);
			}
			
			mCurtainSignList = new Vector.<Sprite>();
			mCurtainSignBoxList = new Vector.<CurvedBox>();
			var sign:Sprite;
			var signBox:CurvedBox;
			for (i = 0, endi = Math.min(mQuestList.length, 5); i < endi; ++i)
			{
				sign = new Sprite();
				sign.x = 388 + (i * 135);
				sign.y = 255;
				sign.mouseEnabled = false;
				sign.mouseChildren = false;
				signBox = new CurvedBox(new Point(96, 128), Palette.GENERIC_BTN,
					new BoxIcon(Asset.LessonBitmap[i], Palette.BTN_CONTENT), 12);
				signBox.x = 0;
				signBox.y = -325;
				signBox.graphics.lineStyle(5, Palette.GENERIC_BTN);
				signBox.graphics.moveTo(0, -signBox.height / 2);
				signBox.graphics.lineTo(0, -1000);
				sign.addChild(signBox);
				mCurtainSignBoxList.push(signBox);
				sign.graphics.beginFill(0x000000, 0);
				sign.graphics.drawRect(-signBox.width / 2, -1000, signBox.width, 1128);
				sign.graphics.endFill();
				TweenLite.to(signBox, 1, { ease:Bounce.easeOut, delay:(i * 0.15), y:Random.Range(0, 80) });
				mContainer.addChild(sign);
				mCurtainSignList.push(sign);
			}
			
			mDialog = new Box(new Point(914, 64), Palette.DIALOG_BOX,
				new BoxLabel("Choose an activity.", 48, Palette.DIALOG_CONTENT), 0, Direction.DOWN_LEFT);
			mDialog.x = 512;
			mDialog.y = 80;
			mContainer.addChild(mDialog);
			
			mBlocker = new Sprite();
			mBlocker.addEventListener(MouseEvent.CLICK, OnClickBlocker);
			mBlocker.graphics.beginFill(0x000000, 0);
			mBlocker.graphics.drawRect(0, 0, 1024, 768);
			mBlocker.graphics.endFill();
			mContainer.addChild(mBlocker);
			
			mVersion = new TextField();
			mVersion.text = VERSION;
			mVersion.selectable = false;
			mVersion.x = 5;
			mVersion.y = 5;
			addChild(mVersion);
			
			mCompletedQuest = new Vector.<int>();
			
			var instruction:Sound = new Asset.HUBInstructionSound() as Sound;
			instruction.play();
			var instructionTimer:Timer = new Timer(instruction.length, 1);
			instructionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnInstructionTimerComplete);
			instructionTimer.start();
			
			mLaunchQuestTimer = new Timer(2000, 1);
			mLaunchQuestTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnLaunchQuestTimerComplete);
		}
		
		private function OnInstructionTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnInstructionTimerComplete);
			
			mContainer.removeChild(mBlocker);
		}
		
		private function OnClickBlocker(aEvent:MouseEvent):void
		{
		}
		
		private function OnMouseOverCurtain(aEvent:MouseEvent):void
		{
			var index:int = mCurtainList.indexOf(aEvent.currentTarget as Sprite);
			TweenLite.to(mCurtainSignList[index], 0.2, { ease:Bounce.easeOut, y:375 });
		}
		
		private function OnMouseOutCurtain(aEvent:MouseEvent):void
		{
			var index:int = mCurtainList.indexOf(aEvent.currentTarget as Sprite);
			TweenLite.to(mCurtainSignList[index], 0.5, { ease:Bounce.easeOut, y:255 });
		}
		
		private function OnClickCurtain(aEvent:MouseEvent):void
		{
			(new Asset.ClickSound() as Sound).play();
			
			mContainer.addChild(mBlocker);
			
			mQuestIndex = mCurtainList.indexOf(aEvent.currentTarget as Sprite);
			
			TweenLite.to(mCurtainSignList[mQuestIndex], 1, { ease:Bounce.easeOut, y:(mCurtainSignList[mQuestIndex].y - 769) });
			
			mCurtainList[mQuestIndex].removeEventListener(MouseEvent.MOUSE_OVER, OnMouseOverCurtain);
			mCurtainList[mQuestIndex].removeEventListener(MouseEvent.MOUSE_OUT, OnMouseOutCurtain);
			mCurtainList[mQuestIndex].removeEventListener(MouseEvent.CLICK, OnClickCurtain);
			
			TweenLite.to(mCurtainList[mQuestIndex], 0.7, { ease:Strong.easeOut, delay:0.5,
				onComplete:OnTweenRemoveCurtain, y:mCurtainList[mQuestIndex].y - 625 });
		}
		
		private function OnTweenRemoveCurtain():void
		{
			mDialog.Content = new BoxLabel("You chose... " + mQuestNameList[mQuestIndex] + "!", 48, Palette.DIALOG_CONTENT);
			
			(new mQuestTitleAudioList[mQuestIndex]() as Sound).play();
			
			mLaunchQuestTimer.reset();
			mLaunchQuestTimer.start();
		}
		
		private function OnLaunchQuestTimerComplete(aEvent:TimerEvent):void
		{
			removeChild(mContainer);
			
			for (var i:int = 0, endi:int = mCurtainSignList.length; i < endi; ++i)
			{
				mCurtainSignList[i].y = 255;
				mCurtainSignBoxList[i].y = -325;
			}
			mDialog.Content = new BoxLabel("Choose an activity.", 48, Palette.DIALOG_CONTENT);
			
			mQuest = new mQuestList[mQuestIndex]();
			mQuest.addEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			addChild(mQuest);
			
			addChild(mVersion);
		}
		
		private function OnCompleteQuest(aEvent:QuestEvent):void
		{
			mQuest.removeEventListener(QuestEvent.COMPLETE, OnCompleteQuest);
			removeChild(mQuest);
			mQuest = null;
			
			var i:int, endi:int;
			
			mCompletedQuest.push(mQuestIndex);
			if (mCompletedQuest.length >= mQuestList.length)
			{
				mCompletedQuest = new Vector.<int>();
				for (i = 0, endi = mCurtainList.length; i < endi; ++i)
				{
					mCurtainList[i].y = 285;
					mCurtainList[i].addEventListener(MouseEvent.MOUSE_OVER, OnMouseOverCurtain);
					mCurtainList[i].addEventListener(MouseEvent.MOUSE_OUT, OnMouseOutCurtain);
					mCurtainList[i].addEventListener(MouseEvent.CLICK, OnClickCurtain);
				}
			}
			
			for (i = 0, endi = mCurtainSignBoxList.length; i < endi; ++i)
			{
				if (mCompletedQuest.indexOf(i) == -1)
				{
					TweenLite.to(mCurtainSignBoxList[i], 1, { ease:Bounce.easeOut, delay:(i * 0.15), y:Random.Range(0, 80) });
				}
			}
			addChild(mContainer);
			
			addChild(mVersion);
			
			var instruction:Sound = new Asset.HUBInstructionSound() as Sound;
			instruction.play();
			var instructionTimer:Timer = new Timer(instruction.length, 1);
			instructionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnInstructionTimerComplete);
			instructionTimer.start();
		}
	}
}