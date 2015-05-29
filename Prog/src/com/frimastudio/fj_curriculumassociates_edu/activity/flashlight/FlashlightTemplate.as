package com.frimastudio.fj_curriculumassociates_edu.activity.flashlight
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	
	public class FlashlightTemplate extends ActivityTemplate
	{
		private var mRequest:String;
		private var mAnswer:int;
		private var mPictureAssetList:Vector.<Class>;
		
		public function get Request():String	{	return mRequest;	}
		
		public function get Answer():int	{	return mAnswer;	}
		
		public function get PictureAssetList():Vector.<Class>	{	return mPictureAssetList;	}
		
		public function FlashlightTemplate(aRequest:String, aAnswer:int, aPictureAssetList:Vector.<Class>)
		{
			super();
			
			mStepClass = Flashlight;
			
			mRequest = aRequest;
			mAnswer = aAnswer;
			mPictureAssetList = aPictureAssetList;
		}
	}
}