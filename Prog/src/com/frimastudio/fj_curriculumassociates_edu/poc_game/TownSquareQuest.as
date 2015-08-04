package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.KnownWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordcrafting.EmptyWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordunscrambling.ScrambledWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.ActivateQuestTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.DialogTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.SelectActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.UseItemTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.UseLevelPropTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.navigation.ExplorableLevel;
	import com.frimastudio.fj_curriculumassociates_edu.popup.locationunlocked.LocationUnlockedTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.navigation.NavigationTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.reward.RewardTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.reward.RewardType;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	
	public class TownSquareQuest extends Quest
	{
		public function TownSquareQuest()
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			mStepList.push(new ActivateQuestTemplate(Level.TOWN_SQUARE));
			mStepList.push(new DialogTemplate(Level.TOWN_SQUARE,
				new <String>["Here's a tip, kid don't let the orange guy sing!", "But do make a word that rhymes with tip."],
				new <Class>[Asset.QuestFlowSound[8], Asset.QuestFlowSound[9]]));
			//mStepList.push(new SelectActivityTemplate(Level.TOWN_SQUARE, null/*Asset.WordContentSound["_sip"]*/,
			mStepList.push(new SelectActivityTemplate(Level.TOWN_SQUARE, Asset.WordContentSound["_tip"],
				//new <WordTemplate>[new EmptyWordTemplate("sip")]));
				new <WordTemplate>[new EmptyWordTemplate("*ip")]));
			//mStepList.push(new DialogTemplate(Level.TOWN_SQUARE, new <String>["You need more words!"],
				//new <Class>[Asset.QuestFlowSound[14]]));
			//mStepList.push(new UseLevelPropTemplate(Level.TOWN_SQUARE, "Tap the rat."));
			//mStepList.push(new SelectActivityTemplate(Level.TOWN_SQUARE, Asset.WordContentSound["_rat"],
				//new <WordTemplate>[new ScrambledWordTemplate("rat", "tar")]));
			mStepList.push(new DialogTemplate(Level.TOWN_SQUARE, new <String>["You did it, kid. Don't forget my tip."],
				new <Class>[Asset.QuestFlowSound[15]]));
			mStepList.push(new LocationUnlockedTemplate(Level.TOWN_SQUARE, "Grocery Store Unlocked!", Asset.RewardSound[7],
				ExplorableLevel.GROCERY_STORE));
			
			super();
		}
	}
}