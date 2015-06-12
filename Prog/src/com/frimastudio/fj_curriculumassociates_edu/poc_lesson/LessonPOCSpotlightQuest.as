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
			
			mStepList.push(new SpotlightTemplate("snore", "", 1, new <String>["glow", "snore", "jar"]));
			
			mStepList.push(new SpotlightTemplate("core", "", 0, new <String>["core", "car", "card"], true));
			
			mStepList.push(new SpotlightTemplate("score", "", 2, new <String>["throne", "start", "score"], true));
			
			super();
		}
	}
}