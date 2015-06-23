package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class ActivateQuestTemplate extends QuestStepTemplate
	{
		public function ActivateQuestTemplate(aLevel:Level)
		{
			super(aLevel);
			
			mStepClass = ActivateQuest;
		}
	}
}