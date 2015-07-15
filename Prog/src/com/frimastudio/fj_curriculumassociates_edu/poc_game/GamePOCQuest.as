package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.KnownWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	import com.frimastudio.fj_curriculumassociates_edu.activity.sentencedecrypting.EncryptedWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.sentenceunscrambling.MisplacedWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.sentenceunscrambling.SentenceUnscramblingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordcrafting.EmptyWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordunscrambling.ScrambledWordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.ActivateQuestTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.DialogTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.SelectActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.UseItemTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.UseLevelPropTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.popup.itemunlocked.ItemUnlockedTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.locationunlocked.LocationUnlockedTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.message.MessageTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.navigation.NavigationTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.reward.RewardTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.reward.RewardType;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	
	public class GamePOCQuest extends Quest
	{
		public function GamePOCQuest()
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			// LESSON 13
			
			mStepList.push(new MessageTemplate(Level.THE_LAB, "Great job!", "You did Lesson 13.",
				Asset.GameHintSound[1], Asset.RewardSound[1]));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "LESSON REWARD", Asset.RewardSound[2], RewardType.LETTER_PATTERN_CARD,
				new <String>["id", "it", "ip", "in", "im"]));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "LESSON REWARD", Asset.RewardSound[2], RewardType.WORD,
				new <String>["tip", "rip", "dim", "fin"]));
			
			// THE LAB
			
			mStepList.push(new ActivateQuestTemplate(Level.THE_LAB));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["It's time to organize a karaoke contest!",
				"Here is where you should start:"], new <Class>[Asset.GameHintSound[2], Asset.GameHintSound[3]]));
			mStepList.push(new SelectActivityTemplate(Level.THE_LAB, Asset.SentenceContentTargetSound[1],
				new <WordTemplate>[new EncryptedWordTemplate("Print", "_____"),
				new EncryptedWordTemplate("_ome", "_o_e"),
				new EncryptedWordTemplate("flier_", "_lie__"),
				new WordTemplate(new <String>["for"]),
				new WordTemplate(new <String>["the"]),
				new EncryptedWordTemplate("karaoke", "ka_aoke"),
				new EncryptedWordTemplate("conte_t", "co__e__", "!")],
				new <int>[6]));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["You need more words."],
				new <Class>[Asset.GameHintSound[6]], Asset.SentenceContentTargetSound[1],
				new <WordTemplate>[new KnownWordTemplate("Print"),
				new EncryptedWordTemplate("some", "_ome"),
				new EncryptedWordTemplate("fliers", "flier_"),
				new KnownWordTemplate("for"),
				new KnownWordTemplate("the"),
				new KnownWordTemplate("karaoke"),
				new EncryptedWordTemplate("contest", "conte_t", "!")],
				new <int>[6]));
			mStepList.push(new UseLevelPropTemplate(Level.THE_LAB, "Try clicking things to get words.", Asset.GameHintSound[7],
				new <WordTemplate>[new KnownWordTemplate("Print"),
				new EncryptedWordTemplate("some", "_ome"),
				new EncryptedWordTemplate("fliers", "flier_"),
				new KnownWordTemplate("for"),
				new KnownWordTemplate("the"),
				new KnownWordTemplate("karaoke"),
				new EncryptedWordTemplate("contest", "conte_t", "!")],
				new <int>[6]));
			mStepList.push(new SelectActivityTemplate(Level.THE_LAB, Asset.SentenceContentTargetSound[2],
				new <WordTemplate>[new KnownWordTemplate("You"),
				new KnownWordTemplate("can"),
				new ScrambledWordTemplate("sit" ,"tis"),
				new KnownWordTemplate("on"),
				new KnownWordTemplate("it", ".")]));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Great job!"], new <Class>[Asset.GameHintSound[1]],
				Asset.SentenceContentTargetSound[2],
				new <WordTemplate>[new KnownWordTemplate("You"),
				new KnownWordTemplate("can"),
				new KnownWordTemplate("sit", "", true),
				new KnownWordTemplate("on"),
				new KnownWordTemplate("it", ".")]));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "QUEST REWARD", Asset.RewardSound[3], RewardType.WORD,
				new <String>["sit"]));
			mStepList.push(new SelectActivityTemplate(Level.THE_LAB, Asset.SentenceContentTargetSound[1],
				new <WordTemplate>[new KnownWordTemplate("Print"),
				new EncryptedWordTemplate("some", "_ome"),
				new EncryptedWordTemplate("fliers", "flier_"),
				new KnownWordTemplate("for"),
				new KnownWordTemplate("the"),
				new KnownWordTemplate("karaoke"),
				new EncryptedWordTemplate("contest", "conte_t", "!")],
				new <int>[6]));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Great job!"], new <Class>[Asset.GameHintSound[1]],
				Asset.SentenceContentTargetSound[1],
				new <WordTemplate>[new KnownWordTemplate("Print"),
				new KnownWordTemplate("some", "", true),
				new KnownWordTemplate("fliers", "", true),
				new KnownWordTemplate("for"),
				new KnownWordTemplate("the"),
				new KnownWordTemplate("karaoke"),
				new KnownWordTemplate("contest", "!", true)],
				new <int>[6]));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "QUEST REWARD", Asset.RewardSound[3], RewardType.WORD,
				new <String>["pit", "sip"]));
			mStepList.push(new ItemUnlockedTemplate(Level.THE_LAB, "You have fliers!", Asset.FliersBitmap, Asset.RewardSound[6]));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Now give the fliers to people in town!"],
				new <Class>[Asset.GameHintSound[8]]));
			mStepList.push(new LocationUnlockedTemplate(Level.THE_LAB, "Town Square Unlocked!", Asset.RewardSound[8]));
			mStepList.push(new NavigationTemplate(Level.THE_LAB, "CHOOSE A LOCATION", new <String>["The Lab", "Town Square"],
				new <Boolean>[false, true], new <int>[1, 2]));
			
			// TOWN SQUARE
			
			mStepList.push(new ActivateQuestTemplate(Level.TOWN_SQUARE));
			mStepList.push(new UseItemTemplate(Level.TOWN_SQUARE, "Give a flier to this citizen.", Asset.GameHintSound[9],
				Asset.FliersBitmap));
			mStepList.push(new SelectActivityTemplate(Level.TOWN_SQUARE, Asset.SentenceContentTargetSound[3],
				new <WordTemplate>[new KnownWordTemplate("I'll"),
				new KnownWordTemplate("watch"),
				new ScrambledWordTemplate("it", "ti"),
				new ScrambledWordTemplate("if", "fi"),
				new KnownWordTemplate("I"),
				new KnownWordTemplate("can"),
				new EmptyWordTemplate("sit"),
				new ScrambledWordTemplate("in", "ni"),
				new KnownWordTemplate("front", ".")],
				new <int>[7], Direction.DOWN));
			mStepList.push(new DialogTemplate(Level.TOWN_SQUARE, new <String>["Great job!"], new <Class>[Asset.GameHintSound[1]],
				Asset.SentenceContentTargetSound[3],
				new <WordTemplate>[new KnownWordTemplate("I'll"),
				new KnownWordTemplate("watch"),
				new KnownWordTemplate("it", "", true),
				new KnownWordTemplate("if", "", true),
				new KnownWordTemplate("I"),
				new KnownWordTemplate("can"),
				new KnownWordTemplate("sit", "", true),
				new KnownWordTemplate("in", "", true),
				new KnownWordTemplate("front", ".")],
				new <int>[7], Direction.DOWN));
			mStepList.push(new RewardTemplate(Level.TOWN_SQUARE, "QUEST REWARD", Asset.RewardSound[3], RewardType.WORD,
				new <String>["sit", "rid", "dim", "in"]));
			mStepList.push(new LocationUnlockedTemplate(Level.TOWN_SQUARE, "Grocery Store Unlocked!", Asset.RewardSound[7]));
			mStepList.push(new NavigationTemplate(Level.TOWN_SQUARE, "CHOOSE A LOCATION",
				new <String>["The Lab", "Grocery Store", "Town Square"], new <Boolean>[false, true, false], new <int>[1, 3, 2]));
			
			// GROCERY STORE
			
			mStepList.push(new ActivateQuestTemplate(Level.GROCERY_STORE));
			mStepList.push(new UseItemTemplate(Level.GROCERY_STORE, "Give a flier to this citizen.", Asset.GameHintSound[9],
				Asset.FliersBitmap));
			mStepList.push(new SelectActivityTemplate(Level.GROCERY_STORE, Asset.SentenceContentTargetSound[4],
				new <WordTemplate>[new EmptyWordTemplate("Did"),
				new KnownWordTemplate("you"),
				new EncryptedWordTemplate("know", "k_ow"),
				new KnownWordTemplate("I"),
				new KnownWordTemplate("love"),
				new ScrambledWordTemplate("to", "ot"),
				new EncryptedWordTemplate("sing", "_ing", "?")],
				new <int>[6], Direction.DOWN));
			mStepList.push(new DialogTemplate(Level.GROCERY_STORE, new <String>["Great job!"], new <Class>[Asset.GameHintSound[1]],
				Asset.SentenceContentTargetSound[4],
				new <WordTemplate>[new KnownWordTemplate("Did", "", true),
				new KnownWordTemplate("you"),
				new KnownWordTemplate("know", "", true),
				new KnownWordTemplate("I"),
				new KnownWordTemplate("love"),
				new KnownWordTemplate("to", "", true),
				new KnownWordTemplate("sing", "?", true)],
				new <int>[6], Direction.DOWN));
			mStepList.push(new RewardTemplate(Level.GROCERY_STORE, "QUEST REWARD", Asset.RewardSound[3], RewardType.WORD,
				new <String>["did", "rip"]));
			mStepList.push(new DialogTemplate(Level.GROCERY_STORE,
				new <String>["We need more people for the contest! Maybe we will find some at the Theater."],
				new <Class>[Asset.GameHintSound[11]]));
			mStepList.push(new LocationUnlockedTemplate(Level.GROCERY_STORE, "Theater Unlocked!", Asset.RewardSound[9]));
			mStepList.push(new NavigationTemplate(Level.GROCERY_STORE, "CHOOSE A LOCATION",
				new <String>["The Lab", "Grocery Store", "Town Square", "Theater"], new <Boolean>[false, false, false, true],
				new <int>[1, 3, 2, 4]));
			
			// THEATER - PART I
			
			mStepList.push(new ActivateQuestTemplate(Level.THEATER));
			mStepList.push(new UseItemTemplate(Level.THEATER, "Give a flier to this citizen.", Asset.GameHintSound[9],
				Asset.FliersBitmap));
			mStepList.push(new DialogTemplate(Level.THEATER, new <String>["You are running out of words."],
				new <Class>[Asset.GameHintSound[12]], Asset.SentenceContentTargetSound[5],
				new <WordTemplate>[new KnownWordTemplate("I"),
				new KnownWordTemplate("don't"),
				new KnownWordTemplate("sing"),
				new KnownWordTemplate("but"),
				new KnownWordTemplate("I"),
				new KnownWordTemplate("can"),
				new EmptyWordTemplate("rap", ".")],
				null, Direction.DOWN));
			mStepList.push(new UseLevelPropTemplate(Level.THEATER, "Find something in the room that will help you.",
				Asset.GameHintSound[13],
				new <WordTemplate>[new KnownWordTemplate("I"),
				new KnownWordTemplate("don't"),
				new KnownWordTemplate("sing"),
				new KnownWordTemplate("but"),
				new KnownWordTemplate("I"),
				new KnownWordTemplate("can"),
				new EmptyWordTemplate("rap", ".")],
				null, Direction.DOWN));
			mStepList.push(new SentenceUnscramblingTemplate(Level.THEATER, new <String>["at", "rat!", "fat", "Look", "the"],
				"Look at the fat rat!", "", Asset.SentenceContentTargetSound[6],
				new <WordTemplate>[new WordTemplate(new <String>["at"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "look"),
				new WordTemplate(new <String>["rat!"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "at"),
				new WordTemplate(new <String>["fat"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "the"),
				new WordTemplate(new <String>["Look"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "fat"),
				new WordTemplate(new <String>["the"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "rat")]));
			mStepList.push(new RewardTemplate(Level.THEATER, "QUEST REWARD", Asset.RewardSound[3], RewardType.WORD,
				new <String>["fat", "rat"]));
			
			// THEATER - PART II
			
			mStepList.push(new ActivateQuestTemplate(Level.THEATER));
			mStepList.push(new SelectActivityTemplate(Level.THEATER, Asset.SentenceContentTargetSound[5],
				new <WordTemplate>[new KnownWordTemplate("I"),
				new KnownWordTemplate("don't"),
				new KnownWordTemplate("sing"),
				new KnownWordTemplate("but"),
				new KnownWordTemplate("I"),
				new KnownWordTemplate("can"),
				new EmptyWordTemplate("rap", ".")],
				null, Direction.DOWN));
			mStepList.push(new DialogTemplate(Level.THEATER, new <String>["Great job!"], new <Class>[Asset.GameHintSound[1]],
				Asset.SentenceContentTargetSound[5],
				new <WordTemplate>[new KnownWordTemplate("I"),
				new KnownWordTemplate("don't"),
				new KnownWordTemplate("sing"),
				new KnownWordTemplate("but"),
				new KnownWordTemplate("I"),
				new KnownWordTemplate("can"),
				new KnownWordTemplate("rap", ".", true)],
				null, Direction.DOWN));
			mStepList.push(new RewardTemplate(Level.THEATER, "QUEST REWARD", Asset.RewardSound[3], RewardType.WORD,
				new <String>["rap", "in", "if"]));
			mStepList.push(new DialogTemplate(Level.THEATER, new <String>["Get ready for the karaoke contest!",
				"Go back to the Lab."], new <Class>[Asset.GameHintSound[15], Asset.GameHintSound[16]]));
			mStepList.push(new NavigationTemplate(Level.THEATER, "CHOOSE A LOCATION",
				new <String>["The Lab", "Grocery Store", "Town Square", "Theater"], new <Boolean>[true, false, false, false],
				new <int>[1, 3, 2, 4]));
			
			// RETURN TO THE LAB - PART I
			
			mStepList.push(new ActivateQuestTemplate(Level.THE_LAB));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Now write a song for the karaoke contest."],
				new <Class>[Asset.GameHintSound[17]]));
			mStepList.push(new SelectActivityTemplate(Level.THE_LAB, Asset.SentenceContentTargetSound[7],
			new <WordTemplate>[new KnownWordTemplate("A"),
				new EncryptedWordTemplate("chicken", "ch_cke_"),
				new KnownWordTemplate("lip", ","),
				new KnownWordTemplate("a"),
				new EncryptedWordTemplate("lizard", "l_zard"),
				new KnownWordTemplate("hip", ","),
				new KnownWordTemplate("and"),
				new EncryptedWordTemplate("alligator", "_lligator"),
				new KnownWordTemplate("eyes", "!")],
				new <int>[6], Direction.NONE));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Great job!"], new <Class>[Asset.GameHintSound[1]],
				Asset.SentenceContentTargetSound[7],
				new <WordTemplate>[new KnownWordTemplate("A"),
				new KnownWordTemplate("chicken", "", true),
				new KnownWordTemplate("lip", ","),
				new KnownWordTemplate("a"),
				new KnownWordTemplate("lizard", "", true),
				new KnownWordTemplate("hip", ","),
				new KnownWordTemplate("and"),
				new KnownWordTemplate("alligator", "", true),
				new KnownWordTemplate("eyes", "!")],
				new <int>[6], Direction.NONE));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "QUEST REWARD", Asset.RewardSound[3], RewardType.WORD,
				new <String>["nip", "fit"]));
			mStepList.push(new DialogTemplate(Level.THE_LAB,
				new <String>["A chicken lip, a lizard hip, and alligator eyes.", "This is original!", "Let met try!",
				"Monkey legs and buzzard eggs and salamander thighs!"],
				new <Class>[Asset.SentenceContentTargetSound[7], Asset.GameHintSound[18], Asset.GameHintSound[19],
				Asset.GameHintSound[22]]));
			
			// RETURN TO THE LAB - PART II
			
			mStepList.push(new ActivateQuestTemplate(Level.THE_LAB));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Keep working on that song."],
				new <Class>[Asset.GameHintSound[20]]));
			mStepList.push(new SentenceUnscramblingTemplate(Level.THE_LAB,
				new <String>["take", "it", "up", "Mix", "a", "and", "sip."], "Mix it up and take a sip.", "",
				Asset.SentenceContentTargetSound[8],
				new <WordTemplate>[new WordTemplate(new <String>["take"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "mix"),
				new WordTemplate(new <String>["it"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "it"),
				new WordTemplate(new <String>["up"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "up"),
				new WordTemplate(new <String>["Mix"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "and"),
				new WordTemplate(new <String>["a"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "take"),
				new WordTemplate(new <String>["and"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "a"),
				new WordTemplate(new <String>["sip."], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "sip")],
				null, Direction.NONE));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Great job!"], new <Class>[Asset.GameHintSound[1]],
				Asset.SentenceContentTargetSound[8],
				new <WordTemplate>[new KnownWordTemplate("Mix", "", true),
				new KnownWordTemplate("it", "", true),
				new KnownWordTemplate("up", "", true),
				new KnownWordTemplate("and", "", true),
				new KnownWordTemplate("take", "", true),
				new KnownWordTemplate("a", "", true),
				new KnownWordTemplate("sip.", "", true)],
				null, Direction.NONE));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "QUEST REWARD", Asset.RewardSound[3], RewardType.WORD,
				new <String>["it", "sip"]));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Mix it up and take a sip.", "Wow that sounds great!",
				"It's Mama's Soup Surprise!"], new <Class>[Asset.SentenceContentTargetSound[8], Asset.GameHintSound[21],
				Asset.GameHintSound[23]]));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["A chicken lip, a lizard hip, and alligator eyes.",
				"Monkey legs and buzzard eggs and salamander thighs.", "Mix it up and take a sip.", "It's Mama's Soup Surprise!",
				"Rockin' tune! You are ready for the karaoke contest!"], new <Class>[Asset.SentenceContentTargetSound[7],
				Asset.GameHintSound[22], Asset.SentenceContentTargetSound[8], Asset.GameHintSound[23], Asset.GameHintSound[24]]));
			mStepList.push(new LocationUnlockedTemplate(Level.THE_LAB, "You unlocked the karaoke contest!", Asset.RewardSound[10]));
			
			super();
		}
	}
}