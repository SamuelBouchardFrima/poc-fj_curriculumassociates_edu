package com.frimastudio.fj_curriculumassociates_edu.popup.itemunlocked
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.popup.Popup;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.sound.SoundManager;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class ItemUnlocked extends Popup
	{
		private var mTemplate:ItemUnlockedTemplate;
		
		public function ItemUnlocked(aTemplate:ItemUnlockedTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			graphics.beginFill(0x000000, 0);
			graphics.drawRect(0, 0, 1024, 768);
			graphics.endFill();
			
			var background:Sprite = new Sprite();
			background.x = 512;
			background.y = 384;
			var backgroundBitmap:Bitmap = new Asset.UnlockPopupBitmap() as Bitmap;
			backgroundBitmap.smoothing = true;
			backgroundBitmap.x = -backgroundBitmap.width / 2;
			backgroundBitmap.y = -backgroundBitmap.height / 2;
			background.addChild(backgroundBitmap);
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.color = 0xFFCC66;
			background.transform.colorTransform = colorTransform;
			addChild(background);
			
			var title:TextField = new TextField();
			title.embedFonts = true;
			title.selectable = false;
			title.width = 400;
			title.wordWrap = true;
			title.multiline = true;
			title.autoSize = TextFieldAutoSize.CENTER;
			title.text = mTemplate.Title;
			title.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 48, Palette.DIALOG_CONTENT,
				null, null, null, null, null, TextFormatAlign.CENTER));
			title.x = 512 - (title.width / 2);
			//title.y = 384 - (title.height / 2);
			addChild(title);
			
			var item:Sprite = new Sprite();
			item.x = 512;
			//item.y = 384;
			var itemBitmap:Bitmap = new mTemplate.ItemAsset() as Bitmap;
			itemBitmap.smoothing = true;
			itemBitmap.width = Math.min(itemBitmap.width, 150);
			itemBitmap.height = Math.min(itemBitmap.height, 150);
			itemBitmap.scaleX = itemBitmap.scaleY = Math.max(itemBitmap.scaleX, itemBitmap.scaleY);
			itemBitmap.x = -itemBitmap.width / 2;
			itemBitmap.y = -itemBitmap.height / 2;
			item.addChild(itemBitmap);
			addChild(item);
			
			var space:Number = (background.height - (title.height + item.height)) / 2;
			title.y = 384 - (background.height / 2) + space;
			item.y = title.y + title.height + (item.height / 2);
			
			background.width = Math.max(background.width, title.width + 180);
			//background.height = Math.max(background.height, title.height + item.height + (space * 2) + 150);
			background.scaleX = background.scaleY = Math.max(background.scaleX, background.scaleY);
			
			addEventListener(MouseEvent.CLICK, OnClick);
			
			//(new mTemplate.VO() as Sound).play();
			SoundManager.PlayVO(mTemplate.VO);
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