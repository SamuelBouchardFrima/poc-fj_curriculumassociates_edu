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
			
			mStepList.push(new CircuitTemplate(new <String>["thorn", "sports", "store", "throne", "start", "score"],
				new <String>["corn", "sort"],
				new <int>[0, 1, 2],
				new <Class>[Asset.ThornBitmap, Asset.SportsBitmap, Asset.StoreBitmap],
				new <Class>[Asset.ThornSound, Asset.SportsSound, Asset.StoreSound,
				Asset.ThroneSound, Asset.StartSound, Asset.ScoreSound],
				new <Class>[Asset.CornSound, Asset.SortSound]));
			
			//mStepList.push(new CircuitTemplate(new <String>["storm", "show", "coat", "share", "star", "boat"],
				//new <String>["bar", "far", "march"],
				//new <int>[4, 2, 0],
				//new <Class>[Asset.StarBitmap, Asset.CoatBitmap, Asset.StormBitmap],
				//new <Class>[Asset.StormSound, Asset.ShowSound, Asset.CoatSound,
				//Asset.ShareSound, Asset.StarSound, Asset.BoatSound],
				//new <Class>[Asset.BarSound, Asset.FarSound, Asset.MarchSound]));
			//
			//mStepList.push(new CircuitTemplate(new <String>["sharp", "bark", "hand", "snow", "short", "fort"],
				//new <String>["torn", "bow"],
				//new <int>[5, 2, 3],
				//new <Class>[Asset.FortBitmap, Asset.HandBitmap, Asset.SnowBitmap],
				//new <Class>[Asset.SharpSound, Asset.BarkSound, Asset.HandSound,
				//Asset.SnowSound, Asset.ShortSound, Asset.FortSound],
				//new <Class>[Asset.TornSound, Asset.BowSound]));
			//
			//mStepList.push(new CircuitTemplate(new <String>["share", "hat", "score", "horn", "far", "hand"],
				//new <String>["for", "form"],
				//new <int>[3, 5, 1],
				//new <Class>[Asset.HornBitmap, Asset.HandBitmap, Asset.HatBitmap],
				//new <Class>[Asset.ShareSound, Asset.HatSound, Asset.ScoreSound,
				//Asset.HornSound, Asset.FearSound, Asset.HandSound],
				//new <Class>[Asset.ForSound, Asset.FormSound]));
			
			super();
		}
	}
}