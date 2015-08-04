package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.navigation.ExplorableLevel;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class ProgressLocationQuestTemplate extends QuestStepTemplate
	{
		private var mProgressingLevel:ExplorableLevel;
		
		public function get ProgressingLevel():ExplorableLevel	{ return mProgressingLevel; }
		
		public function ProgressLocationQuestTemplate(aStepLevel:Level, aProgressingLevel:ExplorableLevel)
		{
			super(aStepLevel);
			
			mStepClass = ProgressLocationQuest;
			
			mProgressingLevel = aProgressingLevel;
		}
	}
}