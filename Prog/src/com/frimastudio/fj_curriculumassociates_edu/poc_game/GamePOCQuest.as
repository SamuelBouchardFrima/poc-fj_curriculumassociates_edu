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
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	
	public class GamePOCQuest extends Quest
	{
		public function GamePOCQuest()
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			mStepList.push(new MessageTemplate(Level.THE_LAB, "Great job!", "You did Lesson 13.", Asset.RewardSound[1]));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "LESSON REWARD", "Words:", new <String>["tip", "rip", "dim", "fin"],
				Asset.RewardSound[2]));
			
			mStepList.push(new ActivateQuestTemplate(Level.THE_LAB));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["It's time to organize a karaoke contest!",
				"Here is where you should start:"], new <Class>[Asset.GameHintSound[2], Asset.GameHintSound[3]]));
			mStepList.push(new SentenceDecryptingTemplate(Level.THE_LAB, new <String>["tip", "rip", "dim", "fin"],
				"Print _ome flier_ for the karaoke conte_t!", "_____ _o_e _lie__ for the ka_aoke co__e__!",
				Asset.SentenceContentTargetSound[1],
				new <WordTemplate>[new WordTemplate(Vector.<String>("_____".split("")), "", ActivityType.SENTENCE_DECRYPTING),
				new WordTemplate(Vector.<String>("_o_e".split("")), "", ActivityType.SENTENCE_DECRYPTING),
				new WordTemplate(Vector.<String>("_lie__".split("")), "", ActivityType.SENTENCE_DECRYPTING),
				new WordTemplate(new <String>["for"]),
				new WordTemplate(new <String>["the"]),
				new WordTemplate(Vector.<String>("ka_aoke".split("")), "", ActivityType.SENTENCE_DECRYPTING),
				new WordTemplate(Vector.<String>("co__e__".split("")), "!", ActivityType.SENTENCE_DECRYPTING)],
				new <int>[4]));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["You need more words."],
				new <Class>[Asset.GameHintSound[6]], Asset.SentenceContentTargetSound[1],
				new <WordTemplate>[new WordTemplate(new <String>["Print"], "", null, -1, true),
				new WordTemplate(Vector.<String>("_ome".split("")), "", null, ActivityType.SENTENCE_DECRYPTING.ColorCode),
				new WordTemplate(Vector.<String>("flier_".split("")), "", null, ActivityType.SENTENCE_DECRYPTING.ColorCode),
				new WordTemplate(new <String>["for"]),
				new WordTemplate(new <String>["the"]),
				new WordTemplate(new <String>["karaoke"], "", null, -1, true),
				new WordTemplate(Vector.<String>("conte_t".split("")), "!", null, ActivityType.SENTENCE_DECRYPTING.ColorCode)],
				new <int>[4]));
			mStepList.push(new UseLevelPropTemplate(Level.THE_LAB, "Try clicking things to get words.", Asset.GameHintSound[7],
				new <WordTemplate>[new WordTemplate(new <String>["Print"], "", null, -1, true),
				new WordTemplate(Vector.<String>("_ome".split("")), "", null, ActivityType.SENTENCE_DECRYPTING.ColorCode),
				new WordTemplate(Vector.<String>("flier_".split("")), "", null, ActivityType.SENTENCE_DECRYPTING.ColorCode),
				new WordTemplate(new <String>["for"]),
				new WordTemplate(new <String>["the"]),
				new WordTemplate(new <String>["karaoke"], "", null, -1, true),
				new WordTemplate(Vector.<String>("conte_t".split("")), "!", null, ActivityType.SENTENCE_DECRYPTING.ColorCode)],
				new <int>[4]));
			mStepList.push(new SelectActivityTemplate(Level.THE_LAB, Asset.SentenceContentTargetSound[2],
				new <WordTemplate>[new WordTemplate(new <String>["You"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(Vector.<String>("tis".split("")), "", ActivityType.WORD_UNSCRAMBLING, -1, false),
				new WordTemplate(new <String>["on"]),
				new WordTemplate(new <String>["it"], ".")],
				//null, null, true));
				null, null, false));
			mStepList.push(new WordUnscramblingTemplate(Level.THE_LAB, new <String>["t", "i", "s"], "sit",
				Asset.SentenceContentTargetSound[2],
				new <WordTemplate>[new WordTemplate(new <String>["You"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(Vector.<String>("tis".split("")), "", ActivityType.WORD_UNSCRAMBLING, -1, false, "sit"),
				new WordTemplate(new <String>["on"]),
				new WordTemplate(new <String>["it"], ".")]));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Great job!"], new <Class>[Asset.GameHintSound[1]],
				Asset.SentenceContentTargetSound[2],
				new <WordTemplate>[new WordTemplate(new <String>["You"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(new <String>["sit"], "", null, -1, true),
				new WordTemplate(new <String>["on"]),
				new WordTemplate(new <String>["it"], ".")]));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "QUEST REWARD", "Word:", new <String>["sit"], Asset.RewardSound[3]));
			mStepList.push(new SentenceDecryptingTemplate(Level.THE_LAB, new <String>["sit"],
				"Print some fliers for the karaoke contest!", "Print _ome flier_ for the karaoke conte_t!",
				Asset.SentenceContentTargetSound[1],
				new <WordTemplate>[new WordTemplate(new <String>["Print"], "", null, -1, true),
				new WordTemplate(Vector.<String>("_ome".split("")), "", ActivityType.SENTENCE_DECRYPTING),
				new WordTemplate(Vector.<String>("flier_".split("")), "", ActivityType.SENTENCE_DECRYPTING),
				new WordTemplate(new <String>["for"]),
				new WordTemplate(new <String>["the"]),
				new WordTemplate(new <String>["karaoke"], "", null, -1, true),
				new WordTemplate(Vector.<String>("conte_t".split("")), "!", ActivityType.SENTENCE_DECRYPTING)],
				new <int>[4]));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Great job!"], new <Class>[Asset.GameHintSound[1]],
				Asset.SentenceContentTargetSound[1],
				new <WordTemplate>[new WordTemplate(new <String>["Print"], "", null, -1, true),
				new WordTemplate(new <String>["some"], "", null, -1, true),
				new WordTemplate(new <String>["fliers"], "", null, -1, true),
				new WordTemplate(new <String>["for"]),
				new WordTemplate(new <String>["the"]),
				new WordTemplate(new <String>["karaoke"], "", null, -1, true),
				new WordTemplate(new <String>["contest"], "!", null, -1, true)],
				new <int>[4]));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "QUEST REWARD", "Words:", new < String > ["pit", "sip"],
				Asset.RewardSound[3]));
			mStepList.push(new ItemUnlockedTemplate(Level.THE_LAB, "You have fliers!", Asset.FliersBitmap, Asset.RewardSound[6]));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Now give the fliers to people in town!"],
				new <Class>[Asset.GameHintSound[8]]));
			mStepList.push(new LocationUnlockedTemplate(Level.THE_LAB, "Town Square Unlocked!", Asset.RewardSound[8]));
			mStepList.push(new NavigationTemplate(Level.THE_LAB, "CHOOSE A LOCATION", new <String>["The Lab", "Town Square"],
				new <Boolean>[false, true], new <int>[1, 2]));
			
			mStepList.push(new ActivateQuestTemplate(Level.TOWN_SQUARE));
			mStepList.push(new UseItemTemplate(Level.TOWN_SQUARE, "Give a flier to this citizen.", Asset.GameHintSound[9],
				Asset.FliersBitmap));
			mStepList.push(new SelectActivityTemplate(Level.TOWN_SQUARE, Asset.SentenceContentTargetSound[3],
				new <WordTemplate>[new WordTemplate(new <String>["I"], "'"),
				new WordTemplate(new <String>["ll"]),
				new WordTemplate(new <String>["watch"]),
				new WordTemplate(Vector.<String>("ti".split("")), "", ActivityType.WORD_UNSCRAMBLING),
				new WordTemplate(Vector.<String>("fi".split("")), "", null, ActivityType.WORD_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(Vector.<String>("___".split("")), "", null, ActivityType.WORD_CRAFTING.ColorCode),
				new WordTemplate(Vector.<String>("ni".split("")), "", null, ActivityType.WORD_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["front"], ".")],
				//new <int>[7], Direction.DOWN, true));
				new <int>[7], Direction.DOWN, false));
			mStepList.push(new WordUnscramblingTemplate(Level.TOWN_SQUARE, new <String>["t", "i"], "it",
				Asset.SentenceContentTargetSound[3],
				new <WordTemplate>[new WordTemplate(new <String>["I"], "'"),
				new WordTemplate(new <String>["ll"]),
				new WordTemplate(new <String>["watch"]),
				new WordTemplate(Vector.<String>("ti".split("")), "", ActivityType.WORD_UNSCRAMBLING, -1, false, "it"),
				new WordTemplate(Vector.<String>("fi".split("")), "", null, ActivityType.WORD_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(Vector.<String>("___".split("")), "", null, ActivityType.WORD_CRAFTING.ColorCode),
				new WordTemplate(Vector.<String>("ni".split("")), "", null, ActivityType.WORD_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["front"], ".")],
				new <int>[7], Direction.DOWN));
			mStepList.push(new SelectActivityTemplate(Level.TOWN_SQUARE, Asset.SentenceContentTargetSound[3],
				new <WordTemplate>[new WordTemplate(new <String>["I"], "'"),
				new WordTemplate(new <String>["ll"]),
				new WordTemplate(new <String>["watch"]),
				new WordTemplate(new <String>["it"], "", null, -1, true),
				new WordTemplate(Vector.<String>("fi".split("")), "", ActivityType.WORD_UNSCRAMBLING),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(Vector.<String>("___".split("")), "", null, ActivityType.WORD_CRAFTING.ColorCode),
				new WordTemplate(Vector.<String>("ni".split("")), "", null, ActivityType.WORD_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["front"], ".")],
				//new <int>[7], Direction.DOWN, true));
				new <int>[7], Direction.DOWN, false));
			mStepList.push(new WordUnscramblingTemplate(Level.TOWN_SQUARE, new <String>["f", "i"], "if",
				Asset.SentenceContentTargetSound[3],
				new <WordTemplate>[new WordTemplate(new <String>["I"], "'"),
				new WordTemplate(new <String>["ll"]),
				new WordTemplate(new <String>["watch"]),
				new WordTemplate(new <String>["it"], "", null, -1, true),
				new WordTemplate(Vector.<String>("fi".split("")), "", ActivityType.WORD_UNSCRAMBLING, -1, false, "if"),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(Vector.<String>("___".split("")), "", null, ActivityType.WORD_CRAFTING.ColorCode),
				new WordTemplate(Vector.<String>("ni".split("")), "", null, ActivityType.WORD_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["front"], ".")],
				new <int>[7], Direction.DOWN));
			mStepList.push(new SelectActivityTemplate(Level.TOWN_SQUARE, Asset.SentenceContentTargetSound[3],
				new <WordTemplate>[new WordTemplate(new <String>["I"], "'"),
				new WordTemplate(new <String>["ll"]),
				new WordTemplate(new <String>["watch"]),
				new WordTemplate(new <String>["it"], "", null, -1, true),
				new WordTemplate(new <String>["if"], "", null, -1, true),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(Vector.<String>("___".split("")), "", null, ActivityType.WORD_CRAFTING.ColorCode),
				new WordTemplate(Vector.<String>("ni".split("")), "", ActivityType.WORD_UNSCRAMBLING),
				new WordTemplate(new <String>["front"], ".")],
				//new <int>[7], Direction.DOWN, true));
				new <int>[7], Direction.DOWN, false));
			mStepList.push(new WordUnscramblingTemplate(Level.TOWN_SQUARE, new <String>["n", "i"], "in",
				Asset.SentenceContentTargetSound[3],
				new <WordTemplate>[new WordTemplate(new <String>["I"], "'"),
				new WordTemplate(new <String>["ll"]),
				new WordTemplate(new <String>["watch"]),
				new WordTemplate(new <String>["it"], "", null, -1, true),
				new WordTemplate(new <String>["if"], "", null, -1, true),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(Vector.<String>("___".split("")), "", null, ActivityType.WORD_CRAFTING.ColorCode),
				new WordTemplate(Vector.<String>("ni".split("")), "", ActivityType.WORD_UNSCRAMBLING, -1, false, "in"),
				new WordTemplate(new <String>["front"], ".")],
				new <int>[7], Direction.DOWN));
			mStepList.push(new SelectActivityTemplate(Level.TOWN_SQUARE, Asset.SentenceContentTargetSound[3],
				new <WordTemplate>[new WordTemplate(new <String>["I"], "'"),
				new WordTemplate(new <String>["ll"]),
				new WordTemplate(new <String>["watch"]),
				new WordTemplate(new <String>["it"], "", null, -1, true),
				new WordTemplate(new <String>["if"], "", null, -1, true),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(Vector.<String>("___".split("")), "", ActivityType.WORD_CRAFTING),
				new WordTemplate(new <String>["in"], "", null, -1, true),
				new WordTemplate(new <String>["front"], ".")],
				//new <int>[7], Direction.DOWN, true));
				new <int>[7], Direction.DOWN, false));
			mStepList.push(new WordCraftingTemplate(Level.TOWN_SQUARE, new <String>["sip", "pit"], "sit",
				Asset.SentenceContentTargetSound[3],
				new <WordTemplate>[new WordTemplate(new <String>["I"], "'"),
				new WordTemplate(new <String>["ll"]),
				new WordTemplate(new <String>["watch"]),
				new WordTemplate(new <String>["it"], "", null, -1, true),
				new WordTemplate(new <String>["if"], "", null, -1, true),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(Vector.<String>("___".split("")), "", ActivityType.WORD_CRAFTING, -1, false, "sit"),
				new WordTemplate(new <String>["in"], "", null, -1, true),
				new WordTemplate(new <String>["front"], ".")],
				new <int>[7], Direction.DOWN));
			mStepList.push(new DialogTemplate(Level.TOWN_SQUARE, new <String>["Great job!"], new <Class>[Asset.GameHintSound[1]],
				Asset.SentenceContentTargetSound[3],
				new <WordTemplate>[new WordTemplate(new <String>["I"], "'"),
				new WordTemplate(new <String>["ll"]),
				new WordTemplate(new <String>["watch"]),
				new WordTemplate(new <String>["it"], "", null, -1, true),
				new WordTemplate(new <String>["if"], "", null, -1, true),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["can"]),
				new WordTemplate(new <String>["sit"], "", null, -1, true),
				new WordTemplate(new <String>["in"], "", null, -1, true),
				new WordTemplate(new <String>["front"], ".")],
				new <int>[7], Direction.DOWN));
			mStepList.push(new RewardTemplate(Level.TOWN_SQUARE, "QUEST REWARD", "Words:", new <String>["sit", "rid", "dim", "in"],
				Asset.RewardSound[3]));
			mStepList.push(new LocationUnlockedTemplate(Level.TOWN_SQUARE, "Grocery Store Unlocked!", Asset.RewardSound[7]));
			mStepList.push(new NavigationTemplate(Level.TOWN_SQUARE, "CHOOSE A LOCATION",
				new <String>["The Lab", "Grocery Store", "Town Square"], new <Boolean>[false, true, false], new <int>[1, 3, 2]));
			
			mStepList.push(new ActivateQuestTemplate(Level.GROCERY_STORE));
			mStepList.push(new UseItemTemplate(Level.GROCERY_STORE, "Give a flier to this citizen.", Asset.GameHintSound[9],
				Asset.FliersBitmap));
			mStepList.push(new SelectActivityTemplate(Level.GROCERY_STORE, Asset.SentenceContentTargetSound[4],
				new <WordTemplate>[new WordTemplate(Vector.<String>("___".split("")), "", null, ActivityType.WORD_CRAFTING.ColorCode),
				new WordTemplate(new <String>["you"]),
				new WordTemplate(Vector.<String>("k_ow".split("")), "", null, ActivityType.SENTENCE_DECRYPTING.ColorCode),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["love"]),
				new WordTemplate(Vector.<String>("ot".split("")), "", ActivityType.WORD_UNSCRAMBLING),
				new WordTemplate(Vector.<String>("_ing".split("")), "?", null, ActivityType.SENTENCE_DECRYPTING.ColorCode)],
				//new <int>[5], Direction.DOWN, true));
				new <int>[5], Direction.DOWN, false));
			mStepList.push(new WordUnscramblingTemplate(Level.GROCERY_STORE, new <String>["o", "t"], "to",
				Asset.SentenceContentTargetSound[4],
				new <WordTemplate>[new WordTemplate(Vector.<String>("___".split("")), "", null, ActivityType.WORD_CRAFTING.ColorCode),
				new WordTemplate(new <String>["you"]),
				new WordTemplate(Vector.<String>("k_ow".split("")), "", null, ActivityType.SENTENCE_DECRYPTING.ColorCode),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["love"]),
				new WordTemplate(Vector.<String>("ot".split("")), "", ActivityType.WORD_UNSCRAMBLING, -1, false, "to"),
				new WordTemplate(Vector.<String>("_ing".split("")), "?", null, ActivityType.SENTENCE_DECRYPTING.ColorCode)],
				new <int>[5], Direction.DOWN));
			mStepList.push(new SelectActivityTemplate(Level.GROCERY_STORE, Asset.SentenceContentTargetSound[4],
				new <WordTemplate>[new WordTemplate(Vector.<String>("___".split("")), "", ActivityType.WORD_CRAFTING),
				new WordTemplate(new <String>["you"]),
				new WordTemplate(Vector.<String>("k_ow".split("")), "", null, ActivityType.SENTENCE_DECRYPTING.ColorCode),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["love"]),
				new WordTemplate(new <String>["to"], "", null, -1, true),
				new WordTemplate(Vector.<String>("_ing".split("")), "?", null, ActivityType.SENTENCE_DECRYPTING.ColorCode)],
				//new <int>[5], Direction.DOWN, true));
				new <int>[5], Direction.DOWN, false));
			mStepList.push(new WordCraftingTemplate(Level.GROCERY_STORE, new <String>["rid", "dim"], "did",
				Asset.SentenceContentTargetSound[4],
				new <WordTemplate>[new WordTemplate(Vector.<String>("___".split("")), "", ActivityType.WORD_CRAFTING, -1, false, "did"),
				new WordTemplate(new <String>["you"]),
				new WordTemplate(Vector.<String>("k_ow".split("")), "", null, ActivityType.SENTENCE_DECRYPTING.ColorCode),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["love"]),
				new WordTemplate(new <String>["to"], "", null, -1, true),
				new WordTemplate(Vector.<String>("_ing".split("")), "?", null, ActivityType.SENTENCE_DECRYPTING.ColorCode)],
				new <int>[5], Direction.DOWN));
			mStepList.push(new SentenceDecryptingTemplate(Level.GROCERY_STORE, new <String>["sit", "in"],
				"Did you know I love to sing?", "Did you k_ow I love to _ing?", Asset.SentenceContentTargetSound[4],
				new <WordTemplate>[new WordTemplate(new <String>["Did"], "", null, -1, true),
				new WordTemplate(new <String>["you"]),
				new WordTemplate(Vector.<String>("k_ow".split("")), "", ActivityType.SENTENCE_DECRYPTING),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["love"]),
				new WordTemplate(new <String>["to"], "", null, -1, true),
				new WordTemplate(Vector.<String>("_ing".split("")), "?", ActivityType.SENTENCE_DECRYPTING)],
				new <int>[5], Direction.DOWN));
			mStepList.push(new DialogTemplate(Level.GROCERY_STORE, new <String>["Great job!"], new <Class>[Asset.GameHintSound[1]],
				Asset.SentenceContentTargetSound[4],
				new <WordTemplate>[new WordTemplate(new <String>["Did"], "", null, -1, true),
				new WordTemplate(new <String>["you"]),
				new WordTemplate(new <String>["know"], "", null, -1, true),
				new WordTemplate(new <String>["I"]),
				new WordTemplate(new <String>["love"]),
				new WordTemplate(new <String>["to"], "", null, -1, true),
				new WordTemplate(new <String>["sing"], "?", null, -1, true)],
				new <int>[5], Direction.DOWN));
			mStepList.push(new RewardTemplate(Level.GROCERY_STORE, "QUEST REWARD", "Words:", new <String>["did", "rip"],
				Asset.RewardSound[3]));
			mStepList.push(new DialogTemplate(Level.GROCERY_STORE,
				new <String>["We need more people for the contest! Maybe we will find some at the Theater."],
				new <Class>[Asset.GameHintSound[11]]));
			mStepList.push(new LocationUnlockedTemplate(Level.GROCERY_STORE, "Theater Unlocked!", Asset.RewardSound[9]));
			mStepList.push(new NavigationTemplate(Level.GROCERY_STORE, "CHOOSE A LOCATION",
				new <String>["The Lab", "Grocery Store", "Town Square", "Theater"], new <Boolean>[false, false, false, true],
				new <int>[1, 3, 2, 4]));
			
			mStepList.push(new ActivateQuestTemplate(Level.THEATER));
			mStepList.push(new UseItemTemplate(Level.THEATER, "Give a flier to this citizen.", Asset.GameHintSound[9],
				Asset.FliersBitmap));
			mStepList.push(new SelectActivityTemplate(Level.THEATER, Asset.SentenceContentTargetSound[5],
				new <WordTemplate>[new WordTemplate(new <String>["but"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["sing"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["don't"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["can"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(Vector.<String>("___".split("")), ".", ActivityType.WORD_CRAFTING)],
				//null, Direction.DOWN, true));
				null, Direction.DOWN, false));
			mStepList.push(new DialogTemplate(Level.THEATER, new <String>["You are running out of words."],
				new <Class>[Asset.GameHintSound[12]], Asset.SentenceContentTargetSound[5],
				new <WordTemplate>[new WordTemplate(new <String>["but"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["sing"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["don't"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["can"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(Vector.<String>("___".split("")), ".", null, ActivityType.WORD_CRAFTING.ColorCode)],
				null, Direction.DOWN));
			mStepList.push(new UseLevelPropTemplate(Level.THEATER, "Find something in the room that will help you.",
				Asset.GameHintSound[13],
				new <WordTemplate>[new WordTemplate(new <String>["but"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["sing"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["don't"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["can"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(Vector.<String>("___".split("")), ".", null, ActivityType.WORD_CRAFTING.ColorCode)],
				null, Direction.DOWN));
			mStepList.push(new SentenceUnscramblingTemplate(Level.THEATER, new <String>["at", "rat!", "fat", "Look", "the"],
				"Look at the fat rat!", "", Asset.SentenceContentTargetSound[6],
				new <WordTemplate>[new WordTemplate(new <String>["at"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "look"),
				new WordTemplate(new <String>["rat!"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "at"),
				new WordTemplate(new <String>["fat"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "the"),
				new WordTemplate(new <String>["Look"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "fat"),
				new WordTemplate(new <String>["the"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "rat")]));
			mStepList.push(new RewardTemplate(Level.THEATER, "QUEST REWARD", "Words:", new <String>["fat", "rat"],
				Asset.RewardSound[3]));
			
			mStepList.push(new ActivateQuestTemplate(Level.THEATER));
			mStepList.push(new SelectActivityTemplate(Level.THEATER, Asset.SentenceContentTargetSound[5],
				new <WordTemplate>[new WordTemplate(new <String>["but"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["sing"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["don't"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["can"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(Vector.<String>("___".split("")), ".", ActivityType.WORD_CRAFTING)],
				//null, Direction.DOWN, true));
				null, Direction.DOWN, false));
			mStepList.push(new WordCraftingTemplate(Level.THEATER, new <String>["rat", "fat", "rip", "did"], "rap",
				Asset.SentenceContentTargetSound[5],
				new <WordTemplate>[new WordTemplate(new <String>["but"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["sing"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["don't"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["can"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(Vector.<String>("___".split("")), ".", ActivityType.WORD_CRAFTING, -1, false, "rap")],
				null, Direction.DOWN));
			mStepList.push(new SelectActivityTemplate(Level.THEATER, Asset.SentenceContentTargetSound[5],
				new <WordTemplate>[new WordTemplate(new <String>["but"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["sing"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["don't"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["can"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["I"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["rap"], ".", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode, true)],
				null, Direction.DOWN, true));
			mStepList.push(new SentenceUnscramblingTemplate(Level.THEATER,
				new <String>["but", "I", "sing", "don't", "can", "I", "rap."], "I don't sing but I can rap.", "",
				Asset.SentenceContentTargetSound[5],
				new <WordTemplate>[new WordTemplate(new <String>["but"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "i"),
				new WordTemplate(new <String>["I"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "dont"),
				new WordTemplate(new <String>["sing."], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "sing"),
				new WordTemplate(new <String>["don't"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "but"),
				new WordTemplate(new <String>["can"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "i"),
				new WordTemplate(new <String>["I"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "can"),
				new WordTemplate(new <String>["rap"], "", ActivityType.SENTENCE_UNSCRAMBLING, -1, false, "rap")],
				null, Direction.DOWN));
			mStepList.push(new DialogTemplate(Level.THEATER, new <String>["Great job!"], new <Class>[Asset.GameHintSound[1]],
				Asset.SentenceContentTargetSound[5],
				new <WordTemplate>[new WordTemplate(new <String>["I"], "", null, -1, true),
				new WordTemplate(new <String>["don't"], "", null, -1, true),
				new WordTemplate(new <String>["sing"], "", null, -1, true),
				new WordTemplate(new <String>["but"], "", null, -1, true),
				new WordTemplate(new <String>["I"], "", null, -1, true),
				new WordTemplate(new <String>["can"], "", null, -1, true),
				new WordTemplate(new <String>["rap"], ".", null, -1, true)]));
			mStepList.push(new RewardTemplate(Level.THEATER, "QUEST REWARD", "Words:", new <String>["rap", "in", "if"],
				Asset.RewardSound[3]));
			mStepList.push(new DialogTemplate(Level.THEATER, new <String>["Get ready for the karaoke contest!",
				"Go back to the Lab."], new <Class>[Asset.GameHintSound[15], Asset.GameHintSound[16]]));
			mStepList.push(new NavigationTemplate(Level.THEATER, "CHOOSE A LOCATION",
				new <String>["The Lab", "Grocery Store", "Town Square", "Theater"], new <Boolean>[true, false, false, false],
				new <int>[1, 3, 2, 4]));
			
			mStepList.push(new ActivateQuestTemplate(Level.THE_LAB));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Now write a song for the karaoke contest."],
				new <Class>[Asset.GameHintSound[17]]));
			mStepList.push(new SentenceDecryptingTemplate(Level.THE_LAB, new <String>["rap", "in", "if", "did"],
				"A chicken lip, a lizard hip, and alligator eyes!", "A ch_cke_ lip, a l_zard hip, and _lligator eyes!",
				Asset.SentenceContentTargetSound[7],
				new <WordTemplate>[new WordTemplate(new <String>["A"]),
				new WordTemplate(Vector.<String>("ch_cke_".split("")), "", ActivityType.SENTENCE_DECRYPTING),
				new WordTemplate(new <String>["lip"], ","),
				new WordTemplate(new <String>["a"]),
				new WordTemplate(Vector.<String>("l_zard".split("")), "", ActivityType.SENTENCE_DECRYPTING),
				new WordTemplate(new <String>["hip"], ","),
				new WordTemplate(new <String>["and"]),
				new WordTemplate(Vector.<String>("_lligator".split("")), "", ActivityType.SENTENCE_DECRYPTING),
				new WordTemplate(new <String>["eyes"], "!")],
				new <int>[4, 7], Direction.NONE));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Great job!"], new <Class>[Asset.GameHintSound[1]],
				Asset.SentenceContentTargetSound[7],
				new <WordTemplate>[new WordTemplate(new <String>["A"]),
				new WordTemplate(new <String>["chicken"], "", null, -1, true),
				new WordTemplate(new <String>["lip"], ","),
				new WordTemplate(new <String>["a"]),
				new WordTemplate(new <String>["lizard"], "", null, -1, true),
				new WordTemplate(new <String>["hip"], ","),
				new WordTemplate(new <String>["and"]),
				new WordTemplate(new <String>["alligator"], "", null, -1, true),
				new WordTemplate(new <String>["eyes"], "!")],
				new <int>[4, 7], Direction.NONE));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "QUEST REWARD", "Words:", new <String>["nip", "fit"],
				Asset.RewardSound[3]));
			mStepList.push(new DialogTemplate(Level.THE_LAB,
				new <String>["A chicken lip, a lizard hip, and alligator eyes.", "This is original!", "Let met try!",
				"Monkey legs and buzzard eggs and salamander thighs!"],
				new <Class>[Asset.SentenceContentTargetSound[7], Asset.GameHintSound[18], Asset.GameHintSound[19],
				Asset.GameHintSound[22]]));
			
			mStepList.push(new ActivateQuestTemplate(Level.THE_LAB));
			mStepList.push(new DialogTemplate(Level.THE_LAB, new <String>["Keep working on that song."],
				new <Class>[Asset.GameHintSound[20]]));
			mStepList.push(new SelectActivityTemplate(Level.THE_LAB, Asset.SentenceContentTargetSound[8],
				new <WordTemplate>[new WordTemplate(new <String>["take"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(Vector.<String>("ti".split("")), "", ActivityType.WORD_UNSCRAMBLING),
				new WordTemplate(new <String>["up"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["Mix"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["a"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["and"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(Vector.<String>("spi".split("")), ".", null, ActivityType.WORD_UNSCRAMBLING.ColorCode)],
				//null, Direction.NONE, true));
				null, Direction.NONE, false));
			mStepList.push(new WordUnscramblingTemplate(Level.THE_LAB, new <String>["t", "i"], "it",
				Asset.SentenceContentTargetSound[8],
				new <WordTemplate>[new WordTemplate(new <String>["take"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(Vector.<String>("ti".split("")), "", ActivityType.WORD_UNSCRAMBLING, -1, false, "it"),
				new WordTemplate(new <String>["up"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["Mix"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["a"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["and"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(Vector.<String>("spi".split("")), ".", null, ActivityType.WORD_UNSCRAMBLING.ColorCode)],
				null, Direction.NONE));
			mStepList.push(new SelectActivityTemplate(Level.THE_LAB, Asset.SentenceContentTargetSound[8],
				new <WordTemplate>[new WordTemplate(new <String>["take"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["it"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode, true),
				new WordTemplate(new <String>["up"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["Mix"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["a"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["and"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(Vector.<String>("spi".split("")), ".", ActivityType.WORD_UNSCRAMBLING)],
				//null, Direction.NONE, true));
				null, Direction.NONE, false));
			mStepList.push(new WordUnscramblingTemplate(Level.THE_LAB, new <String>["s", "p", "i"], "sip",
				Asset.SentenceContentTargetSound[8],
				new <WordTemplate>[new WordTemplate(new <String>["take"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["it"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode, true),
				new WordTemplate(new <String>["up"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["Mix"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["a"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["and"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(Vector.<String>("spi".split("")), ".", ActivityType.WORD_UNSCRAMBLING, -1, false, "sip")],
				null, Direction.NONE));
			mStepList.push(new SelectActivityTemplate(Level.THE_LAB, Asset.SentenceContentTargetSound[8],
				new <WordTemplate>[new WordTemplate(new <String>["take"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["it"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode, true),
				new WordTemplate(new <String>["up"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["Mix"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["a"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["and"], "", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode),
				new WordTemplate(new <String>["sip"], ".", null, ActivityType.SENTENCE_UNSCRAMBLING.ColorCode, true)],
				null, Direction.NONE, true));
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
				new <WordTemplate>[new WordTemplate(new <String>["Mix"], "", null, -1, true),
				new WordTemplate(new <String>["it"], "", null, -1, true),
				new WordTemplate(new <String>["up"], "", null, -1, true),
				new WordTemplate(new <String>["and"], "", null, -1, true),
				new WordTemplate(new <String>["take"], "", null, -1, true),
				new WordTemplate(new <String>["a"], "", null, -1, true),
				new WordTemplate(new <String>["sip"], ".", null, -1, true)],
				null, Direction.NONE));
			mStepList.push(new RewardTemplate(Level.THE_LAB, "QUEST REWARD", "Words:", new <String>["it", "sip"],
				Asset.RewardSound[3]));
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