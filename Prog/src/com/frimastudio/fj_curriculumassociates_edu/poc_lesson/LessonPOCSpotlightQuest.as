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
			
			mStepList.push(new SpotlightTemplate("sports", "", 1,
				new <Class>[Asset.ThornSound, Asset.SportsSound, Asset.StoreSound]));
			
			//mStepList.push(new SpotlightTemplate("snore", "", 1,
				//new <Class>[Asset.GlowSound, Asset.SnoreSound, Asset.JarSound]));
			//
			//mStepList.push(new SpotlightTemplate("core", "", 0,
				//new <Class>[Asset.CoreSound, Asset.CarSound, Asset.CardSound]));
			//
			//mStepList.push(new SpotlightTemplate("score", "", 2,
				//new <Class>[Asset.ThroneSound, Asset.StartSound, Asset.ScoreSound]));
			
			super();
		}
	}
}