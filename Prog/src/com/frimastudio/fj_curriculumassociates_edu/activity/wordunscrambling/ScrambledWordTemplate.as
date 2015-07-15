package com.frimastudio.fj_curriculumassociates_edu.activity.wordunscrambling
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.ActivityWordTemplate;
	
	public class ScrambledWordTemplate extends ActivityWordTemplate
	{
		private var mAnswer:String;
		
		public function get Answer():String	{ return mAnswer; }
		
		public function ScrambledWordTemplate(aWord:String, aScrambledWord:String, aPunctuation:String = "")
		{
			super(aScrambledWord, aPunctuation, ActivityType.WORD_UNSCRAMBLING);
			
			mAnswer = aWord;
		}
	}
}