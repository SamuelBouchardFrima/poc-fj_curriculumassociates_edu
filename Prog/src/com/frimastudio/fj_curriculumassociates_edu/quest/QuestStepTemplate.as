package com.frimastudio.fj_curriculumassociates_edu.quest
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	
	public class QuestStepTemplate
	{
		protected var mStepLevel:Level;
		protected var mStepClass:Class;
		
		public function get StepLevel():Level	{ return mStepLevel; }
		public function get StepClass():Class	{ return mStepClass; }
		
		public function QuestStepTemplate(aStepLevel:Level = null)
		{
			mStepLevel = (aStepLevel ? aStepLevel : Level.NONE);
		}
	}
}