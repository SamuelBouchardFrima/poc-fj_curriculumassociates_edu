package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStep;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
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
	
	public class ActivateQuest extends QuestStep
	{
		private var mTemplate:ActivateQuestTemplate;
		private var mNPC:Sprite;
		private var mDialogBox:CurvedBox;
		//private var mDisposing:Boolean;
		private var mDefaultY:Number;
		private var mDefaultScale:Number;
		
		public function ActivateQuest(aTemplate:ActivateQuestTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			mDefaultY = mLevel.Lucu.y;
			mDefaultScale = mLevel.Lucu.scaleX;
			
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
					//TweenLite.to(mLevel.Lucu, 0.1, { ease:Quad.easeOut, delay:2, onComplete:OnTweenAttentionJump,
						//onCompleteParams:[0], y:(mDefaultY - 25), scaleX:(mDefaultScale * 0.9), scaleY:(mDefaultScale * 1.1) });
					//mLevel.Lucu.addEventListener(MouseEvent.CLICK, OnClickLucu);
					direction = Direction.UP_LEFT;
					break;
				case SpeakerType.NPC:
					//mLevel.NPC.addEventListener(MouseEvent.CLICK, OnClickNPC);
					direction = Direction.UP;
					break;
				default:
					throw new Error("SpeakerType " + mTemplate.Speaker.Description + " not handled.");
					break;
			}
			
			mDialogBox = new CurvedBox(new Point(100, 100), Palette.DIALOG_BOX,
				new BoxLabel("!", 80, Palette.DIALOG_CONTENT), 6, direction);
			//mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
			//mDialogBox.y = mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2);
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
			
			mDialogBox.filters = [new GlowFilter(Palette.GREAT_BTN, 0, 16, 16, 2, BitmapFilterQuality.HIGH, true)];
			TweenLite.to(mDialogBox, 1, { ease:Quad.easeInOut, delay:2, onComplete:OnTweenGlowStrong, glowFilter: { alpha:1.5 } });
		}
		
		override public function Dispose():void
		{
			//mWildLucuChallengeBtn.removeEventListener(MouseEvent.CLICK, OnClickWildLucuChallengeBtn);
			mWildLucu.removeEventListener(MouseEvent.CLICK, OnClickWildLucu);
			
			//mDisposing = true;
			
			//mLevel.Lucu.removeEventListener(MouseEvent.CLICK, OnClickLucu);
			//mLevel.NPC.removeEventListener(MouseEvent.CLICK, OnClickNPC);
			mDialogBox.removeEventListener(MouseEvent.CLICK, OnClickDialogBox);
			
			TweenLite.killTweensOf(mLevel.Lucu);
			mLevel.Lucu.y = mDefaultY;
			mLevel.Lucu.scaleX = mLevel.Lucu.scaleY = mDefaultScale;
			TweenLite.killTweensOf(mDialogBox);
			
			super.Dispose();
		}
		
		private function OnTweenGlowStrong():void
		{
			TweenLite.to(mDialogBox, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowWeak, glowFilter:{ alpha:0.25 } });
		}
		
		private function OnTweenGlowWeak():void
		{
			TweenLite.to(mDialogBox, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowStrong, glowFilter:{ alpha:0.75 } });
		}
		
		//private function OnTweenAttentionJump(aJumpAmount:int):void
		//{
			////if (mDisposing)
			////{
				////mLevel.Lucu.y = aDefaultY;
				////mLevel.Lucu.scaleX = mLevel.Lucu.scaleY = aDefaultScale;
				////TweenLite.killTweensOf(mLevel.Lucu);
				////return;
			////}
			//
			//TweenLite.to(mLevel.Lucu, 0.4, { ease:Bounce.easeOut, onComplete:OnTweenAttentionBounce, onCompleteParams:[aJumpAmount],
				//y:mDefaultY, scaleX:mDefaultScale, scaleY:mDefaultScale });
		//}
		//
		//private function OnTweenAttentionBounce(aJumpAmount:int):void
		//{
			////if (mDisposing)
			////{
				////mLevel.Lucu.y = aDefaultY;
				////mLevel.Lucu.scaleX = mLevel.Lucu.scaleY = aDefaultScale;
				////TweenLite.killTweensOf(mLevel.Lucu);
				////return;
			////}
			//
			//++aJumpAmount;
			//if (aJumpAmount < 3)
			//{
				//TweenLite.to(mLevel.Lucu, 0.1, { ease:Quad.easeOut, onComplete:OnTweenAttentionJump, onCompleteParams:[aJumpAmount],
					//y:(mDefaultY - 25), scaleX:(mDefaultScale * 0.9), scaleY:(mDefaultScale * 1.1) });
			//}
			//else
			//{
				//TweenLite.to(mLevel.Lucu, 0.1, { ease:Quad.easeOut, delay:2, onComplete:OnTweenAttentionJump, onCompleteParams:[0],
					//y:(mDefaultY - 25), scaleX:(mDefaultScale * 0.9), scaleY:(mDefaultScale * 1.1) });
			//}
		//}
		
		//private function OnClickLucu(aEvent:MouseEvent):void
		//{
			//dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		//}
		//
		//private function OnClickNPC(aEvent:MouseEvent):void
		//{
			//dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		//}
		
		private function OnClickDialogBox(aEvent:MouseEvent):void
		{
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}