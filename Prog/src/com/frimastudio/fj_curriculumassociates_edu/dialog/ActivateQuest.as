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
			
			TweenLite.to(mLevel.Lucu, 0.1, { ease:Quad.easeOut, delay:2, onComplete:OnTweenAttentionJump,
				onCompleteParams:[0], y:(mDefaultY - 25), scaleX:(mDefaultScale * 0.9), scaleY:(mDefaultScale * 1.1) });
			mLevel.Lucu.addEventListener(MouseEvent.CLICK, OnClickLucu);
			
			mDialogBox = new CurvedBox(new Point(100, 100), Palette.DIALOG_BOX,
				new BoxLabel("!", 80, Palette.DIALOG_CONTENT), 3, Direction.UP_LEFT);
			mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
			mDialogBox.y = mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2);
			mDialogBox.addEventListener(MouseEvent.CLICK, OnClickDialogBox);
			addChild(mDialogBox);
			
			mDialogBox.filters = [new GlowFilter(Palette.GREAT_BTN, 0, 16, 16, 2, BitmapFilterQuality.HIGH, true)];
			TweenLite.to(mDialogBox, 1, { ease:Quad.easeInOut, delay:2, onComplete:OnTweenGlowStrong, glowFilter: { alpha:1.5 } });
		}
		
		override public function Dispose():void
		{
			//mDisposing = true;
			
			mLevel.Lucu.removeEventListener(MouseEvent.CLICK, OnClickLucu);
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
		
		private function OnTweenAttentionJump(aJumpAmount:int):void
		{
			//if (mDisposing)
			//{
				//mLevel.Lucu.y = aDefaultY;
				//mLevel.Lucu.scaleX = mLevel.Lucu.scaleY = aDefaultScale;
				//TweenLite.killTweensOf(mLevel.Lucu);
				//return;
			//}
			
			TweenLite.to(mLevel.Lucu, 0.4, { ease:Bounce.easeOut, onComplete:OnTweenAttentionBounce, onCompleteParams:[aJumpAmount],
				y:mDefaultY, scaleX:mDefaultScale, scaleY:mDefaultScale });
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
		
		private function OnClickLucu(aEvent:MouseEvent):void
		{
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
		
		private function OnClickDialogBox(aEvent:MouseEvent):void
		{
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}