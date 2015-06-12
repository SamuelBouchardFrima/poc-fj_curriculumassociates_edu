package com.frimastudio.fj_curriculumassociates_edu.poc_lesson
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.circuit.CircuitTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class LessonPOCCircuitQuest extends Quest
	{
		public function LessonPOCCircuitQuest()
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			mStepList.push(new CircuitTemplate(new <String>["storm", "show", "coat", "share", "star", "boat"],
				new <String>["bar", "far"], new <int>[4, 2, 0]));
			
			mStepList.push(new CircuitTemplate(new <String>["sharp", "bark", "hand", "snow", "short", "fort"],
				new <String>["torn", "bow"], new <int>[5, 2, 3], true));
			
			mStepList.push(new CircuitTemplate(new <String>["share", "hat", "score", "horn", "far", "hand"],
				new <String>["for", "form"], new <int>[3, 5, 1], true));
			
			super();
		}
	}
}