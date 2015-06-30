package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityBox;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityBoxEvent;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStep;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
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
	import flash.media.Sound;
	
	public class SelectActivity extends QuestStep
	{
		private var mTemplate:SelectActivityTemplate;
		private var mDialogBox:CurvedBox;
		private var mActivityBox:ActivityBox;
		
		public function SelectActivity(aTemplate:SelectActivityTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			mActivityBox = new ActivityBox(mTemplate.ActivityWordList, mTemplate.LineBreakList, mTemplate.ActivityVO,
				mTemplate.PhylacteryArrow, false, true);
			mActivityBox.x = 512;
			mActivityBox.y = ((mTemplate.LineBreakList.length + 1) * 40) + 30;
			
			var message:String = "Click the sentence.";
			
			if (mTemplate.SelectWholeBox)
			{
				mActivityBox.filters = [new GlowFilter(Palette.GREAT_BTN, 0, 16, 16, 2, BitmapFilterQuality.HIGH, true)];
				TweenLite.to(mActivityBox, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowStrong, glowFilter: { alpha:0.75 } });
				//mActivityBox.addEventListener(MouseEvent.CLICK, OnClickActivityBox);
				
				(new Asset.GameHintSound[10]() as Sound).play();
			}
			else
			{
				var activityFound:Boolean = false;
				for (var i:int = 0, endi:int = mTemplate.ActivityWordList.length; i < endi && !activityFound; ++i)
				{
					switch (mTemplate.ActivityWordList[i].ActivityToLaunch)
					{
						case ActivityType.WORD_UNSCRAMBLING:
							activityFound = true;
							message = "Click the scrambled word.";
							(new Asset.GameHintSound[26]() as Sound).play();
							break;
						case ActivityType.WORD_CRAFTING:
							activityFound = true;
							message = "Click the word.";
							(new Asset.GameHintSound[25]() as Sound).play();
							break;
						default:
							break;
					}
				}
				
				if (!activityFound)
				{
					throw new Error("Unable to find activity word to select.");
				}
			}
			
			mDialogBox = new CurvedBox(new Point(800, 60), Palette.DIALOG_BOX, new BoxLabel(message, 45,
				Palette.DIALOG_CONTENT), 12, Direction.UP_LEFT, Axis.BOTH);
			mDialogBox.x = mLevel.Lucu.x - (mLevel.Lucu.width / 2) + (mDialogBox.width / 2);
			mDialogBox.y = mLevel.Lucu.y + (mLevel.Lucu.height / 2) + 10 + (mDialogBox.height / 2);
			addChild(mDialogBox);
			
			addChild(mActivityBox);
			
			mActivityBox.addEventListener(ActivityBoxEvent.LAUNCH_ACTIVITY, OnLaunchActivity);
		}
		
		override public function Dispose():void
		{
			TweenLite.killTweensOf(mActivityBox);
			//mActivityBox.removeEventListener(MouseEvent.CLICK, OnClickActivityBox);
			mActivityBox.removeEventListener(ActivityBoxEvent.LAUNCH_ACTIVITY, OnLaunchActivity);
			mActivityBox.Dispose();
			
			super.Dispose();
		}
		
		private function OnTweenGlowStrong():void
		{
			TweenLite.to(mActivityBox, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowWeak, glowFilter:{ alpha:0.25 } });
		}
		
		private function OnTweenGlowWeak():void
		{
			TweenLite.to(mActivityBox, 1, { ease:Quad.easeInOut, onComplete:OnTweenGlowStrong, glowFilter:{ alpha:0.75 } });
		}
		
		//private function OnClickActivityBox(aEvent:MouseEvent):void
		//{
			//dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		//}
		
		private function OnLaunchActivity(aEvent:ActivityBoxEvent):void
		{
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}