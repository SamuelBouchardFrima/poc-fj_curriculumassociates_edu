package com.frimastudio.fj_curriculumassociates_edu.popup.lucutamingreward
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.inventory.Inventory;
	import com.frimastudio.fj_curriculumassociates_edu.popup.Popup;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxIcon;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class LucuTamingReward extends Popup
	{
		private var mTemplate:LucuTamingRewardTemplate;
		private var mSubmitBtn:CurvedBox;
		private var mRewardList:Vector.<CurvedBox>;
		private var mSelectedRewardList:Vector.<CurvedBox>;
		
		public function LucuTamingReward(aTemplate:LucuTamingRewardTemplate)
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
			
			var body:TextField;
			if (!Inventory.SelectableLucuTamingWord)
			{
				body = new TextField();
				body.embedFonts = true;
				body.selectable = false;
				body.width = background.width;
				body.wordWrap = true;
				body.multiline = true;
				body.autoSize = TextFieldAutoSize.CENTER;
				body.text = "Better luck next time!";
				body.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 48, Palette.DIALOG_CONTENT,
					null, null, null, null, null, TextFormatAlign.CENTER));
				body.x = 512 - (body.width / 2);
				body.y = 384 - (body.height / 2);
				addChild(body);
				
				addEventListener(MouseEvent.CLICK, OnClick);
				return;
			}
			
			var title:TextField = new TextField();
			title.embedFonts = true;
			title.selectable = false;
			title.autoSize = TextFieldAutoSize.CENTER;
			title.text = "Challenge Reward";
			title.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 60, Palette.DIALOG_CONTENT,
				null, null, null, null, null, TextFormatAlign.CENTER));
			title.x = 512 - (title.width / 2);
			addChild(title);
			
			background.Size = new Point(Math.max(background.width, title.width), background.height);
			
			body = new TextField();
			body.embedFonts = true;
			body.selectable = false;
			body.width = background.width;
			body.wordWrap = true;
			body.multiline = true;
			body.autoSize = TextFieldAutoSize.CENTER;
			body.text = "Select " + Inventory.SelectableLucuTamingWord + " words:";
			body.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 48, Palette.DIALOG_CONTENT,
				null, null, null, null, null, TextFormatAlign.CENTER));
			body.x = 512 - (body.width / 2);
			addChild(body);
			
			mRewardList = new Vector.<CurvedBox>();
			var rewardContainer:Sprite = new Sprite();
			var reward:CurvedBox;
			var rewardColor:int = 0xCCCCCC;
			var offset:Point = new Point();
			for (var i:int = 0, endi:int = Inventory.CompletedLucuTamingWordList.length; i < endi; ++i)
			{
				reward = new CurvedBox(new Point(60, 60), rewardColor,
					new BoxLabel(Inventory.CompletedLucuTamingWordList[i], 45, Palette.DIALOG_CONTENT), 6, null, Axis.HORIZONTAL);
				reward.ColorBorderOnly = true;
				offset.x += reward.width / 2;
				reward.x = offset.x;
				reward.y = offset.y;
				if (reward.x >= background.width - 40 - (reward.width / 2) - 128)
				{
					offset.x = reward.width / 2;
					reward.x = offset.x;
					
					offset.y += 70;
					reward.y = offset.y;
				}
				offset.x += 10 + (reward.width / 2);
				reward.addEventListener(MouseEvent.CLICK, OnClickReward);
				rewardContainer.addChild(reward);
				mRewardList.push(reward);
			}
			rewardContainer.x = 512 - (rewardContainer.width / 2);
			addChild(rewardContainer);
			
			mSelectedRewardList = new Vector.<CurvedBox>();
			
			var space:Number = (background.height - (title.height + body.height + rewardContainer.height)) / 3;
			title.y = 384 - (background.height / 2) + space;
			body.y = title.y + title.height;
			rewardContainer.y = body.y + body.height + (space / 2) + 30;
			
			mSubmitBtn = new CurvedBox(new Point(64, 64), Palette.TOOL_BOX,
				new BoxIcon(Asset.IconOKBitmap, Palette.BTN_CONTENT), 6);
			mSubmitBtn.x = 512 + (background.width / 2) - 10 - (mSubmitBtn.width / 2);
			mSubmitBtn.y = rewardContainer.y + offset.y;
			addChild(mSubmitBtn);
		}
		
		override public function Dispose():void
		{
			removeEventListener(MouseEvent.CLICK, OnClick);
			
			if (mRewardList)
			{
				for (var i:int = 0, endi:int = mRewardList.length; i < endi; ++i)
				{
					mRewardList[i].removeEventListener(MouseEvent.CLICK, OnClickReward);
				}
			}
			
			if (mSubmitBtn)
			{
				mSubmitBtn.removeEventListener(MouseEvent.CLICK, OnClickSubmitBtn);
			}
			
			super.Dispose();
		}
		
		private function OnClick(aEvent:MouseEvent):void
		{
			Inventory.SelectedLetterPatternCardList.splice(0, Inventory.SelectedLetterPatternCardList.length);
			Inventory.SelectableLucuTamingWord = 0;
			
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
		
		private function OnClickReward(aEvent:MouseEvent):void
		{
			var reward:CurvedBox = aEvent.currentTarget as CurvedBox;
			if (mSelectedRewardList.indexOf(reward) > -1)
			{
				mSelectedRewardList.splice(mSelectedRewardList.indexOf(reward), 1);
				reward.ColorBorderOnly = true;
				
				mSubmitBtn.BoxColor = Palette.TOOL_BOX;
				mSubmitBtn.removeEventListener(MouseEvent.CLICK, OnClickSubmitBtn);
			}
			else if (mSelectedRewardList.length < Inventory.SelectableLucuTamingWord)
			{
				mSelectedRewardList.push(reward);
				reward.ColorBorderOnly = false;
				
				if (mSelectedRewardList.length >= Inventory.SelectableLucuTamingWord)
				{
					mSubmitBtn.BoxColor = Palette.GREAT_BTN;
					mSubmitBtn.addEventListener(MouseEvent.CLICK, OnClickSubmitBtn);
				}
			}
		}
		
		private function OnClickSubmitBtn(aEvent:MouseEvent):void
		{
			for (var i:int = 0, endi:int = mSelectedRewardList.length; i < endi; ++i)
			{
				Inventory.AddWord(mSelectedRewardList[i].Label);
			}
			Inventory.SelectedLetterPatternCardList.splice(0, Inventory.SelectedLetterPatternCardList.length);
			Inventory.SelectableLucuTamingWord = 0;
			
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}