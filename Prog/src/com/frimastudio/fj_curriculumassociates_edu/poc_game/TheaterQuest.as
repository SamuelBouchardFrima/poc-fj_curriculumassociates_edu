package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.KnownWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	import com.frimastudio.fj_curriculumassociates_edu.activity.sentenceunscrambling.SentenceUnscramblingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordcrafting.EmptyWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.ActivateQuestTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.DialogTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.SelectActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.SpeakerType;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.UseItemTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.UseLevelPropTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.navigation.ExplorableLevel;
	import com.frimastudio.fj_curriculumassociates_edu.popup.navigation.NavigationTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.reward.RewardTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.reward.RewardType;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	
	public class TheaterQuest extends Quest
	{
		public function TheaterQuest()
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			mStepList.push(new ActivateQuestTemplate(Level.THEATER, SpeakerType.NPC));
			mStepList.push(new DialogTemplate(Level.THEATER, new <String>["Hey, man, you can make this song sing. Rock it!"],
				new <Class>[Asset.QuestFlowSound[24]], SpeakerType.NPC));
			mStepList.push(new SelectActivityTemplate(Level.THEATER, Asset.WordContentSound["_did"],
				new <WordTemplate>[new KnownWordTemplate("Look"), new KnownWordTemplate("at"), new KnownWordTemplate("me."),
				new KnownWordTemplate("I"), new EmptyWordTemplate("did"), new KnownWordTemplate("it!")], null, Direction.NONE));
			mStepList.push(new SelectActivityTemplate(Level.THEATER, Asset.WordContentSound["_it"],
				new <WordTemplate>[new KnownWordTemplate("Look"), new KnownWordTemplate("at"), new KnownWordTemplate("you."),
				new KnownWordTemplate("You"), new KnownWordTemplate("did"), new EmptyWordTemplate("it"),
				new KnownWordTemplate("too!")], null, Direction.NONE));
			mStepList.push(new SentenceUnscramblingTemplate(Level.THEATER, new <String>["for", "it!", "Go"],
				"Go for it!", "", Asset.QuestFlowSound[25],
				new <WordTemplate>[new WordTemplate(new <String>["for"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "for"),
				new WordTemplate(new <String>["it!"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "it"),
				new WordTemplate(new <String>["Go"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "go")],
				null, Direction.DOWN, true));
			mStepList.push(new SentenceUnscramblingTemplate(Level.THEATER, new <String>["too!", "you do it,", "If", "I do it"],
				"If you do it, I do it too!", "", Asset.QuestFlowSound[26],
				new <WordTemplate>[new WordTemplate(new <String>["too!"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "too"),
				new WordTemplate(new <String>["you do it,"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "you_do_it"),
				new WordTemplate(new <String>["If"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "if"),
				new WordTemplate(new <String>["I do it"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "i_do_it")],
				null, Direction.DOWN));
			mStepList.push(new DialogTemplate(Level.THEATER, new <String>["All right! I am a fan, man"],
				new <Class>[Asset.QuestFlowSound[27]], SpeakerType.NPC));
			mStepList.push(new ProgressLocationQuestTemplate(Level.THEATER, ExplorableLevel.THE_LAB));
			
			super();
		}
	}
}