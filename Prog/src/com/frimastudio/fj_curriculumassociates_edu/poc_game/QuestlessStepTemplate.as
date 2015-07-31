package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class QuestlessStepTemplate extends QuestStepTemplate
	{
		public function QuestlessStepTemplate(aStepLevel:Level = null)
		{
			super(aStepLevel);
			
			mStepClass = QuestlessStep;
		}
	}
}