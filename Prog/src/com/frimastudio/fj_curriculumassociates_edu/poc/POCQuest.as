package com.frimastudio.fj_curriculumassociates_edu.poc
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.sentenceunscrambling.SentenceUnscramblingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordcrafting.WordCraftingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordunscrambling.WordUnscramblingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.DialogTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class POCQuest extends Quest
	{
		public function POCQuest()
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			mStepList.push(new DialogTemplate(new <String>["Hello!", "I need your help.", "I forgot my name."], Asset.NPCBitmap));
			
			mStepList.push(new WordUnscramblingTemplate(new <String>["s", "t", "p", "o", "i", "a", "l", "g", "m"],
				"Sam", "I am _.", Asset.NPCBitmap));
			
			//mStepList.push(new DialogTemplate(new <String>["I am Sam!", "See you later!"], Asset.NPCBitmap));
			mStepList.push(new DialogTemplate(new <String>["I am Sam!", "Let's go for a hike."], Asset.NPCBitmap));
			//mStepList.push(new DialogTemplate(new <String>["I am Sam!", "I am also thirsty.", "My cup is empty."], Asset.NPCBitmap));
			
			//mStepList.push(new WordCraftingTemplate(new <String>["hill", "felt", "hall", "fair"], "fill", "I need to _ up this cup.",
				//Asset.NPCBitmap, Asset.CupBitmap));
			
			//mStepList.push(new DialogTemplate(new <String>["I feel better!", "Let's go for a hike."], Asset.NPCBitmap));
			
			mStepList.push(new SentenceUnscramblingTemplate(new <String>["field", "hill", "on", "sun", "is", "the", "a"],
				"The field is on a hill.", "Where is the field?", Asset.NPCBitmap, Asset.FieldBitmap));
			
			mStepList.push(new DialogTemplate(new <String>["That was fun!", "See you later!"], Asset.NPCBitmap));
			
			super();
		}
	}
}