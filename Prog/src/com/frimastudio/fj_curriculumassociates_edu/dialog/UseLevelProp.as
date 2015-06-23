package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityBox;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStep;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.Box;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import com.greensock.easing.Quad;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	public class UseLevelProp extends QuestStep
	{
		private var mTemplate:UseLevelPropTemplate;
		private var mDialogBox:Box;
		private var mActivityBox:ActivityBox;
		
		public function UseLevelProp(aTemplate:UseLevelPropTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			mLevel.Prop.filters = [new GlowFilter(Palette.GREAT_BTN, 0, 16, 16, 2, BitmapFilterQuality.HIGH)];
			TweenLite.to(mLevel.Prop, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowStrong, glowFilter: { alpha:0.75 } });
			mLevel.Prop.addEventListener(MouseEvent.CLICK, OnClickProp);
			
			mDialogBox = new CurvedBox(new Point(800, 60), Palette.DIALOG_BOX, new BoxLabel(mTemplate.Instruction, 45,
				Palette.DIALOG_CONTENT), 12, Direction.TOP_LEFT, Axis.BOTH);
			mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
			mDialogBox.y = mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2);
			addChild(mDialogBox);
			
			mActivityBox = new ActivityBox(mTemplate.ActivityWordList);
			mActivityBox.x = 512;
			mActivityBox.y = 110;
			addChild(mActivityBox);
		}
		
		override public function Dispose():void
		{
			TweenLite.killTweensOf(mLevel.Prop);
			mLevel.Prop.removeEventListener(MouseEvent.CLICK, OnClickProp);
			
			mActivityBox.Dispose();
			
			super.Dispose();
		}
		
		private function OnTweenGlowStrong():void
		{
			TweenLite.to(mLevel.Prop, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowWeak, glowFilter:{ alpha:0.25 } });
		}
		
		private function OnTweenGlowWeak():void
		{
			TweenLite.to(mLevel.Prop, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowStrong, glowFilter:{ alpha:0.75 } });
		}
		
		private function OnClickProp(aEvent:MouseEvent):void
		{
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}