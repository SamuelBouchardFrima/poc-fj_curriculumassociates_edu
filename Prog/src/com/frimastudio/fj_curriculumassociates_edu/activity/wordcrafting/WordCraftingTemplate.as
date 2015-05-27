package com.frimastudio.fj_curriculumassociates_edu.activity.wordcrafting
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	
	public class WordCraftingTemplate extends ActivityTemplate
	{
		private var mWordList:Vector.<String>;
		private var mAnswer:String;
		private var mRequest:String;
		private var mNPCAsset:Class;
		private var mPropAsset:Class;
		
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
		
		public function get PropAsset():Class 
		{
			return mPropAsset;
		}
		
		public function WordCraftingTemplate(aWordList:Vector.<String>, aAnswer:String, aRequest:String, aNPCAsset:Class,
			aPropAsset:Class)
		{
			super();
			
			mStepClass = WordCrafting;
			
			mWordList = aWordList;
			mAnswer = aAnswer;
			mRequest = aRequest;
			mNPCAsset = aNPCAsset;
			mPropAsset = aPropAsset;
		}
	}
}