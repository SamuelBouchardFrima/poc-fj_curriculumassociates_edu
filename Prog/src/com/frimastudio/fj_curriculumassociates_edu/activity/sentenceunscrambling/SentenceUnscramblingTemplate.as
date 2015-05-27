package com.frimastudio.fj_curriculumassociates_edu.activity.sentenceunscrambling
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	
	public class SentenceUnscramblingTemplate extends ActivityTemplate
	{
		private var mWordList:Vector.<String>;
		private var mAnswer:String;
		private var mRequest:String;
		private var mNPCAsset:Class;
		private var mPictureAsset:Class;
		
		public function get WordList():Vector.<String>
		{
			return mWordList;
		}
		
		public function get Answer():String
		{
			return mAnswer;
		}
		
		public function get Request():String
		{
			return mRequest;
		}
		
		public function get NPCAsset():Class
		{
			return mNPCAsset;
		}
		
		public function get PictureAsset():Class
		{
			return mPictureAsset;
		}
		
		public function SentenceUnscramblingTemplate(aWordList:Vector.<String>, aAnswer:String, aRequest:String, aNPCAsset:Class,
			aPictureAsset:Class)
		{
			super();
			
			mStepClass = SentenceUnscrambling;
			
			mWordList = aWordList;
			mAnswer = aAnswer;
			mRequest = aRequest;
			mNPCAsset = aNPCAsset;
			mPictureAsset = aPictureAsset;
		}
	}
}