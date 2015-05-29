package com.frimastudio.fj_curriculumassociates_edu.activity.flashlight
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	
	public class FlashlightTemplate extends ActivityTemplate
	{
		private var mRequest:String;
		private var mHighlight:String;
		private var mAnswer:int;
		private var mPictureAssetList:Vector.<Class>;
		private var mAudioAssetList:Vector.<Class>;
		
		public function get Request():String	{	return mRequest;	}
		public function get Highlight():String	{	return mHighlight;	}
		public function get Answer():int	{	return mAnswer;	}
		public function get PictureAssetList():Vector.<Class>	{	return mPictureAssetList;	}
		public function get AudioAssetList():Vector.<Class>	{	return mAudioAssetList;	}
		
		public function FlashlightTemplate(aRequest:String, aHighlight:String, aAnswer:int, aPictureAssetList:Vector.<Class>,
			aAudioAssetList:Vector.<Class>)
		{
			super();
			
			mStepClass = Flashlight;
			
			mRequest = aRequest;
			mHighlight = aHighlight;
			mAnswer = aAnswer;
			mPictureAssetList = aPictureAssetList;
			mAudioAssetList = aAudioAssetList;
		}
	}
}