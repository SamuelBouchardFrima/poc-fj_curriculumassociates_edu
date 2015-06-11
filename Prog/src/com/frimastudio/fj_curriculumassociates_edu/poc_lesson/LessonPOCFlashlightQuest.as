package com.frimastudio.fj_curriculumassociates_edu.poc_lesson
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.flashlight.FlashlightTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	import flash.geom.Point;
	
	public class LessonPOCFlashlightQuest extends Quest
	{
		public function LessonPOCFlashlightQuest()
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			//mStepList.push(new FlashlightTemplate("sports", "", 1,
				//new <Class>[Asset.ThornBitmap, Asset.SportsBitmap, Asset.StoreBitmap],
				//new <Point>[new Point(150, 300), new Point(300, 650), new Point(700, 300)],
				//new <Class>[Asset.ThornSound, Asset.SportsSound, Asset.StoreSound], Asset.SportsCorrectSound));
			
			mStepList.push(new FlashlightTemplate("fork", "", 0,
				new <Class>[Asset.ForkBitmap, Asset.ParkBitmap, Asset.FishBitmap],
				new <Point>[new Point(100, 650), new Point(450, 300), new Point(900, 450)],
				new <Class>[Asset.ForkSound, Asset.ParkSound, Asset.FishSound], Asset.ForkCorrectSound));
			
			mStepList.push(new FlashlightTemplate("torch", "", 0,
				new <Class>[Asset.TorchBitmap, Asset.TopBitmap, Asset.BarnBitmap],
				new <Point>[new Point(100, 300), new Point(300, 600), new Point(900, 300)],
				new <Class>[Asset.TorchSound, Asset.TopSound, Asset.BarnSound], Asset.TorchCorrectSound));
			
			super();
		}
	}
}