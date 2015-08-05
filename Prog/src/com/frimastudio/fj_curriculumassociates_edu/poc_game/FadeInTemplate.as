package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class FadeInTemplate extends QuestStepTemplate
	{
		public function FadeInTemplate(aStepLevel:Level)
		{
			super(aStepLevel);
			
			mStepClass = FadeIn;
		}
	}
}