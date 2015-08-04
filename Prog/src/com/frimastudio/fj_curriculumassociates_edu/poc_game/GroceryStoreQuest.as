package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.KnownWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.sentencedecrypting.EncryptedWordTemplate;
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
	
	public class GroceryStoreQuest extends Quest
	{
		public function GroceryStoreQuest()
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			mStepList.push(new ActivateQuestTemplate(Level.GROCERY_STORE));
			mStepList.push(new DialogTemplate(Level.GROCERY_STORE,
				new <String>["Ah, I love a contest. Did you see me win on Chop Chef?", "But you need some words that begin like dim."],
				new <Class>[Asset.QuestFlowSound[16], Asset.QuestFlowSound[17]]));
			//mStepList.push(new SelectActivityTemplate(Level.GROCERY_STORE, null/*Asset.WordContentSound["_dip"]*/,
			mStepList.push(new SelectActivityTemplate(Level.GROCERY_STORE, Asset.WordContentSound["_dim"],
				new <WordTemplate>[new EmptyWordTemplate("di*")]));
			//mStepList.push(new DialogTemplate(Level.GROCERY_STORE, new <String>["Tasty! But you need a bit more . . . words!"],
				//new <Class>[Asset.QuestFlowSound[22]]));
			//mStepList.push(new UseLevelPropTemplate(Level.GROCERY_STORE, "Tap the fan."));
			//mStepList.push(new SelectActivityTemplate(Level.GROCERY_STORE, Asset.WordContentSound["_fan"],
				//new <WordTemplate>[new ScrambledWordTemplate("fan", "nfa")]));
			mStepList.push(new DialogTemplate(Level.GROCERY_STORE, new <String>["Delicious! Now go to the theater and write that song."],
				new <Class>[Asset.QuestFlowSound[23]]));
			mStepList.push(new LocationUnlockedTemplate(Level.GROCERY_STORE, "Theater Unlocked!", Asset.RewardSound[9],
				ExplorableLevel.THEATER));
			
			super();
		}
	}
}