package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.ActivityBox;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStep;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.sound.SoundManager;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.Box;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxIcon;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Quad;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.media.Sound;
	
	public class UseLevelProp extends QuestStep
	{
		private var mTemplate:UseLevelPropTemplate;
		private var mDialogBox:Box;
		private var mActivityBox:ActivityBox;
		//private var mDisposing:Boolean;
		private var mDefaultY:Number;
		private var mDefaultScale:Number;
		
		public function UseLevelProp(aTemplate:UseLevelPropTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			mDefaultY = mLevel.Prop.y;
			mDefaultScale = mLevel.Prop.scaleX;
			
			mLevel.Prop.filters = [new GlowFilter(Palette.GREAT_BTN, 0, 16, 16, 2, BitmapFilterQuality.HIGH)];
			TweenLite.to(mLevel.Prop, 1, { ease:Quad.easeInOut, delay:2, onComplete:OnTweenGlowStrong, glowFilter:{ alpha:1.5 } });
			//TweenLite.to(mLevel.Prop, 0.1, { ease:Quad.easeOut, delay:2, onComplete:OnTweenAttentionJump,
				//onCompleteParams:[0], y:(mDefaultY - 25), scaleX:(mDefaultScale * 0.9), scaleY:(mDefaultScale * 1.1) });
			mLevel.Prop.addEventListener(MouseEvent.CLICK, OnClickProp);
			
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
			mWildLucu = new Sprite();
			var wildLucuBitmap:Bitmap = new Asset.WildLucuIdleBitmap() as Bitmap;
			wildLucuBitmap.smoothing = true;
			wildLucuBitmap.scaleY = 0.5;
			wildLucuBitmap.scaleX = -wildLucuBitmap.scaleY;
			wildLucuBitmap.x = wildLucuBitmap.width / 2;
			wildLucuBitmap.y = -wildLucuBitmap.height / 2;
			mWildLucu.addChild(wildLucuBitmap);
			mWildLucu.x = 1014 - (mWildLucu.width / 2);
			mWildLucu.y = 758 - (mWildLucu.height / 2);
			mWildLucu.addEventListener(MouseEvent.CLICK, OnClickWildLucu);
			addChild(mWildLucu);
			
			mDialogBox = new CurvedBox(new Point(800, 60), Palette.DIALOG_BOX, new BoxLabel(mTemplate.Instruction, 45,
				Palette.DIALOG_CONTENT), 6, Direction.UP_LEFT, Axis.BOTH);
			mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
			mDialogBox.y = mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2);
			addChild(mDialogBox);
			
			mActivityBox = new ActivityBox(mTemplate.ActivityWordList, mTemplate.LineBreakList, mTemplate.InstructionVO,
				mTemplate.PhylacteryArrow);
			mActivityBox.x = 512;
			mActivityBox.y = ((mTemplate.LineBreakList.length + 1) * 40) + 30;
			addChild(mActivityBox);
			
			//(new mTemplate.InstructionVO() as Sound).play();
			SoundManager.PlayVO(mTemplate.InstructionVO);
		}
		
		override public function Dispose():void
		{
			//mWildLucuChallengeBtn.removeEventListener(MouseEvent.CLICK, OnClickWildLucuChallengeBtn);
			mWildLucu.removeEventListener(MouseEvent.CLICK, OnClickWildLucu);
			
			//mDisposing = true;
			
			TweenLite.killTweensOf(mLevel.Prop);
			mLevel.Prop.y = mDefaultY;
			mLevel.Prop.scaleX = mLevel.Prop.scaleY = mDefaultScale;
			mLevel.Prop.filters = [];
			mLevel.Prop.removeEventListener(MouseEvent.CLICK, OnClickProp);
			
			mActivityBox.Dispose();
			
			super.Dispose();
		}
		
		private function OnTweenGlowStrong():void
		{
			TweenLite.to(mLevel.Prop, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowWeak, glowFilter:{ alpha:0.25 } });
		}
		
		private function OnTweenGlowWeak():void
		{
			TweenLite.to(mLevel.Prop, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowStrong, glowFilter:{ alpha:0.75 } });
		}
		
		//private function OnTweenAttentionJump(aJumpAmount:int):void
		//{
			////if (mDisposing)
			////{
				////mLevel.Prop.y = aDefaultY;
				////mLevel.Prop.scaleX = mLevel.Prop.scaleY = aDefaultScale;
				////TweenLite.killTweensOf(mLevel.Prop);
				////return;
			////}
			//
			//TweenLite.to(mLevel.Prop, 0.4, { ease:Bounce.easeOut, onComplete:OnTweenAttentionBounce,
				//onCompleteParams:[aJumpAmount], y:mDefaultY, scaleX:mDefaultScale, scaleY:mDefaultScale });
		//}
		//
		//private function OnTweenAttentionBounce(aJumpAmount:int):void
		//{
			////if (mDisposing)
			////{
				////mLevel.Prop.y = aDefaultY;
				////mLevel.Prop.scaleX = mLevel.Prop.scaleY = aDefaultScale;
				////TweenLite.killTweensOf(mLevel.Prop);
				////return;
			////}
			//
			//++aJumpAmount;
			//if (aJumpAmount < 3)
			//{
				//TweenLite.to(mLevel.Prop, 0.1, { ease:Quad.easeOut, onComplete:OnTweenAttentionJump, onCompleteParams:[aJumpAmount],
					//y:(mDefaultY - 25), scaleX:(mDefaultScale * 0.9), scaleY:(mDefaultScale * 1.1) });
			//}
			//else
			//{
				//TweenLite.to(mLevel.Prop, 0.1, { ease:Quad.easeOut, delay:2, onComplete:OnTweenAttentionJump, onCompleteParams:[0],
					//y:(mDefaultY - 25), scaleX:(mDefaultScale * 0.9), scaleY:(mDefaultScale * 1.1) });
			//}
		//}
		
		private function OnClickProp(aEvent:MouseEvent):void
		{
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}