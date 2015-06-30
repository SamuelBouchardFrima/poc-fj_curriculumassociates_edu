package com.frimastudio.fj_curriculumassociates_edu.popup.reward
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.popup.Popup;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	public class Reward extends Popup
	{
		private var mTemplate:RewardTemplate;
		
		public function Reward(aTemplate:RewardTemplate)
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
			
			var title:TextField = new TextField();
			title.embedFonts = true;
			title.autoSize = TextFieldAutoSize.CENTER;
			title.text = mTemplate.Title;
			title.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 60, Palette.DIALOG_CONTENT,
				null, null, null, null, null, TextFormatAlign.CENTER));
			title.x = 512 - (title.width / 2);
			addChild(title);
			
			background.Size = new Point(Math.max(background.width, title.width), background.height);
			
			var body:TextField = new TextField();
			body.embedFonts = true;
			body.width = background.width;
			body.wordWrap = true;
			body.multiline = true;
			body.autoSize = TextFieldAutoSize.CENTER;
			body.text = mTemplate.Body;
			body.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 48, Palette.DIALOG_CONTENT,
				null, null, null, null, null, TextFormatAlign.CENTER));
			body.x = 512 - (body.width / 2);
			addChild(body);
			
			var rewardContainer:Sprite = new Sprite();
			var reward:CurvedBox;
			var offset:Number = 0;
			for (var i:int = 0, endi:int = mTemplate.RewardList.length; i < endi; ++i)
			{
				reward = new CurvedBox(new Point(60, 60), 0xCCCCCC,
					new BoxLabel(mTemplate.RewardList[i], 48, Palette.DIALOG_CONTENT), 12, null, Axis.HORIZONTAL);
				offset += reward.width / 2;
				reward.x = offset;
				reward.y = 0;
				offset += 10 + (reward.width / 2);
				rewardContainer.addChild(reward);
			}
			rewardContainer.x = 512 - (rewardContainer.width / 2);
			addChild(rewardContainer);
			
			var space:Number = (background.height - (title.height + body.height + rewardContainer.y)) / 3;
			title.y = 384 - (background.height / 2) + space;
			body.y = title.y + title.height;
			rewardContainer.y = body.y + body.height + (space / 2);
			
			addEventListener(MouseEvent.CLICK, OnClick);
			
			var sound:Sound = new mTemplate.VO() as Sound;
			sound.play();
			
			var earRewardTypeTimer:Timer = new Timer(sound.length, 1);
			earRewardTypeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnEarRewardTypeTimerComplete);
		}
		
		override public function Dispose():void
		{
			removeEventListener(MouseEvent.CLICK, OnClick);
			
			super.Dispose();
		}
		
		private function OnEarRewardTypeTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnEarRewardTypeTimerComplete);
			
			(new Asset.RewardSound[5]() as Sound).play();
		}
		
		private function OnClick(aEvent:MouseEvent):void
		{
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}