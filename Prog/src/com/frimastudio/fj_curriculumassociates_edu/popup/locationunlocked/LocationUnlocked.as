package com.frimastudio.fj_curriculumassociates_edu.popup.locationunlocked
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.popup.Popup;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class LocationUnlocked extends Popup
	{
		private var mTemplate:LocationUnlockedTemplate;
		
		public function LocationUnlocked(aTemplate:LocationUnlockedTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			graphics.beginFill(0x000000, 0);
			graphics.drawRect(0, 0, 1024, 768);
			graphics.endFill();
			
			var background:Sprite = new Sprite();
			var backgroundBitmap:Bitmap = new Asset.UnlockPopupBitmap() as Bitmap;
			backgroundBitmap.smoothing = true;
			backgroundBitmap.x = -backgroundBitmap.width / 2;
			backgroundBitmap.y = -backgroundBitmap.height / 2;
			background.addChild(backgroundBitmap);
			background.x = 512;
			background.y = 384;
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.color = 0xFFCC66;
			background.transform.colorTransform = colorTransform;
			addChild(background);
			
			var title:TextField = new TextField();
			title.embedFonts = true;
			title.width = 400;
			title.wordWrap = true;
			title.multiline = true;
			title.autoSize = TextFieldAutoSize.CENTER;
			title.text = mTemplate.Title;
			title.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 60, Palette.DIALOG_CONTENT,
				null, null, null, null, null, TextFormatAlign.CENTER));
			title.x = 512 - (title.width / 2);
			title.y = 384 - (title.height / 2);
			addChild(title);
			
			background.width = Math.max(background.width, title.width + 180);
			background.scaleX = background.scaleY = Math.max(background.scaleX, background.scaleY);
			
			addEventListener(MouseEvent.CLICK, OnClick);
		}
		
		override public function Dispose():void
		{
			removeEventListener(MouseEvent.CLICK, OnClick);
			
			super.Dispose();
		}
		
		private function OnClick(aEvent:MouseEvent):void
		{
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}