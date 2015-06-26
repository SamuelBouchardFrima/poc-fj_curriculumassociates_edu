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
	import com.greensock.easing.Elastic;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	
	public class ActivateQuest extends QuestStep
	{
		private var mTemplate:ActivateQuestTemplate;
		private var mNPC:Sprite;
		private var mDialogBox:CurvedBox;
		
		public function ActivateQuest(aTemplate:ActivateQuestTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			mLevel.Lucu.addEventListener(MouseEvent.CLICK, OnClickLucu);
			
			mDialogBox = new CurvedBox(new Point(100, 100), Palette.DIALOG_BOX,
				new BoxLabel("!", 80, Palette.DIALOG_CONTENT), 12, Direction.UP_LEFT);
			mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
			mDialogBox.y = mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2);
			mDialogBox.addEventListener(MouseEvent.CLICK, OnClickDialogBox);
			addChild(mDialogBox);
		}
		
		override public function Dispose():void
		{
			mLevel.Lucu.removeEventListener(MouseEvent.CLICK, OnClickLucu);
			mDialogBox.removeEventListener(MouseEvent.CLICK, OnClickDialogBox);
			
			super.Dispose();
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