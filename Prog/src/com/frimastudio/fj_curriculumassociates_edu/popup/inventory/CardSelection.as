package com.frimastudio.fj_curriculumassociates_edu.popup.inventory
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.inventory.CardType;
	import com.frimastudio.fj_curriculumassociates_edu.inventory.Inventory;
	import com.frimastudio.fj_curriculumassociates_edu.popup.Popup;
	import com.frimastudio.fj_curriculumassociates_edu.popup.PopupTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.sound.SoundManager;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxIcon;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class CardSelection extends Popup
	{
		private var mTemplate:CardSelectionTemplate;
		private var mCardList:Vector.<CurvedBox>;
		//private var mSlotList:Vector.<CurvedBox>;
		private var mContinueBtn:CurvedBox;
		//private var mSlotContainer:Sprite;
		private var mSlotList:Vector.<String>;
		
		public function CardSelection(aTemplate:CardSelectionTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			graphics.beginFill(0x000000, 0);
			graphics.drawRect(0, 0, 1024, 768);
			graphics.endFill();
			
			var background:CurvedBox = new CurvedBox(new Point(600, 400), Palette.DIALOG_BOX);
			background.x = 512;
			background.y = 384;
			addChild(background);
			
			//var title:TextField = new TextField();
			//title.embedFonts = true;
			//title.selectable = false;
			//title.autoSize = TextFieldAutoSize.CENTER;
			////switch (mTemplate.Type)
			////{
				////case CardType.LETTER_PATTERN:
					////title.text = "Letter Pattern Cards";
					////break;
				////default:
					////throw new Error("Card type " + mTemplate.Type.Description + " not handled.");
					////break;
			////}
			//title.text = "Wild Lucu Taming";
			//title.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 60, Palette.DIALOG_CONTENT,
				//null, null, null, null, null, TextFormatAlign.CENTER));
			//title.x = 512 - (title.width / 2);
			//addChild(title);
			
			var offset:Number;
			var i:int, endi:int;
			
			mCardList = new Vector.<CurvedBox>();
			var cardList:Vector.<String> = new <String>["id", "it", "ip", "in", "im"];
			var cardContainer:Sprite = new Sprite();
			var card:CurvedBox;
			offset = 0;
			for (i = 0, endi = cardList.length; i < endi; ++i)
			{
				card = new CurvedBox(new Point(60, 60), 0xCC99FF,
					new BoxLabel(cardList[i], 45, Palette.DIALOG_CONTENT), 6, null, Axis.HORIZONTAL);
				card.ColorBorderOnly = true;
				offset += card.width / 2;
				card.x = offset;
				card.y = 0;
				card.addEventListener(MouseEvent.CLICK, OnClickCard);
				offset += (card.width / 2) + 10;
				cardContainer.addChild(card);
				mCardList.push(card);
			}
			cardContainer.x = 512 - (cardContainer.width / 2);
			addChild(cardContainer);
			
			var body:TextField = new TextField();
			body.embedFonts = true;
			body.selectable = false;
			body.width = background.width;
			body.wordWrap = true;
			body.multiline = true;
			body.autoSize = TextFieldAutoSize.CENTER;
			//body.text = "Choose " + mTemplate.Slot + " cards";
			body.text = "Select " + mTemplate.Slot + " lesson cards.";
			body.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 48, Palette.DIALOG_CONTENT,
				null, null, null, null, null, TextFormatAlign.CENTER));
			body.x = 512 - (body.width / 2);
			addChild(body);
			
			mSlotList = new Vector.<String>();
			
			//mSlotList = new Vector.<CurvedBox>();
			//mSlotContainer = new Sprite();
			//var slot:CurvedBox;
			//offset = 0;
			//for (i = 0, endi = mTemplate.Slot; i < endi; ++i)
			//{
				//slot = new CurvedBox(new Point(60, 60), 0xCCCCCC, null, 6, null, Axis.HORIZONTAL);
				//offset += slot.width / 2;
				//slot.x = offset;
				//slot.y = 0;
				//offset += (slot.width / 2) + 10;
				//mSlotContainer.addChild(slot);
				//mSlotList.push(slot);
			//}
			//mSlotContainer.x = 512 - (mSlotContainer.width / 2);
			//addChild(mSlotContainer);
			
			//background.Size = new Point(Math.max(background.width, title.width, cardContainer.width,
			background.Size = new Point(Math.max(background.width, cardContainer.width,
				//body.width, mSlotContainer.width), background.height);
				body.width), background.height);
			
			mContinueBtn = new CurvedBox(new Point(64, 64), 0xCCCCCC, new BoxIcon(Asset.IconOKBitmap, Palette.BTN_CONTENT), 6);
			mContinueBtn.x = 512 + (background.width / 2) - 10 - (mContinueBtn.width / 2);
			addChild(mContinueBtn);
			
			//var space:Number = (background.height - (title.height + cardContainer.height + body.height +
			//var space:Number = (background.height - (cardContainer.height + body.height +
			var space:Number = (background.height - (cardContainer.height + body.height)) / 4;
				//mSlotContainer.height + mContinueBtn.height)) / 6;
				//mContinueBtn.height)) / 6;
			//title.y = 384 - (background.height / 2) + space;
			//cardContainer.y = title.y + title.height + space + (cardContainer.height / 2);
			//cardContainer.y = 384 - (background.height / 2) + space + (cardContainer.height / 2);
			//body.y = cardContainer.y + (cardContainer.height / 2) + space;
			body.y = 384 - (background.height / 2) + space + (cardContainer.height / 2);
			cardContainer.y = body.y + body.height + space + (cardContainer.height / 2);
			//mSlotContainer.y = body.y + body.height + space + (mSlotContainer.height / 2);
			//mContinueBtn.y = mSlotContainer.y + (mSlotContainer.height / 2) + space + (mContinueBtn.height / 2);
			//mContinueBtn.y = body.y + body.height + space + (mContinueBtn.height / 2);
			//mContinueBtn.y = cardContainer.y + (cardContainer.height / 2) + space + (mContinueBtn.height / 2);
			mContinueBtn.y = cardContainer.y;
			
			SoundManager.PlayVO(Asset.NewHintSound[2]);
			
			//background.Size = new Point(background.width, Math.max(background.height,
				////mContinueBtn.y + (mContinueBtn.height / 2) - title.y));
				//mContinueBtn.y + (mContinueBtn.height / 2)));
		}
		
		override public function Dispose():void
		{
			var i:int, endi:int;
			for (i = 0, endi = mCardList.length; i < endi; ++i)
			{
				mCardList[i].removeEventListener(MouseEvent.CLICK, OnClickCard);
			}
			//for (i = 0, endi = mSlotList.length; i < endi; ++i)
			//{
				//mSlotList[i].removeEventListener(MouseEvent.CLICK, OnClickSlot);
			//}
			
			mContinueBtn.removeEventListener(MouseEvent.CLICK, OnClickCompleteBtn);
			
			super.Dispose();
		}
		
		private function OnClickCard(aEvent:MouseEvent):void
		{
			var card:CurvedBox = aEvent.currentTarget as CurvedBox;
			
			if (Asset.NewChunkSound["_" + card.Label])
			{
				//(new Asset.NewChunkSound["_" + card.Label]() as Sound).play();
				//SoundManager.PlayVO(Asset.NewChunkSound["_" + card.Label]);
				SoundManager.PlaySFX(Asset.NewChunkSound["_" + card.Label]);
			}
			else if (Asset.WordContentSound["_" + card.Label])
			{
				//(new Asset.WordContentSound["_" + card.Label]() as Sound).play();
				//SoundManager.PlayVO(Asset.WordContentSound["_" + card.Label]);
				SoundManager.PlaySFX(Asset.WordContentSound["_" + card.Label]);
			}
			else if (Asset.NewWordSound["_" + card.Label])
			{
				//(new Asset.NewWordSound["_" + card.Label]() as Sound).play();
				//SoundManager.PlayVO(Asset.NewWordSound["_" + card.Label]);
				SoundManager.PlaySFX(Asset.NewWordSound["_" + card.Label]);
			}
			else
			{
				trace("Warning: sound " + card.Label + " could not be found.");
			}
			
			if (!card.ColorBorderOnly)
			{
				//card.ColorBorderOnly = false;
				card.ColorBorderOnly = true;
				mSlotList.splice(mSlotList.indexOf(card.Label), 1);
				
				mContinueBtn.BoxColor = 0xCCCCCC;
				mContinueBtn.removeEventListener(MouseEvent.CLICK, OnClickCompleteBtn);
			}
			else if (mSlotList.length < mTemplate.Slot)
			{
				mSlotList.push(card.Label);
				
				//card.ColorBorderOnly = true;
				card.ColorBorderOnly = false;
				
				if (mSlotList.length >= mTemplate.Slot)
				{
					mContinueBtn.BoxColor = Palette.GREAT_BTN;
					mContinueBtn.addEventListener(MouseEvent.CLICK, OnClickCompleteBtn);
				}
			}
			
			//var i:int, endi:int;
			//for (i = 0, endi = mSlotList.length; i < endi; ++i)
			//{
				//if (mSlotList[i].Label == "")
				//{
					//mSlotList[i].Content = new BoxLabel(card.Label, 45, Palette.DIALOG_CONTENT);
					//mSlotList[i].BoxColor = 0xCC99FF;
					//mSlotList[i].ColorBorderOnly = true;
					//mSlotList[i].addEventListener(MouseEvent.CLICK, OnClickSlot);
					//
					//card.ColorBorderOnly = false;
					////card.BoxColor = 0xCCCCCC;
					//card.removeEventListener(MouseEvent.CLICK, OnClickCard);
					//
					//break;
				//}
			//}
			
			//var complete:Boolean = true;
			//var offset:int = 0;
			//for (i = 0, endi = mSlotList.length; i < endi; ++i)
			//{
				//if (mSlotList[i].Label == "")
				//{
					//complete = false;
				//}
				//
				//offset += mSlotList[i].width / 2;
				//mSlotList[i].x = offset;
				//offset += (mSlotList[i].width / 2) + 10;
			//}
			//mSlotContainer.x = 512 - (mSlotContainer.width / 2);
			
			//if (complete)
			//{
				//mContinueBtn.BoxColor = Palette.GREAT_BTN;
				//mContinueBtn.addEventListener(MouseEvent.CLICK, OnClickCompleteBtn);
			//}
		}
		
		//private function OnClickSlot(aEvent:MouseEvent):void
		//{
			//var slot:CurvedBox = aEvent.currentTarget as CurvedBox;
			//
			//var incomplete:Boolean = false;
			//for (var i:int = 0, endi:int = mCardList.length; i < endi; ++i)
			//{
				//if (mCardList[i].Label == slot.Label)
				//{
					//mCardList[i].ColorBorderOnly = true;
					////mCardList[i].BoxColor = 0xCC99FF;
					//mCardList[i].addEventListener(MouseEvent.CLICK, OnClickCard);
					//
					//slot.Content = null;
					//slot.BoxColor = 0xCCCCCC;
					//slot.ColorBorderOnly = false;
					//slot.removeEventListener(MouseEvent.CLICK, OnClickSlot);
					//
					//incomplete = true;
					//
					//break;
				//}
			//}
			//
			//var offset:int = 0;
			////for (i = 0, endi = mSlotList.length; i < endi; ++i)
			////{
				////offset += mSlotList[i].width / 2;
				////mSlotList[i].x = offset;
				////offset += (mSlotList[i].width / 2) + 10;
			////}
			////mSlotContainer.x = 512 - (mSlotContainer.width / 2);
			//
			//if (incomplete)
			//{
				//mContinueBtn.BoxColor = 0xCCCCCC;
				//mContinueBtn.removeEventListener(MouseEvent.CLICK, OnClickCompleteBtn);
			//}
		//}
		
		private function OnClickCompleteBtn(aEvent:MouseEvent):void
		{
			//var slotList:Vector.<String> = new Vector.<String>();
			//for (var i:int = 0, endi:int = mSlotList.length; i < endi; ++i)
			//{
				//slotList.push(mSlotList[i].Label);
			//}
			
			//Inventory.SelectLetterPatternCardList(slotList);
			Inventory.SelectLetterPatternCardList(mSlotList);
			
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}