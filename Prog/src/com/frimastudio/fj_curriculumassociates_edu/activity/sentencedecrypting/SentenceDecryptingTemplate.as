package com.frimastudio.fj_curriculumassociates_edu.activity.sentencedecrypting
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	
	public class SentenceDecryptingTemplate extends ActivityTemplate
	{
		private var mWordList:Vector.<String>;
		private var mAnswer:String;
		private var mRequest:String;
		
		public function get WordList():Vector.<String>	{ return mWordList; }
		public function get Answer():String	{ return mAnswer; }
		public function get Request():String	{ return mRequest; }
		
		public function SentenceDecryptingTemplate(aLevel:Level, aWordList:Vector.<String>, aAnswer:String, aRequest:String)
		{
			super(aLevel);
			
			mStepClass = SentenceDecrypting;
			
			mWordList = aWordList;
			mAnswer = aAnswer;
			mRequest = aRequest;
		}		
	}
}