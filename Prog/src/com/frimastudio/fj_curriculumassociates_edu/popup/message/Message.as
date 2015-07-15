package com.frimastudio.fj_curriculumassociates_edu.popup.message
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.popup.Popup;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	public class Message extends Popup
	{
		private var mTemplate:MessageTemplate;
		private var mPlayBodyVOTimer:Timer;
		
		public function Message(aTemplate:MessageTemplate)
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
			title.selectable = false;
			title.autoSize = TextFieldAutoSize.CENTER;
			title.text = mTemplate.Title;
			title.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 60, Palette.DIALOG_CONTENT,
				null, null, null, null, null, TextFormatAlign.CENTER));
			title.x = 512 - (title.width / 2);
			addChild(title);
			
			background.Size = new Point(Math.max(background.width, title.width), background.height);
			
			var body:TextField = new TextField();
			body.embedFonts = true;
			body.selectable = false;
			body.width = background.width;
			body.wordWrap = true;
			body.multiline = true;
			body.autoSize = TextFieldAutoSize.CENTER;
			body.text = mTemplate.Body;
			body.setTextFormat(new TextFormat(Asset.SweaterSchoolSemiBoldFont.fontName, 48, Palette.DIALOG_CONTENT,
				null, null, null, null, null, TextFormatAlign.CENTER));
			body.x = 512 - (body.width / 2);
			addChild(body);
			
			var space:Number = (background.height - (title.height + body.height)) / 2.5;
			title.y = 384 - (background.height / 2) + space;
			body.y = title.y + title.height + (space / 2);
			
			var sound:Sound = new mTemplate.TitleVO() as Sound;
			sound.play();
			
			mPlayBodyVOTimer = new Timer(sound.length, 1);
			mPlayBodyVOTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnPlayBodyVOTimerComplete);
			mPlayBodyVOTimer.start();
			
			addEventListener(MouseEvent.CLICK, OnClick);
		}
		
		override public function Dispose():void
		{
			mPlayBodyVOTimer.reset();
			mPlayBodyVOTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnPlayBodyVOTimerComplete);
			
			removeEventListener(MouseEvent.CLICK, OnClick);
			
			super.Dispose();
		}
		
		private function OnPlayBodyVOTimerComplete(aEvent:TimerEvent):void
		{
			mPlayBodyVOTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnPlayBodyVOTimerComplete);
			
			(new mTemplate.BodyVO() as Sound).play();
		}
		
		private function OnClick(aEvent:MouseEvent):void
		{
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}