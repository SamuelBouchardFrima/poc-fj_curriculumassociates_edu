package com.frimastudio.fj_curriculumassociates_edu.activity.sentencedecrypting
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.ActivityWordTemplate;
	
	public class EncryptedWordTemplate extends ActivityWordTemplate
	{
		private var mAnswer:String;
		
		public function get Answer():String	{ return mAnswer; }
		
		public function EncryptedWordTemplate(aWord:String, aEncryptedWord:String, aPunctuation:String = "")
		{
			super(aEncryptedWord, aPunctuation, ActivityType.SENTENCE_DECRYPTING);
			
			mAnswer = aWord;
		}
	}
}