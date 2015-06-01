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
			
			mStepList.push(new CircuitTemplate(new <String>["Store", "Thorn", "Sports", "Throne", "Start", "Score"],
				new <int>[1, 2, 0], new <Class>[Asset.ThornBitmap, Asset.SportsBitmap, Asset.StoreBitmap],
				new <Class>[Asset.StoreSound, Asset.ThornSound, Asset.SportsSound,
				Asset.ThroneSound, Asset.StartSound, Asset.ScoreSound]));
			
			super();
		}
	}
}