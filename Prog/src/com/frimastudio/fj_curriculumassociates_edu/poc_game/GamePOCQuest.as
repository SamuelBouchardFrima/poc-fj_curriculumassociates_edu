package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	import com.frimastudio.fj_curriculumassociates_edu.activity.sentencedecrypting.SentenceDecryptingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.sentenceunscrambling.SentenceUnscramblingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordcrafting.WordCraftingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordunscrambling.WordUnscramblingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.ActivateQuestTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.DialogTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.SelectActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.UseItemTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.UseLevelPropTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.popup.itemunlocked.ItemUnlockedTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.locationunlocked.LocationUnlockedTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.message.MessageTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.navigation.NavigationTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.popup.reward.RewardTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class GamePOCQuest extends Quest
	{
		public function GamePOCQuest()
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			mStepList.push(new MessageTemplate(Level.THE_LAB, "Great job!", "You did Lesson 13."));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "LESSON REWARD", "Words:", new <String>["tip", "rip", "dim", "fin"]));
			
			mStepList.push(new ActivateQuestTemplate(Level.THE_LAB));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["It's time to organize a karaoke contest!",
				"Here is where you should start:"], new <Class>[Asset.DialogSound[0], Asset.DialogSound[1]]));
			mStepList.push(new SentenceDecryptingTemplate(Level.THE_LAB, new <String>["tip", "rip", "dim", "fin"],
				"Print _ome flier_ for the karaoke conte_t!", "_____ _o_e _lie__ for the ka_aoke co__e__!"));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["You need more words."], new <Class>[Asset.DialogSound[3]],
				new <WordTemplate>[new WordTemplate(new <String>["Print"]),
				new WordTemplate(Vector.<String>("_ome".split("")), "", null, ActivityType.SENTENCE_DECRYPTING.ColorCode),
				new WordTemplate(Vector.<String>("flier_".split("")), "", null, ActivityType.SENTENCE_DECRYPTING.ColorCode),
				new WordTemplate(new <String>["for"]),
				new WordTemplate(new <String>["the"]),
				new WordTemplate(new <String>["karaoke"], "", null, -1, true),
				new WordTemplate(Vector.<String>("conte_t".split("")), "!", null, ActivityType.SENTENCE_DECRYPTING.ColorCode)]));
			mStepList.push(new UseLevelPropTemplate(Level.THE_LAB,
				new <WordTemplate>[new WordTemplate(new <String>["Print"]),
				new WordTemplate(Vector.<String>("_ome".split("")), "", null, ActivityType.SENTENCE_DECRYPTING.ColorCode),
				new WordTemplate(Vector.<String>("flier_".split("")), "", null, ActivityType.SENTENCE_DECRYPTING.ColorCode),
				new WordTemplate(new <String>["for"]),
				new WordTemplate(new <String>["the"]),
				new WordTemplate(new <String>["karaoke"], "", null, -1, true),
				new WordTemplate(Vector.<String>("conte_t".split("")), "!", null, ActivityType.SENTENCE_DECRYPTING.ColorCode)],
				"Try clicking things to get words."));
			mStepList.push(new SelectActivityTemplate(Level.THE_LAB,
				new <WordTemplate>[new WordTemplate(new <String>["You"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(new <String>["t", "i", "s"], "", ActivityType.WORD_UNSCRAMBLING),
				new WordTemplate(new <String>["on"]),
				new WordTemplate(new <String>["it"], ".")], true));
			mStepList.push(new WordUnscramblingTemplate(Level.THE_LAB, new <String>["t", "i", "s"], "sit", "You can _ on it."));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Great job!"], new <Class>[Asset.DialogSound[3]],
				new <WordTemplate>[new WordTemplate(new <String>["You"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(new <String>["sit"], "", null, -1, true),
				new WordTemplate(new <String>["on"]),
				new WordTemplate(new <String>["it"], ".")]));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "REWARD", "Word:", new <String>["sit"]));
			mStepList.push(new SentenceDecryptingTemplate(Level.THE_LAB, new <String>["sit"],
				"Print some fliers for the karaoke contest!", "Print _ome flier_ for the karaoke conte_t!"));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new < String > ["Great job!"], new <Class>[Asset.DialogSound[3]],
				new <WordTemplate>[new WordTemplate(new <String>["Print"], "", null, -1, true),
				new WordTemplate(new <String>["some"], "", null, -1, true),
				new WordTemplate(new <String>["fliers"], "", null, -1, true),
				new WordTemplate(new <String>["for"]),
				new WordTemplate(new <String>["the"]),
				new WordTemplate(new <String>["karaoke"], "", null, -1, true),
				new WordTemplate(new <String>["contest"], "!", null, -1, true)]));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "QUEST REWARD", "Words:", new <String>["pit", "sip"]));
			mStepList.push(new ItemUnlockedTemplate(Level.THE_LAB, "You have fliers!", Asset.FliersBitmap));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Now give the fliers to people in town!"],
				new <Class>[Asset.DialogSound[3]]));
			mStepList.push(new LocationUnlockedTemplate(Level.THE_LAB, "Town Square Unlocked!"));
			mStepList.push(new NavigationTemplate(Level.THE_LAB, "CHOOSE A LOCATION", new <String>["The Lab", "Town Square"],
				new <Boolean>[false, true]));
			
			mStepList.push(new ActivateQuestTemplate(Level.TOWN_SQUARE));
			mStepList.push(new UseItemTemplate(Level.TOWN_SQUARE, "Give a flier to this citizen.", Asset.FliersBitmap));
			mStepList.push(new SelectActivityTemplate(Level.TOWN_SQUARE,
				new <WordTemplate>[new WordTemplate(new <String>["I"], "'"),
				new WordTemplate(new <String>["ll"]),
				new WordTemplate(new <String>["watch"]),
				new WordTemplate(Vector.<String>("ti".split("")), "", ActivityType.WORD_UNSCRAMBLING),
				new WordTemplate(Vector.<String>("fi".split("")), "", null, ActivityType.WORD_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(Vector.<String>("___".split("")), "", null, ActivityType.WORD_CRAFTING.ColorCode),
				new WordTemplate(Vector.<String>("ni".split("")), "", null, ActivityType.WORD_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["front"], ".")], true));
			mStepList.push(new WordUnscramblingTemplate(Level.TOWN_SQUARE, new <String>["t", "i"], "it",
				"I'll watch _ fi I can     ni front."));
			mStepList.push(new SelectActivityTemplate(Level.TOWN_SQUARE,
				new <WordTemplate>[new WordTemplate(new <String>["I"], "'"),
				new WordTemplate(new <String>["ll"]),
				new WordTemplate(new <String>["watch"]),
				new WordTemplate(new <String>["it"], "", null, -1, true),
				new WordTemplate(Vector.<String>("fi".split("")), "", ActivityType.WORD_UNSCRAMBLING),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(Vector.<String>("___".split("")), "", null, ActivityType.WORD_CRAFTING.ColorCode),
				new WordTemplate(Vector.<String>("ni".split("")), "", null, ActivityType.WORD_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["front"], ".")], true));
			mStepList.push(new WordUnscramblingTemplate(Level.TOWN_SQUARE, new <String>["f", "i"], "if",
				"I'll watch it _ I can     ni front."));
			mStepList.push(new SelectActivityTemplate(Level.TOWN_SQUARE,
				new <WordTemplate>[new WordTemplate(new <String>["I"], "'"),
				new WordTemplate(new <String>["ll"]),
				new WordTemplate(new <String>["watch"]),
				new WordTemplate(new <String>["it"], "", null, -1, true),
				new WordTemplate(new <String>["if"], "", null, -1, true),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(Vector.<String>("___".split("")), "", null, ActivityType.WORD_CRAFTING.ColorCode),
				new WordTemplate(Vector.<String>("ni".split("")), "", ActivityType.WORD_UNSCRAMBLING),
				new WordTemplate(new <String>["front"], ".")], true));
			mStepList.push(new WordUnscramblingTemplate(Level.TOWN_SQUARE, new < String > ["n", "i"], "in",
				"I'll watch it if I can     _ front."));
			mStepList.push(new SelectActivityTemplate(Level.TOWN_SQUARE,
				new <WordTemplate>[new WordTemplate(new <String>["I"], "'"),
				new WordTemplate(new <String>["ll"]),
				new WordTemplate(new <String>["watch"]),
				new WordTemplate(new <String>["it"], "", null, -1, true),
				new WordTemplate(new <String>["if"], "", null, -1, true),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(Vector.<String>("___".split("")), "", ActivityType.WORD_CRAFTING),
				new WordTemplate(new <String>["in"], "", null, -1, true),
				new WordTemplate(new <String>["front"], ".")], true));
			mStepList.push(new WordCraftingTemplate(Level.TOWN_SQUARE, new < String > ["sip", "pit"], "sit",
				"I'll watch it if I can _ in front."));
			mStepList.push(new DialogTemplate(Level.TOWN_SQUARE, new <String>["Great job!"], new <Class>[Asset.DialogSound[3]],
				new <WordTemplate>[new WordTemplate(new <String>["I"], "'"),
				new WordTemplate(new <String>["ll"]),
				new WordTemplate(new <String>["watch"]),
				new WordTemplate(new <String>["it"], "", null, -1, true),
				new WordTemplate(new <String>["if"], "", null, -1, true),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(new <String>["sit"], "", null, -1, true),
				new WordTemplate(new <String>["in"], "", null, -1, true),
				new WordTemplate(new <String>["front"], ".")]));
			mStepList.push(new RewardTemplate(Level.TOWN_SQUARE, "QUEST REWARD", "Words:", new <String>["sit", "rid", "dim", "in"]));
			mStepList.push(new LocationUnlockedTemplate(Level.TOWN_SQUARE, "Grocery Store Unlocked!"));
			mStepList.push(new NavigationTemplate(Level.TOWN_SQUARE, "CHOOSE A LOCATION",
				new <String>["The Lab", "Grocery Store", "Town Square"], new <Boolean>[false, true, false]));
			
			mStepList.push(new ActivateQuestTemplate(Level.GROCERY_STORE));
			mStepList.push(new UseItemTemplate(Level.GROCERY_STORE, "Give a flier to this citizen.", Asset.FliersBitmap));
			mStepList.push(new SelectActivityTemplate(Level.GROCERY_STORE,
				new <WordTemplate>[new WordTemplate(Vector.<String>("___".split("")), "", null, ActivityType.WORD_CRAFTING.ColorCode),
				new WordTemplate(new <String>["you"]),
				new WordTemplate(Vector.<String>("k_ow".split("")), "", null, ActivityType.SENTENCE_DECRYPTING.ColorCode),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["love"]),
				new WordTemplate(Vector.<String>("ot".split("")), "", ActivityType.WORD_UNSCRAMBLING),
				new WordTemplate(Vector.<String>("_ing".split("")), "?", null, ActivityType.SENTENCE_DECRYPTING.ColorCode)],
				true));
			mStepList.push(new WordUnscramblingTemplate(Level.GROCERY_STORE, new < String > ["o", "t"], "to",
				"    you k ow I love _  ing?"));
			mStepList.push(new SelectActivityTemplate(Level.GROCERY_STORE,
				new <WordTemplate>[new WordTemplate(Vector.<String>("___".split("")), "", ActivityType.WORD_CRAFTING),
				new WordTemplate(new <String>["you"]),
				new WordTemplate(Vector.<String>("k_ow".split("")), "", null, ActivityType.SENTENCE_DECRYPTING.ColorCode),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["love"]),
				new WordTemplate(new <String>["to"], "", null, -1, true),
				new WordTemplate(Vector.<String>("_ing".split("")), "?", null, ActivityType.SENTENCE_DECRYPTING.ColorCode)],
				true));
			mStepList.push(new WordCraftingTemplate(Level.GROCERY_STORE, new <String>["rid", "dim"], "did",
				"_ you k ow I love to  ing?"));
			mStepList.push(new SentenceDecryptingTemplate(Level.GROCERY_STORE, new <String>["sit", "in"],
				"Did you know I love to sing?", "Did you k_ow I love to _ing?"));
			mStepList.push(new DialogTemplate(Level.GROCERY_STORE, new <String>["Great job!"], new <Class>[Asset.DialogSound[3]],
				new <WordTemplate>[new WordTemplate(new <String>["Did"], "", null, -1, true),
				new WordTemplate(new <String>["you"]),
				new WordTemplate(new <String>["know"], "", null, -1, true),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["love"]),
				new WordTemplate(new <String>["to"], "", null, -1, true),
				new WordTemplate(new <String>["sing"], "?", null, -1, true)]));
			mStepList.push(new RewardTemplate(Level.GROCERY_STORE, "QUEST REWARD", "Words:", new <String>["did", "rip"]));
			mStepList.push(new DialogTemplate(Level.GROCERY_STORE, new <String>["We need more people for the contest!",
				"Maybe we will find some at the Theater."], new <Class>[Asset.DialogSound[3], Asset.DialogSound[3]]));
			mStepList.push(new LocationUnlockedTemplate(Level.GROCERY_STORE, "Theater Unlocked!"));
			mStepList.push(new NavigationTemplate(Level.GROCERY_STORE, "CHOOSE A LOCATION",
				new <String>["The Lab", "Grocery Store", "Town Square", "Theater"], new <Boolean>[false, false, false, true]));
			
			mStepList.push(new ActivateQuestTemplate(Level.THEATER));
			mStepList.push(new UseItemTemplate(Level.THEATER, "Give a flier to this citizen.", Asset.FliersBitmap));
			mStepList.push(new SelectActivityTemplate(Level.THEATER,
				new <WordTemplate>[new WordTemplate(new <String>["but"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["sing"], ".", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["don"], "'", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["t"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["can"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(Vector.<String>("___".split("")), "", ActivityType.WORD_CRAFTING)], true));
			mStepList.push(new DialogTemplate(Level.THEATER, new <String>["You are running out of words."],
				new <Class>[Asset.DialogSound[3]],
				new <WordTemplate>[new WordTemplate(new <String>["but"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["sing"], ".", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["don"], "'", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["t"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["can"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(Vector.<String>("___".split("")), "", null, ActivityType.WORD_CRAFTING.ColorCode)]));
			mStepList.push(new UseLevelPropTemplate(Level.THEATER,
				new <WordTemplate>[new WordTemplate(new <String>["but"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["sing"], ".", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["don"], "'", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["t"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["can"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(Vector.<String>("___".split("")), "", null, ActivityType.WORD_CRAFTING.ColorCode)],
				"Find something in the room that will help you."));
			mStepList.push(new SentenceUnscramblingTemplate(Level.THEATER, new <String>["at", "rat!", "fat", "Look", "the"],
				"Look at the fat rat!", "", Asset.WhereIsTheFieldSound));
			mStepList.push(new RewardTemplate(Level.THEATER, "QUEST REWARD", "Words:", new < String > ["fat", "rat"]));
			
			mStepList.push(new ActivateQuestTemplate(Level.THEATER));
			mStepList.push(new SelectActivityTemplate(Level.THEATER,
				new <WordTemplate>[new WordTemplate(new <String>["but"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["sing"], ".", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["don"], "'", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["t"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["can"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(Vector.<String>("___".split("")), "", ActivityType.WORD_CRAFTING)], true));
			mStepList.push(new WordCraftingTemplate(Level.THEATER, new <String>["rat", "fat", "rip", "did"], "rap",
				"but I sing don't can I _."));
			mStepList.push(new SelectActivityTemplate(Level.THEATER,
				new <WordTemplate>[new WordTemplate(new <String>["but"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["sing"], ".", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["don"], "'", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["t"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["can"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["rap"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode, true)], true));
			mStepList.push(new SentenceUnscramblingTemplate(Level.THEATER,
				new <String>["but", "I", "sing.", "don't", "can", "I", "rap"], "I don't rap but I can sing.", "",
				Asset.WhereIsTheFieldSound));
			mStepList.push(new DialogTemplate(Level.THEATER, new <String>["Great job!"], new <Class>[Asset.DialogSound[3]],
				new <WordTemplate>[new WordTemplate(new <String>["I"], "", null, -1, true),
				new WordTemplate(new <String>["don"], "'", null, -1, true),
				new WordTemplate(new <String>["t"]),
				new WordTemplate(new <String>["rap"], "", null, -1, true),
				new WordTemplate(new <String>["but"], "", null, -1, true),
				new WordTemplate(new <String>["I"], "", null, -1, true),
				new WordTemplate(new <String>["can"], "", null, -1, true),
				new WordTemplate(new <String>["sing"], ".", null, -1, true)]));
			mStepList.push(new RewardTemplate(Level.THEATER, "QUEST REWARD", "Words:", new <String>["rap", "in", "if"]));
			mStepList.push(new DialogTemplate(Level.THEATER, new <String>["Get ready for the karaoke contest!",
				"Go back to the Lab."], new <Class>[Asset.DialogSound[3], Asset.DialogSound[3]]));
			mStepList.push(new NavigationTemplate(Level.THEATER, "CHOOSE A LOCATION",
				new <String>["The Lab", "Grocery Store", "Town Square", "Theater"], new <Boolean>[true, false, false, false]));
			
			mStepList.push(new ActivateQuestTemplate(Level.THE_LAB));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Now write a song for the karaoke contest."],
				new <Class>[Asset.DialogSound[0]]));
			mStepList.push(new SentenceDecryptingTemplate(Level.THE_LAB, new <String>["rap", "in", "if", "did"],
				"A chicken lip, a lizard hip, and alligator eyes!", "A ch_cke_ lip, a l_zard hip, and _lligator eyes!"));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Great job!"], new <Class>[Asset.DialogSound[3]],
				new <WordTemplate>[new WordTemplate(new <String>["A"]),
				new WordTemplate(new <String>["chicken"], "", null, -1, true),
				new WordTemplate(new <String>["lip"], ","),
				new WordTemplate(new <String>["a"]),
				new WordTemplate(new <String>["lizard"], "", null, -1, true),
				new WordTemplate(new <String>["hip"], ","),
				new WordTemplate(new <String>["and"]),
				new WordTemplate(new <String>["alligator"], "", null, -1, true),
				new WordTemplate(new <String>["eyes"], "!")]));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "QUEST REWARD", "Words:", new <String>["nip", "fit"]));
			mStepList.push(new DialogTemplate(Level.THE_LAB,
				new <String>["A chicken lip, a lizard hip, and alligator eyes.", "This is original!", "Let met try!",
				"Monkey legs and buzzard eggs and salamander thighs!"],
				new <Class>[Asset.DialogSound[0], Asset.DialogSound[0], Asset.DialogSound[0], Asset.DialogSound[0]]));
			
			mStepList.push(new ActivateQuestTemplate(Level.THE_LAB));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new < String > ["Keep working on that song."],
				new <Class>[Asset.DialogSound[0]]));
			mStepList.push(new SelectActivityTemplate(Level.THE_LAB,
				new <WordTemplate>[new WordTemplate(new <String>["take"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["ti"], "", ActivityType.WORD_UNSCRAMBLING),
				new WordTemplate(new <String>["up"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["Mix"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["a"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["and"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["spi"], ".", null, ActivityType.WORD_UNSCRAMBLING.ColorCode)], true));
			mStepList.push(new WordUnscramblingTemplate(Level.THE_LAB, new <String>["t", "i"], "it",
				"take _ up Mix a and spi."));
			mStepList.push(new SelectActivityTemplate(Level.THE_LAB,
				new <WordTemplate>[new WordTemplate(new <String>["take"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["it"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode, true),
				new WordTemplate(new <String>["up"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["Mix"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["a"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["and"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["spi"], ".", ActivityType.WORD_UNSCRAMBLING)], true));
			mStepList.push(new WordUnscramblingTemplate(Level.THE_LAB, new <String>["s", "p", "i"], "sip",
				"take it up Mix a and _"));
			mStepList.push(new SelectActivityTemplate(Level.THE_LAB,
				new <WordTemplate>[new WordTemplate(new <String>["take"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["it"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode, true),
				new WordTemplate(new <String>["up"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["Mix"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["a"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["and"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["sip"], ".", null, ActivityType.WORD_UNSCRAMBLING.ColorCode, true)], true));
			mStepList.push(new SentenceUnscramblingTemplate(Level.THE_LAB,
				new <String>["take", "it", "up", "Mix", "a", "and", "sip."], "Mix it up and take a sip.", "",
				Asset.WhereIsTheFieldSound));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Great job!"], new <Class>[Asset.DialogSound[3]],
				new <WordTemplate>[new WordTemplate(new <String>["take"], "", null, -1, true),
				new WordTemplate(new <String>["it"], "", null, -1, true),
				new WordTemplate(new <String>["up"], "", null, -1, true),
				new WordTemplate(new <String>["Mix"], "", null, -1, true),
				new WordTemplate(new <String>["a"], "", null, -1, true),
				new WordTemplate(new <String>["and"], "", null, -1, true),
				new WordTemplate(new <String>["sip"], ".", null, -1, true)]));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "QUEST REWARD", "Words:", new <String>["it", "sip"]));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Mix it up and take a sip.", "Wow that sounds great!",
				"It's Mama's Soup Surprise!"], new <Class>[Asset.DialogSound[0], Asset.DialogSound[0], Asset.DialogSound[0]]));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["A chicken lip, a lizard hip, and alligator eyes.",
				"Monkey legs and buzzard eggs and salamander thighs.", "Mix it up and take a sip.", "It's Mama's Soup Surprise!",
				"Rockin' tune! You are ready for the karaoke contest!"], new <Class>[Asset.DialogSound[0], Asset.DialogSound[0],
				Asset.DialogSound[0], Asset.DialogSound[0], Asset.DialogSound[0]]));
			mStepList.push(new LocationUnlockedTemplate(Level.THE_LAB, "You unlocked the karaoke contest!"));
			
			super();
		}
	}
}