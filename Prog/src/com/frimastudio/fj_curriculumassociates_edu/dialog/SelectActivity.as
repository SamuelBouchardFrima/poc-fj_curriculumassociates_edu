package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.ActivityBox;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.ActivityBoxEvent;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStep;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.sound.SoundManager;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxIcon;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import com.greensock.easing.Quad;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.utils.Timer;
	
	public class SelectActivity extends QuestStep
	{
		private var mTemplate:SelectActivityTemplate;
		private var mDialogBox:CurvedBox;
		private var mActivityBox:ActivityBox;
		
		public function SelectActivity(aTemplate:SelectActivityTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			var playerPortrait:Sprite = new Sprite();
			var playerPortraitBitmap:Bitmap = new Asset.PlayerPortrait() as Bitmap;
			playerPortraitBitmap.smoothing = true;
			playerPortraitBitmap.scaleX = playerPortraitBitmap.scaleY = 0.75;
			playerPortraitBitmap.x = -playerPortraitBitmap.width / 2;
			playerPortraitBitmap.y = -playerPortraitBitmap.height / 2;
			playerPortrait.addChild(playerPortraitBitmap);
			playerPortrait.x = 5 + (playerPortrait.width / 2);
			playerPortrait.y = 763 - (playerPortrait.height / 2);
			addChild(playerPortrait);
			
			//mWildLucuChallengeBtn = new CurvedBox(new Point(64, 64), 0xD18B25,
				//new BoxIcon(Asset.WildLucuIdleBitmap, Palette.BTN_CONTENT), 6);
			//mWildLucuChallengeBtn.x = 1014 - (mWildLucuChallengeBtn.width / 2);
			//mWildLucuChallengeBtn.y = 758 - (mWildLucuChallengeBtn.height / 2);
			//mWildLucuChallengeBtn.addEventListener(MouseEvent.CLICK, OnClickWildLucuChallengeBtn);
			//addChild(mWildLucuChallengeBtn);
			//mWildLucu = new Sprite();
			//var wildLucuBitmap:Bitmap = new Asset.WildLucuIdleBitmap() as Bitmap;
			//wildLucuBitmap.smoothing = true;
			//wildLucuBitmap.scaleY = 0.5;
			//wildLucuBitmap.scaleX = -wildLucuBitmap.scaleY;
			//wildLucuBitmap.x = wildLucuBitmap.width / 2;
			//wildLucuBitmap.y = -wildLucuBitmap.height / 2;
			//mWildLucu.addChild(wildLucuBitmap);
			//mWildLucu.x = 1014 - (mWildLucu.width / 2);
			//mWildLucu.y = 758 - (mWildLucu.height / 2);
			//mWildLucu.addEventListener(MouseEvent.CLICK, OnClickWildLucu);
			//addChild(mWildLucu);
			
			InitializeMap();
			InitializeWildLucu();
			
			mDialogBox = new CurvedBox(new Point(800, 60), Palette.DIALOG_BOX, new BoxLabel("Click a colored box.", 45,
				Palette.DIALOG_CONTENT), 6, Direction.UP_LEFT, Axis.BOTH);
			mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
			mDialogBox.y = mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2);
			addChild(mDialogBox);
			
			mActivityBox = new ActivityBox(mTemplate.ActivityWordList, mTemplate.LineBreakList, mTemplate.ActivityVO,
				mTemplate.PhylacteryArrow, false, true);
			mActivityBox.StepTemplate = mTemplate;
			mActivityBox.x = 512;
			mActivityBox.y = ((mTemplate.LineBreakList.length + 1) * 40) + 30;
			mActivityBox.addEventListener(ActivityBoxEvent.LAUNCH_ACTIVITY, OnLaunchActivity);
			
			// TODO:	play "Click a colored box." VO
			SoundManager.PlayVO(Asset.NewHintSound[4]);
			
			addChild(mActivityBox);
		}
		
		override public function Dispose():void
		{
			//mWildLucuChallengeBtn.removeEventListener(MouseEvent.CLICK, OnClickWildLucuChallengeBtn);
			mWildLucu.removeEventListener(MouseEvent.CLICK, OnClickWildLucu);
			
			TweenLite.killTweensOf(mActivityBox);
			mActivityBox.removeEventListener(ActivityBoxEvent.LAUNCH_ACTIVITY, OnLaunchActivity);
			mActivityBox.Dispose();
			
			super.Dispose();
		}
		
		public function CompleteCurrentActivity(aNewWordList:Vector.<WordTemplate>):void
		{
			mActivityBox.WordTemplateList = aNewWordList;
			mActivityBox.UpdateContent();
			addChildAt(mLevel, 0);
			
			//(new Asset.SnappingSound() as Sound).play();
			SoundManager.PlaySFX(Asset.SnappingSound);
			
			if (mActivityBox.IsComplete)
			{
				removeChild(mDialogBox);
				
				if (mActivityBox.SentenceDecrypted && !mActivityBox.SentenceScrambled)
				{
					var bounceLength:Number = mActivityBox.BounceInSequence();
					
					//var earQuestStepVOTimer:Timer = new Timer(bounceLength, 1);
					//earQuestStepVOTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnEarQuestStepVOTimerComplete);
					//earQuestStepVOTimer.start();
					var earCrescendoSFXTimer:Timer = new Timer(bounceLength, 1);
					earCrescendoSFXTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnEarCrescendoSFXTimerComplete);
					earCrescendoSFXTimer.start();
				}
				else
				{
					var completeQuestStepTimer:Timer = new Timer(200, 1);
					completeQuestStepTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnCompleteQuestStepTimerComplete);
					completeQuestStepTimer.start();
				}
			}
			else
			{
				// TODO:	play "Click a colored box." VO
				SoundManager.PlayVO(Asset.NewHintSound[4]);
			}
		}
		
		//private function OnEarQuestStepVOTimerComplete(aEvent:TimerEvent):void
		//{
			//(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnEarQuestStepVOTimerComplete);
			//
			////var sound:Sound = new mTemplate.ActivityVO() as Sound;
			////sound.play();
			//var soundLength:Number = SoundManager.PlayVO(mTemplate.ActivityVO);
			//
			//var earCrescendoSFXTimer:Timer = new Timer(soundLength, 1);
			//earCrescendoSFXTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnEarCrescendoSFXTimerComplete);
			//earCrescendoSFXTimer.start();
		//}
		
		private function OnEarCrescendoSFXTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnEarCrescendoSFXTimerComplete);
			
			//var sound:Sound = new Asset.CrescendoSound() as Sound;
			//sound.play();
			var soundLength:Number = SoundManager.PlaySFX(Asset.CrescendoSound);
			
			var completeQuestStepTimer:Timer = new Timer(soundLength, 1);
			completeQuestStepTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnCompleteQuestStepTimerComplete);
			completeQuestStepTimer.start();
		}
		
		private function OnCompleteQuestStepTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnCompleteQuestStepTimerComplete);
			
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
		
		private function OnTweenGlowStrong():void
		{
			TweenLite.to(mActivityBox, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowWeak, glowFilter:{ alpha:0.25 } });
		}
		
		private function OnTweenGlowWeak():void
		{
			TweenLite.to(mActivityBox, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowStrong, glowFilter:{ alpha:0.75 } });
		}
		
		private function OnLaunchActivity(aEvent:ActivityBoxEvent):void
		{
			//dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
			dispatchEvent(new QuestStepEvent(QuestStepEvent.LAUNCH_ACTIVITY, aEvent.ActivityToLaunch));
		}
	}
}