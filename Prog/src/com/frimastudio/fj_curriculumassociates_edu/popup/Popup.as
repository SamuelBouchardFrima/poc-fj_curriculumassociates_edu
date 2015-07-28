package com.frimastudio.fj_curriculumassociates_edu.popup
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStep;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxIcon;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Popup extends QuestStep
	{
		public function Popup(aTemplate:PopupTemplate)
		{
			super(aTemplate);
			
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
			addChild(mWildLucu);
		}
		
		override public function Dispose():void 
		{
			super.Dispose();
		}
	}
}