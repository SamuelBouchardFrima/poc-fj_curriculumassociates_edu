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
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.Sound;
	
	public class UseItem extends QuestStep
	{
		private var mTemplate:UseItemTemplate;
		private var mDialogBox:Box;
		private var mItem:Sprite;
		
		public function UseItem(aTemplate:UseItemTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			graphics.beginFill(0x000000, 0);
			graphics.drawRect(0, 0, 1024, 768);
			graphics.endFill();
			
			mLevel.NPC.addEventListener(MouseEvent.CLICK, OnClickNPC);
			
			mDialogBox = new CurvedBox(new Point(800, 60), Palette.DIALOG_BOX, new BoxLabel(mTemplate.Instruction, 45,
				Palette.DIALOG_CONTENT), 12, Direction.TOP_LEFT, Axis.BOTH);
			mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
			mDialogBox.y = mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2);
			addChild(mDialogBox);
			
			mItem = new Sprite();
			mItem.mouseEnabled = false;
			mItem.x = mouseX;
			mItem.y = mouseY;
			mItem.scaleX = mItem.scaleY = 0.01;
			var itemBitmap:Bitmap = new mTemplate.ItemAsset() as Bitmap;
			itemBitmap.x = -itemBitmap.width / 2;
			itemBitmap.y = -itemBitmap.height / 2;
			mItem.addChild(itemBitmap);
			addChild(mItem);
			TweenLite.to(mItem, 1, { ease:Elastic.easeOut, scaleX:0.25, scaleY:0.25 });
			
			addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
		}
		
		override public function Dispose():void
		{
			super.Dispose();
		}
		
		private function OnMouseMove(aEvent:MouseEvent):void
		{
			TweenLite.to(mItem, 0.8, { ease:Elastic.easeOut, x:mouseX, y:mouseY });
		}
		
		private function OnClickNPC(aEvent:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			mLevel.NPC.removeEventListener(MouseEvent.CLICK, OnClickNPC);
			
			TweenLite.to(mItem, 0.5, { ease:Strong.easeOut, onComplete:OnTweenItemGiven,
				x:mouseX, y:mouseY, scaleX:0.5, scaleY:0.5, alpha:0 });
		}
		
		private function OnTweenItemGiven():void
		{
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}