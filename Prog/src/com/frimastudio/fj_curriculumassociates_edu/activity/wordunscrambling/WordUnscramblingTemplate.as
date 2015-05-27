package com.frimastudio.fj_curriculumassociates_edu.activity.wordunscrambling
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	
	public class WordUnscramblingTemplate extends ActivityTemplate
	{
		private var mLetterList:Vector.<String>;
		private var mAnswer:String;
		private var mRequest:String;
		private var mNPCAsset:Class;
		
		public function get LetterList():Vector.<String>
		{
			return mLetterList;
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
		
		public function WordUnscramblingTemplate(aLetterList:Vector.<String>, aAnswer:String, aRequest:String, aNPCAsset:Class)
		{
			super();
			
			mStepClass = WordUnscrambling;
			
			mLetterList = aLetterList;
			mAnswer = aAnswer;
			mRequest = aRequest;
			mNPCAsset = aNPCAsset;
		}
	}
}