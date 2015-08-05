package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class ResetPOCTemplate extends QuestStepTemplate
	{
		public function ResetPOCTemplate(aStepLevel:Level)
		{
			super(aStepLevel);
			
			mStepClass = ResetPOC;
		}
	}
}