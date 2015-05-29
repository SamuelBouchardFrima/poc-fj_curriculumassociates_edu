package com.frimastudio.fj_curriculumassociates_edu.activity.spotlight
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	
	public class SpotlightTemplate extends ActivityTemplate
	{
		private var mRequest:String;
		private var mHighlight:String;
		private var mAnswer:int;
		private var mAudioAssetList:Vector.<Class>;
		
		public function get Request():String	{	return mRequest;	}
		public function get Highlight():String	{	return mHighlight;	}
		public function get Answer():int	{	return mAnswer;	}
		public function get AudioAssetList():Vector.<Class>	{	return mAudioAssetList;	}
		
		public function SpotlightTemplate(aRequest:String, aHighlight:String, aAnswer:int, aAudioAssetList:Vector.<Class>)
		{
			super();
			
			mStepClass = Spotlight;
			
			mRequest = aRequest;
			mHighlight = aHighlight;
			mAnswer = aAnswer;
			mAudioAssetList = aAudioAssetList;
		}
	}
}