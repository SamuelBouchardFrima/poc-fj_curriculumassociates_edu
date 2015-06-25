package com.frimastudio.fj_curriculumassociates_edu.activity.sentencedecrypting
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	
	public class SentenceDecryptingTemplate extends ActivityTemplate
	{
		private var mWordList:Vector.<String>;
		private var mAnswer:String;
		private var mRequest:String;
		private var mActivityWordList:Vector.<WordTemplate>;
		
		public function get WordList():Vector.<String>	{ return mWordList; }
		public function get Answer():String	{ return mAnswer; }
		public function get Request():String	{ return mRequest; }
		public function get ActivityWordList():Vector.<WordTemplate>	{ return mActivityWordList; }
		
		public function SentenceDecryptingTemplate(aLevel:Level, aWordList:Vector.<String>, aAnswer:String, aRequest:String,
			aActivityWordList:Vector.<WordTemplate>)
		{
			super(aLevel);
			
			mStepClass = SentenceDecrypting;
			
			mWordList = aWordList;
			mAnswer = aAnswer;
			mRequest = aRequest;
			mActivityWordList = aActivityWordList;
		}		
	}
}