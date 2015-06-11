package com.frimastudio.fj_curriculumassociates_edu.activity.circuit
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	
	public class CircuitTemplate extends ActivityTemplate
	{
		private var mWordList:Vector.<String>;
		private var mDistractorList:Vector.<String>;
		private var mAnswerList:Vector.<int>;
		private var mPictureAssetList:Vector.<Class>;
		private var mAudioAssetList:Vector.<Class>;
		private var mDistractorAudioList:Vector.<Class>;
		
		public function get WordList():Vector.<String>	{	return mWordList;	}
		public function get DistractorList():Vector.<String>	{	return mDistractorList;	}
		public function get AnswerList():Vector.<int>	{	return mAnswerList;	}
		public function get PictureAssetList():Vector.<Class>	{	return mPictureAssetList;	}
		public function get AudioAssetList():Vector.<Class>	{	return mAudioAssetList;	}
		public function get DistractorAudioList():Vector.<Class>	{	return mDistractorAudioList;	}
		
		public function CircuitTemplate(aWordList:Vector.<String>, aDistractorList:Vector.<String>, aAnswerList:Vector.<int>,
			aPictureAssetList:Vector.<Class>, aAudioAssetList:Vector.<Class>, aDistractorAudioList:Vector.<Class>)
		{
			super();
			
			mStepClass = Circuit;
			
			mWordList = aWordList;
			mDistractorList = aDistractorList;
			mAnswerList = aAnswerList;
			mPictureAssetList = aPictureAssetList;
			mAudioAssetList = aAudioAssetList;
			mDistractorAudioList = aDistractorAudioList;
		}
	}
}