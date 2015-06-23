package com.frimastudio.fj_curriculumassociates_edu.activity
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.sentencedecrypting.SentenceDecryptingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.sentenceunscrambling.SentenceUnscramblingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordcrafting.WordCraftingTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.wordunscrambling.WordUnscramblingTemplate;
	
	public class ActivityType
	{
		private static var sI:int = 0;
		private static var sInitialized:Boolean = false;
		
		public static const NONE:ActivityType = new ActivityType(sI++, "NONE", null, 0xCCCCCC);
		public static const SENTENCE_DECRYPTING:ActivityType = new ActivityType(sI++, "SENTENCE_DECRYPTING",
			SentenceDecryptingTemplate, 0xFFCC99);
		public static const WORD_UNSCRAMBLING:ActivityType = new ActivityType(sI++, "WORD_UNSCRAMBLING",
			WordUnscramblingTemplate, 0x99EEFF);
		public static const WORD_CRAFTING:ActivityType = new ActivityType(sI++, "WORD_CRAFTING",
			WordCraftingTemplate, 0xAAFF99);
		public static const SENTENCE_UNSCRAMBLING:ActivityType = new ActivityType(sI++, "SENTENCE_UNSCRAMBLING",
			SentenceUnscramblingTemplate, 0xCCCCFF, true);
		
		private var mID:int;
		private var mDescription:String;
		private var mTemplateClass:Class;
		private var mColorCode:int;
		
		public function get ID():int	{ return mID; }
		public function get Description():String	{ return mDescription; }
		public function get TemplateClass():Class	{ return mTemplateClass; }
		public function get ColorCode():int	{ return mColorCode; }
		
		public function ActivityType(aID:int, aDescription:String, aTemplateClass:Class, aColorCode:int, aInitialized:Boolean = false)
		{
			if (sInitialized)
			{
				throw new Error("ActivityType is a multiton not intended for instantiation.");
			}
			
			sInitialized = aInitialized;
			
			mID = aID;
			mDescription = aDescription;
			mTemplateClass = aTemplateClass;
			mColorCode = aColorCode;
		}
	}
}