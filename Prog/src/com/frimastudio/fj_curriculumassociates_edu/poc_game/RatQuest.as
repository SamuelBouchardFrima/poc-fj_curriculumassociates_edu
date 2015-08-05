package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordunscrambling.ScrambledWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.SelectActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.popup.reward.RewardTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.reward.RewardType;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	
	public class RatQuest extends Quest
	{
		public function RatQuest()
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			mStepList.push(new SelectActivityTemplate(Level.TOWN_SQUARE, Asset.WordContentSound["_rat"],
				new <WordTemplate>[new ScrambledWordTemplate("rat", "tar")], null, Direction.NONE));
			mStepList.push(new RewardTemplate(Level.TOWN_SQUARE, "REWARD", Asset.RewardSound[3], RewardType.WORD,
				new <String>["rat"]));
			
			super();
		}
	}
}