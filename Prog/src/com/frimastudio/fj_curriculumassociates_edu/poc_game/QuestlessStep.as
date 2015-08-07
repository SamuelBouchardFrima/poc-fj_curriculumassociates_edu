package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStep;
	import com.frimastudio.fj_curriculumassociates_edu.sound.SoundManager;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	public class QuestlessStep extends QuestStep
	{
		private var mTemplate:QuestlessStepTemplate;
		private var mDialogBox:CurvedBox;
		
		public function QuestlessStep(aTemplate:QuestlessStepTemplate)
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
			
			InitializeMap();
			InitializeWildLucu();
			
			mDialogBox = new CurvedBox(new Point(800, 60), Palette.DIALOG_BOX, new BoxLabel("Tap the map.", 45,
				Palette.DIALOG_CONTENT), 6, Direction.UP_LEFT, Axis.BOTH);
			mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
			mDialogBox.y = mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2);
			addChild(mDialogBox);
			
			SoundManager.PlayVO(Asset.NewHintSound[9]);
			
			mMap.filters = [new GlowFilter(Palette.GREAT_BTN, 0, 16, 16, 4, BitmapFilterQuality.HIGH)];
			TweenLite.to(mMap, 2, { ease:Quad.easeOut, onComplete:OnTweenMapGlowStrong, glowFilter:{ alpha:0.75 } });
		}
		
		override public function Dispose():void
		{
			TweenLite.killTweensOf(mMap);
			mMap.filters = [];
			
			super.Dispose();
		}
		
		override public function Refresh():void 
		{
			SoundManager.PlayVO(Asset.NewHintSound[9]);
			
			super.Refresh();
		}
		
		private function OnTweenMapGlowStrong():void
		{
			TweenLite.to(mMap, 1, { ease:Quad.easeOut, onComplete:OnTweenMapGlowWeak, glowFilter:{ alpha:0.5 } });
		}
		
		private function OnTweenMapGlowWeak():void
		{
			TweenLite.to(mMap, 1, { ease:Quad.easeOut, onComplete:OnTweenMapGlowStrong, glowFilter:{ alpha:0.75 } });
		}
	}
}