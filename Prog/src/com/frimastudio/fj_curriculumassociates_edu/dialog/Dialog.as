package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityBox;
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
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	
	public class Dialog extends QuestStep
	{
		private var mTemplate:DialogTemplate;
		private var mStep:int;
		private var mDialogBox:Box;
		private var mActivityBox:ActivityBox;
		
		public function Dialog(aTemplate:DialogTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			mStep = 0;
			
			mDialogBox = new CurvedBox(new Point(800, 60), Palette.DIALOG_BOX, new BoxLabel(mTemplate.DialogList[mStep], 45,
				Palette.DIALOG_CONTENT), 12, Direction.TOP_LEFT, Axis.BOTH);
			mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
			mDialogBox.y = mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2);
			addChild(mDialogBox);
			
			if (mTemplate.ActivityWordList)
			{
				mActivityBox = new ActivityBox(mTemplate.ActivityWordList);
				mActivityBox.x = 512;
				mActivityBox.y = 110;
				addChild(mActivityBox);
			}
			
			(new mTemplate.DialogAudioList[mStep]() as Sound).play();
			
			graphics.beginFill(0x000000, 0);
			graphics.drawRect(0, 0, 1024, 768);
			graphics.endFill();
			
			addEventListener(MouseEvent.CLICK, OnClick);
		}
		
		override public function Dispose():void
		{
			removeEventListener(MouseEvent.CLICK, OnClick);
			
			if (mActivityBox)
			{
				mActivityBox.Dispose();
			}
			
			super.Dispose();
		}
		
		private function OnClick(aEvent:MouseEvent):void
		{
			++mStep;
			
			if (mStep < mTemplate.DialogList.length)
			{
				mDialogBox.Content = new BoxLabel(mTemplate.DialogList[mStep], 45, Palette.DIALOG_CONTENT);
				mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
				mDialogBox.y = mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2);
				
				(new mTemplate.DialogAudioList[mStep]() as Sound).play();
			}
			else
			{
				dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
			}
		}
	}
}