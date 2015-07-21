package com.frimastudio.fj_curriculumassociates_edu.quest
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class QuestStep extends Sprite
	{
		protected var mLevel:Level;
		protected var mWildLucuChallengeBtn:CurvedBox;
		
		public function get StepLevel():Level	{ return mLevel; }
		
		public function QuestStep(aTemplate:QuestStepTemplate)
		{
			super();
			
			if (aTemplate.StepLevel)
			{
				mLevel = aTemplate.StepLevel;
				addChild(mLevel);
			}
		}
		
		public function Dispose():void
		{
			mLevel.Reset();
		}
		
		protected function OnClickWildLucuChallengeBtn(aEvent:MouseEvent):void
		{
			dispatchEvent(new QuestStepEvent(QuestStepEvent.LAUNCH_LUCU_TAMING));
		}
	}
}