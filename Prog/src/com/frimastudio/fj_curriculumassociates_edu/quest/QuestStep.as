package com.frimastudio.fj_curriculumassociates_edu.quest
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import flash.display.Sprite;
	
	public class QuestStep extends Sprite
	{
		protected var mLevel:Level;
		
		public function QuestStep(aTemplate:QuestStepTemplate)
		{
			super();
			
			mLevel = aTemplate.StepLevel;
			addChild(mLevel);
		}
		
		public function Dispose():void
		{
			mLevel.Reset();
		}
	}
}