package com.frimastudio.fj_curriculumassociates_edu.poc_lesson
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.familysort.FamilySortTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class LessonPOCFamilySortQuest extends Quest
	{
		public function LessonPOCFamilySortQuest()
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			mStepList.push(new FamilySortTemplate(new <String>["ow", "oat", "orch", "ar"],
				new <String>["snow", "goat", "scorch", "far"],
				new <String>["low", "coat", "star", "torch", "glow", "jar", "boat", "porch"]));
			
			//mStepList.push(new FamilySortTemplate(new <String>["ow", "oat", "orch", "ar"],
				//new <String>["snow", "goat", "scorch", "far"],
				//new <String>["low", "coat", "star", "torch", "glow", "jar", "boat", "porch"], true));
			//
			//mStepList.push(new FamilySortTemplate(new <String>["ow", "oat", "orch", "ar"],
				//new <String>["snow", "goat", "scorch", "far"],
				//new <String>["low", "coat", "star", "torch", "glow", "jar", "boat", "porch"], true));
			
			super();
		}
	}
}