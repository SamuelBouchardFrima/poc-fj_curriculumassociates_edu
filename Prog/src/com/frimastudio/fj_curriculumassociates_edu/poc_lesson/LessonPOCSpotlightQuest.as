package com.frimastudio.fj_curriculumassociates_edu.poc_lesson
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.spotlight.SpotlightTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class LessonPOCSpotlightQuest extends Quest
	{
		public function LessonPOCSpotlightQuest()
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			mStepList.push(new SpotlightTemplate("Sports", "or", 1,
				new <Class>[Asset.ThornSound, Asset.SportsSound, Asset.StoreSound]));
			
			super();
		}
	}
}