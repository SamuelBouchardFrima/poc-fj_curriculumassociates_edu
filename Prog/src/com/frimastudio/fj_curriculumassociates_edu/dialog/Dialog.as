package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.ActivityBox;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStep;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.sound.SoundManager;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.Box;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxIcon;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Quad;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.media.Sound;
	
	public class Dialog extends QuestStep
	{
		private var mTemplate:DialogTemplate;
		private var mStep:int;
		private var mDialogBox:Box;
		private var mActivityBox:ActivityBox;
		//private var mDisposing:Boolean;
		private var mDefaultY:Number;
		private var mDefaultScale:Number;
		
		public function Dialog(aTemplate:DialogTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			mStep = 0;
			
			mDefaultY = mLevel.Lucu.y;
			mDefaultScale = mLevel.Lucu.scaleX;
			
			//TweenLite.to(mLevel.Lucu, 1, { ease:Quad.easeInOut, delay:2, onComplete:OnTweenGlowStrong, glowFilter: { alpha:1.5 } });
			//TweenLite.to(mLevel.Lucu, 0.1, { ease:Quad.easeOut, delay:2, onComplete:OnTweenAttentionJump, onCompleteParams:[0],
				//y:(mDefaultY - 25), scaleX:(mDefaultScale * 0.9), scaleY:(mDefaultScale * 1.1) });
			//mLevel.Lucu.addEventListener(MouseEvent.CLICK, OnClickLucu);
			
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
			
			var direction:Direction;
			switch (mTemplate.Speaker)
			{
				case SpeakerType.PLORY:
					direction = Direction.UP_LEFT;
					break;
				case SpeakerType.NPC:
					direction = Direction.UP;
					break;
				default:
					throw new Error("SpeakerType " + mTemplate.Speaker.Description + " not handled.");
					break;
			}
			
			mDialogBox = new CurvedBox(new Point(800, 60), Palette.DIALOG_BOX, new BoxLabel(mTemplate.DialogList[mStep], 45,
				//Palette.DIALOG_CONTENT), 6, Direction.UP_LEFT, Axis.BOTH);
				Palette.DIALOG_CONTENT), 6, direction, Axis.BOTH);
			mDialogBox.addEventListener(MouseEvent.CLICK, OnClickDialogBox);
			addChild(mDialogBox);
			
			switch (mTemplate.Speaker)
			{
				case SpeakerType.PLORY:
					mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
					mDialogBox.y = mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2);
					break;
				case SpeakerType.NPC:
					mDialogBox.x = mLevel.NPC.x;
					mDialogBox.y = mLevel.NPC.y + (mLevel.NPC.height / 2) + 10 + (mDialogBox.height / 2);
					break;
				default:
					throw new Error("SpeakerType " + mTemplate.Speaker.Description + " not handled.");
					break;
			}
			
			//(new mTemplate.DialogAudioList[mStep]() as Sound).play();
			var soundLength:Number = SoundManager.PlayVO(mTemplate.DialogAudioList[mStep]);
			
			mDialogBox.filters = [new GlowFilter(Palette.GREAT_BTN, 0, 16, 16, 2, BitmapFilterQuality.HIGH, true)];
			TweenLite.to(mDialogBox, 1, { ease:Quad.easeInOut, delay:(soundLength / 1000),
				onComplete:OnTweenGlowStrong, glowFilter: { alpha:1.5 } });
			
			if (mTemplate.ActivityWordList)
			{
				mActivityBox = new ActivityBox(mTemplate.ActivityWordList, mTemplate.LineBreakList, mTemplate.ActivityVO,
					mTemplate.PhylacteryArrow);
				mActivityBox.x = 512;
				mActivityBox.y = ((mTemplate.LineBreakList.length + 1) * 40) + 30;
				addChild(mActivityBox);
			}
		}
		
		override public function Dispose():void
		{
			//mWildLucuChallengeBtn.removeEventListener(MouseEvent.CLICK, OnClickWildLucuChallengeBtn);
			mWildLucu.removeEventListener(MouseEvent.CLICK, OnClickWildLucu);
			
			//mDisposing = true;
			
			mDialogBox.removeEventListener(MouseEvent.CLICK, OnClickDialogBox);
			//mLevel.Lucu.removeEventListener(MouseEvent.CLICK, OnClickLucu);
			
			TweenLite.killTweensOf(mLevel.Lucu);
			mLevel.Lucu.y = mDefaultY;
			mLevel.Lucu.scaleX = mLevel.Lucu.scaleY = mDefaultScale;
			TweenLite.killTweensOf(mDialogBox);
			
			if (mActivityBox)
			{
				mActivityBox.Dispose();
			}
			
			super.Dispose();
		}
		
		override public function Refresh():void
		{
			if (mLevel && mLevel != Level.NONE)
			{
				var soundLength:Number = SoundManager.PlayVO(mTemplate.DialogAudioList[mStep]);
				
				TweenLite.killTweensOf(mDialogBox);
				mDialogBox.filters = [new GlowFilter(Palette.GREAT_BTN, 0, 16, 16, 2, BitmapFilterQuality.HIGH, true)];
				TweenLite.to(mDialogBox, 1, { ease:Quad.easeInOut, delay:(soundLength / 1000),
					onComplete:OnTweenGlowStrong, glowFilter: { alpha:1.5 } });
			}
			
			super.Refresh();
		}
		
		private function OnTweenGlowStrong():void
		{
			TweenLite.to(mDialogBox, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowWeak, glowFilter:{ alpha:0.25 } });
		}
		
		private function OnTweenGlowWeak():void
		{
			TweenLite.to(mDialogBox, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowStrong, glowFilter:{ alpha:0.75 } });
		}
		
		private function OnTweenAttentionJump(aJumpAmount:int):void
		{
			//if (mDisposing)
			//{
				//mLevel.Lucu.y = aDefaultY;
				//mLevel.Lucu.scaleX = mLevel.Lucu.scaleY = aDefaultScale;
				//TweenLite.killTweensOf(mLevel.Lucu);
				//return;
			//}
			
			TweenLite.to(mLevel.Lucu, 0.4, { ease:Bounce.easeOut, onComplete:OnTweenAttentionBounce,
				onCompleteParams:[aJumpAmount], y:mDefaultY, scaleX:mDefaultScale, scaleY:mDefaultScale });
		}
		
		private function OnTweenAttentionBounce(aJumpAmount:int):void
		{
			//if (mDisposing)
			//{
				//mLevel.Lucu.y = aDefaultY;
				//mLevel.Lucu.scaleX = mLevel.Lucu.scaleY = aDefaultScale;
				//TweenLite.killTweensOf(mLevel.Lucu);
				//return;
			//}
			
			++aJumpAmount;
			if (aJumpAmount < 3)
			{
				TweenLite.to(mLevel.Lucu, 0.1, { ease:Quad.easeOut, onComplete:OnTweenAttentionJump, onCompleteParams:[aJumpAmount],
					y:(mDefaultY - 25), scaleX:(mDefaultScale * 0.9), scaleY:(mDefaultScale * 1.1) });
			}
			else
			{
				TweenLite.to(mLevel.Lucu, 0.1, { ease:Quad.easeOut, delay:2, onComplete:OnTweenAttentionJump, onCompleteParams:[0],
					y:(mDefaultY - 25), scaleX:(mDefaultScale * 0.9), scaleY:(mDefaultScale * 1.1) });
			}
		}
		
		private function OnClickDialogBox(aEvent:MouseEvent):void
		{
			++mStep;
			
			if (mStep < mTemplate.DialogList.length)
			{
				mDialogBox.Content = new BoxLabel(mTemplate.DialogList[mStep], 45, Palette.DIALOG_CONTENT);
				//mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
				//mDialogBox.y = mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2);
				switch (mTemplate.Speaker)
				{
					case SpeakerType.PLORY:
						mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
						mDialogBox.y = mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2);
						break;
					case SpeakerType.NPC:
						mDialogBox.x = mLevel.NPC.x;
						mDialogBox.y = mLevel.NPC.y + (mLevel.NPC.height / 2) + 10 + (mDialogBox.height / 2);
						break;
					default:
						throw new Error("SpeakerType " + mTemplate.Speaker.Description + " not handled.");
						break;
				}
				
				//(new mTemplate.DialogAudioList[mStep]() as Sound).play();
				var soundLength:Number = SoundManager.PlayVO(mTemplate.DialogAudioList[mStep]);
				
				TweenLite.killTweensOf(mDialogBox);
				mDialogBox.filters = [new GlowFilter(Palette.GREAT_BTN, 0, 16, 16, 2, BitmapFilterQuality.HIGH, true)];
				TweenLite.to(mDialogBox, 1, { ease:Quad.easeInOut, delay:(soundLength / 1000),
					onComplete:OnTweenGlowStrong, glowFilter: { alpha:1.5 } });
			}
			else
			{
				dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
			}
		}
		
		//private function OnClickLucu(aEvent:MouseEvent):void
		//{
			//++mStep;
			//
			//if (mStep < mTemplate.DialogList.length)
			//{
				//mDialogBox.Content = new BoxLabel(mTemplate.DialogList[mStep], 45, Palette.DIALOG_CONTENT);
				////mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
				////mDialogBox.y = mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2);
				//switch (mTemplate.Speaker)
				//{
					//case SpeakerType.PLORY:
						//mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
						//mDialogBox.y = mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2);
						//break;
					//case SpeakerType.NPC:
						//mDialogBox.x = mLevel.NPC.x;
						//mDialogBox.y = mLevel.NPC.y + (mLevel.NPC.height / 2) + 10 + (mDialogBox.height / 2);
						//break;
					//default:
						//throw new Error("SpeakerType " + mTemplate.Speaker.Description + " not handled.");
						//break;
				//}
				//
				////(new mTemplate.DialogAudioList[mStep]() as Sound).play();
				//SoundManager.PlayVO(mTemplate.DialogAudioList[mStep]);
			//}
			//else
			//{
				//dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
			//}
		//}
	}
}