package com.frimastudio.fj_curriculumassociates_edu.activity.wordunscrambling
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	
	public class WordUnscramblingTemplate extends ActivityTemplate
	{
		private var mLetterList:Vector.<String>;
		private var mAnswer:String;
		private var mRequest:String;
		
		public function get LetterList():Vector.<String>	{ return mLetterList; }
		public function get Answer():String	{ return mAnswer; }
		public function get Request():String	{ return mRequest; }
		
		public function WordUnscramblingTemplate(aLevel:Level, aLetterList:Vector.<String>, aAnswer:String, aRequest:String)
		{
			super(aLevel);
			
			mStepClass = WordUnscrambling;
			
			mLetterList = aLetterList;
			mAnswer = aAnswer;
			mRequest = aRequest;
		}
	}
}