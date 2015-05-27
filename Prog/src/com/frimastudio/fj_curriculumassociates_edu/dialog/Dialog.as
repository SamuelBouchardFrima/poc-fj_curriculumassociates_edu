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
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class Dialog extends QuestStep
	{
		private var mTemplate:DialogTemplate;
		private var mStep:int;
		private var mNPC:Bitmap;
		private var mDialogBox:Box;
		private var mContinueBtn:CurvedBox;
		
		public function Dialog(aTemplate:DialogTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			mStep = 0;
			
			mNPC = new mTemplate.NPCAsset();
			mNPC.x = 30;
			mNPC.y = 40;
			addChild(mNPC);
			
			var toolTrayBox:Box = new Box(new Point(1024, 90), Palette.TOOL_BOX);
			toolTrayBox.x = 512;
			toolTrayBox.y = 723;
			addChild(toolTrayBox);
			
			var craftingTrayBox:Box = new Box(new Point(1024, 90), Palette.CRAFTING_BOX);
			craftingTrayBox.x = 512;
			craftingTrayBox.y = 633;
			addChild(craftingTrayBox);
			
			var dialog:String = mTemplate.DialogList[mStep];
			if (mTemplate.DialogList.length > 1)
			{
				dialog += "\n...";
			}
			
			mDialogBox = new Box(new Point(584, 160), Palette.DIALOG_BOX, new BoxLabel(dialog, 72,
				Palette.DIALOG_CONTENT), 12, Direction.LEFT, Axis.VERTICAL);
			mDialogBox.x = 640;
			mDialogBox.y = 50 + (mDialogBox.height / 2);
			mDialogBox.addEventListener(MouseEvent.CLICK, OnClickDialogBox);
			addChild(mDialogBox);
			
			mContinueBtn = new CurvedBox(new Point(64, 64), Palette.GREAT_BTN,
				new BoxIcon(Asset.IconOKBitmap, Palette.BTN_CONTENT), 12);
			mContinueBtn.x = 982;
			mContinueBtn.y = 633;
		}
		
		override public function Dispose():void
		{
			mDialogBox.removeEventListener(MouseEvent.CLICK, OnClickDialogBox);
			
			mContinueBtn.removeEventListener(MouseEvent.CLICK, OnClickContinueBtn);
			
			super.Dispose();
		}
		
		private function OnClickDialogBox(aEvent:MouseEvent):void
		{
			++mStep;
			
			var dialog:String = mTemplate.DialogList[mStep];
			
			if (mStep < mTemplate.DialogList.length - 1)
			{
				dialog += "\n...";
			}
			else
			{
				mDialogBox.removeEventListener(MouseEvent.CLICK, OnClickDialogBox);
				
				mContinueBtn.addEventListener(MouseEvent.CLICK, OnClickContinueBtn);
				addChild(mContinueBtn);
			}
			
			mDialogBox.Content = new BoxLabel(dialog, 72, Palette.DIALOG_CONTENT);
			mDialogBox.y = 50 + (mDialogBox.height / 2);
		}
		
		private function OnClickContinueBtn(aEvent:MouseEvent):void
		{
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}