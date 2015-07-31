package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.navigation.ExplorableLevel;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class QuestlessQuest extends Quest
	{
		public function QuestlessQuest(aLevel:ExplorableLevel)
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			mStepList.push(new QuestlessStepTemplate(aLevel.ToLevel));
			
			super();
		}
	}
}