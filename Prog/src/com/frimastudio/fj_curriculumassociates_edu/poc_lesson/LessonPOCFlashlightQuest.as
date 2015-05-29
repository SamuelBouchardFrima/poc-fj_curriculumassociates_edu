package com.frimastudio.fj_curriculumassociates_edu.poc_lesson
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.flashlight.FlashlightTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class LessonPOCFlashlightQuest extends Quest
	{
		public function LessonPOCFlashlightQuest()
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			mStepList.push(new FlashlightTemplate("Sports", 1,
				new <Class>[Asset.ThornBitmap, Asset.SportsBitmap, Asset.StoreBitmap]));
			
			super();
		}
	}
}