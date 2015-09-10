package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.KnownWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.sentencedecrypting.EncryptedWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordunscrambling.ScrambledWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.ActivateQuestTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.DialogTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.SelectActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.SpeakerType;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.UseLevelPropTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.navigation.ExplorableLevel;
	import com.frimastudio.fj_curriculumassociates_edu.popup.itemunlocked.ItemUnlockedTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.locationunlocked.LocationUnlockedTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.message.MessageTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.navigation.NavigationTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.reward.RewardTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.reward.RewardType;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	
	public class TheLabQuest extends Quest
	{
		public function TheLabQuest()
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			mStepList.push(new FadeInTemplate(Level.THE_LAB));
			
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Great job! You did Lesson 13."],
				new <Class>[Asset.QuestFlowSound[1]], SpeakerType.PLORY));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "LESSON REWARD", Asset.RewardSound[2], RewardType.LETTER_PATTERN_CARD,
				new <String>["id", "it", "ip", "in", "im"]));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "LESSON REWARD", Asset.RewardSound[2], RewardType.WORD,
				new <String>["tip", "dim", "fin", "rid"]));
			
			mStepList.push(new ActivateQuestTemplate(Level.THE_LAB, SpeakerType.PLORY));
			mStepList.push(new DialogTemplate(Level.THE_LAB,
				new <String>["Hello, human! There's a singing contest coming up. You can make us a song.",
				"First we need some good words."],
				new <Class>[Asset.QuestFlowSound[2], Asset.QuestFlowSound[3]], SpeakerType.PLORY));
			mStepList.push(new SelectActivityTemplate(Level.THE_LAB, Asset.WordContentSound["_rip"],
				new <WordTemplate>[new ScrambledWordTemplate("rip", "irp")], null, Direction.NONE));
			mStepList.push(new SelectActivityTemplate(Level.THE_LAB, Asset.WordContentSound["_pin"],
				new <WordTemplate>[new ScrambledWordTemplate("pin", "pni")], null, Direction.NONE));
			mStepList.push(new SelectActivityTemplate(Level.THE_LAB, Asset.WordContentSound["_did"],
				new <WordTemplate>[new ScrambledWordTemplate("did", "idd")], null, Direction.NONE));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "QUEST REWARD", Asset.RewardSound[3], RewardType.WORD,
				new <String>["rip", "pin", "did"]));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["We need more words!"],
				new <Class>[Asset.QuestFlowSound[4]], SpeakerType.PLORY));
			mStepList.push(new UseLevelPropTemplate(Level.THE_LAB, "", Asset.QuestFlowSound[5]));
			mStepList.push(new SelectActivityTemplate(Level.THE_LAB, Asset.WordContentSound["_sit"],
				new <WordTemplate>[new ScrambledWordTemplate("sit", "tis")], null, Direction.NONE));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "QUEST REWARD", Asset.RewardSound[3], RewardType.WORD,
				new <String>["sit"]));
			mStepList.push(new DialogTemplate(Level.THE_LAB,
				new <String>["Great job!", "Now let's go spread the word! All of my, I mean, YOUR fans will want to come."],
				new <Class>[Asset.QuestFlowSound[6], Asset.QuestFlowSound[7]],
				SpeakerType.PLORY));
			mStepList.push(new LocationUnlockedTemplate(Level.THE_LAB, "Town Square Unlocked!", Asset.RewardSound[8],
				ExplorableLevel.TOWN_SQUARE));
			
			super();
		}
	}
}