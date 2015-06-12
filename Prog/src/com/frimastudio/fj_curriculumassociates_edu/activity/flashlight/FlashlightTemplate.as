package com.frimastudio.fj_curriculumassociates_edu.activity.flashlight
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import flash.geom.Point;
	
	public class FlashlightTemplate extends ActivityTemplate
	{
		private var mRequest:String;
		private var mHighlight:String;
		private var mAnswer:int;
		private var mPictureAssetList:Vector.<Class>;
		private var mPicturePositionList:Vector.<Point>;
		private var mAudioList:Vector.<String>;
		private var mSkipInstruction:Boolean;
		
		public function get Request():String	{	return mRequest;	}
		public function get Highlight():String	{	return mHighlight;	}
		public function get Answer():int	{	return mAnswer;	}
		public function get PictureAssetList():Vector.<Class>	{	return mPictureAssetList;	}
		public function get PicturePositionList():Vector.<Point>	{	return mPicturePositionList;	}
		public function get AudioList():Vector.<String>	{	return mAudioList;	}
		public function get SkipInstruction():Boolean	{	return mSkipInstruction;	}
		
		public function FlashlightTemplate(aRequest:String, aHighlight:String, aAnswer:int, aPictureAssetList:Vector.<Class>,
			aPicturePositionList:Vector.<Point>, aAudioList:Vector.<String>, aSkipInstruction:Boolean = false)
		{
			super();
			
			mStepClass = Flashlight;
			
			mRequest = aRequest;
			mHighlight = aHighlight;
			mAnswer = aAnswer;
			mPictureAssetList = aPictureAssetList;
			mPicturePositionList = aPicturePositionList;
			mAudioList = aAudioList;
			mSkipInstruction = aSkipInstruction;
		}
	}
}