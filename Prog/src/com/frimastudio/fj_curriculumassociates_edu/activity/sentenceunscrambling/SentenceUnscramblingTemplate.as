package com.frimastudio.fj_curriculumassociates_edu.activity.sentenceunscrambling
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	
	public class SentenceUnscramblingTemplate extends ActivityTemplate
	{
		private var mWordList:Vector.<String>;
		private var mAnswer:String;
		private var mRequest:String;
		private var mRequestAudio:Class;
		
		public function get WordList():Vector.<String>	{ return mWordList; }
		public function get Answer():String	{ return mAnswer; }
		public function get Request():String	{ return mRequest; }
		public function get RequestAudio():Class	{ return mRequestAudio; }
		
		public function SentenceUnscramblingTemplate(aLevel:Level, aWordList:Vector.<String>, aAnswer:String, aRequest:String,
			aRequestAudio:Class)
		{
			super(aLevel);
			
			mStepClass = SentenceUnscrambling;
			
			mWordList = aWordList;
			mAnswer = aAnswer;
			mRequest = aRequest;
			mRequestAudio = aRequestAudio;
		}
	}
}