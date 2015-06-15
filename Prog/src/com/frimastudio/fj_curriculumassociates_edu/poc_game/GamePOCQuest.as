package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.sentenceunscrambling.SentenceUnscramblingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordcrafting.WordCraftingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordunscrambling.WordUnscramblingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.DialogTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class GamePOCQuest extends Quest
	{
		public function GamePOCQuest()
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			mStepList.push(new DialogTemplate(new <String>["Hello!", "I need your help.", "I forgot my name."],
				new <Class>[Asset.DialogSound[0], Asset.DialogSound[1], Asset.DialogSound[2]], Asset.NPCBitmap));
			
			mStepList.push(new WordUnscramblingTemplate(new <String>["s", "t", "p", "o", "a", "m"],
				"Sam", "I am _.", Asset.NPCBitmap));
			
			mStepList.push(new DialogTemplate(new <String>["I am Sam!", "I am also thirsty.", "My cup is empty."],
				new <Class>[Asset.DialogSound[3], Asset.DialogSound[4], Asset.DialogSound[5]], Asset.NPCBitmap));
			
			mStepList.push(new WordCraftingTemplate(new <String>["hill", "felt", "hall", "fair"], "fill", "I need to _ up this cup.",
				Asset.NPCBitmap, Asset.CupBitmap));
			
			mStepList.push(new DialogTemplate(new <String>["I feel better!", "Let's go for a hike."],
				new <Class>[Asset.DialogSound[6], Asset.DialogSound[7]], Asset.NPCBitmap));
			
			mStepList.push(new SentenceUnscramblingTemplate(new <String>["field", "hill", "on", "sun", "is", "the", "a"],
				"The field is on a hill.", "Where is the field?", Asset.WhereIsTheFieldSound, Asset.NPCBitmap, Asset.FieldBitmap));
			
			mStepList.push(new DialogTemplate(new <String>["That was fun!", "See you later!"],
				new <Class>[Asset.DialogSound[8], Asset.DialogSound[9]], Asset.NPCBitmap));
			
			super();
		}
	}
}