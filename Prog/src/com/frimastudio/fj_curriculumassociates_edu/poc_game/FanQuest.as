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
	
	public class FanQuest extends Quest
	{
		public function FanQuest()
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			mStepList.push(new SelectActivityTemplate(Level.GROCERY_STORE, Asset.WordContentSound["_fan"],
				new <WordTemplate>[new ScrambledWordTemplate("fan", "nfa")]));
			mStepList.push(new RewardTemplate(Level.GROCERY_STORE, "REWARD", Asset.RewardSound[3], RewardType.WORD,
				new <String>["fan"]));
			
			super();
		}
	}
}