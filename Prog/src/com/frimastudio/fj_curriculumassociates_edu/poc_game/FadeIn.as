package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStep;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class FadeIn extends QuestStep
	{
		private var mTemplate:FadeInTemplate;
		private var mBlocker:Sprite;
		
		public function FadeIn(aTemplate:FadeInTemplate)
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
			
			InitializeMap(false);
			InitializeWildLucu(false);
			
			mBlocker = new Sprite();
			mBlocker.graphics.beginFill(0x000000, 1);
			mBlocker.graphics.drawRect(0, 0, 1024, 768);
			mBlocker.addEventListener(MouseEvent.CLICK, OnClickBlocker);
			addChild(mBlocker);
			TweenLite.to(mBlocker, 1, { ease:Strong.easeIn, onComplete:OnTweenHideBlocker, alpha:0 });
		}
		
		override public function Dispose():void 
		{
			mBlocker.removeEventListener(MouseEvent.CLICK, OnClickBlocker);
			
			super.Dispose();
		}
		
		private function OnClickBlocker(aEvent:MouseEvent):void
		{
		}
		
		private function OnTweenHideBlocker():void
		{
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}