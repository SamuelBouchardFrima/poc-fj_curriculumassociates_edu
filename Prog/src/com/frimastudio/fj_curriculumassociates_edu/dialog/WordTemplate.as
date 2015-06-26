package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	
	public class WordTemplate
	{
		private var mChunkList:Vector.<String>;
		private var mPunctuation:String;
		private var mActivityToLaunch:ActivityType;
		private var mColorCode:int;
		private var mProgressDone:Boolean;
		
		public function get ChunkList():Vector.<String>	{ return mChunkList; }
		public function set ChunkList(aValue:Vector.<String>):void	{ mChunkList = aValue; }
		
		public function get Punctuation():String	{ return mPunctuation; }
		
		public function get ActivityToLaunch():ActivityType	{ return mActivityToLaunch; }
		public function set ActivityToLaunch(aValue:ActivityType):void
		{
			mActivityToLaunch = aValue;
			mColorCode = mActivityToLaunch.ColorCode;
		}
		
		public function get ColorCode():int	{ return mColorCode; }
		public function set ColorCode(aValue:int):void	{ mColorCode = aValue; }
		
		public function get ProgressDone():Boolean	{ return mProgressDone; }
		public function set ProgressDone(aValue:Boolean):void	{ mProgressDone = aValue; }
		
		public function WordTemplate(aChunkList:Vector.<String>, aPunctuation:String = "",
			aActivityToLaunch:ActivityType = null, aColorCodeOverride:int = -1, aProgressDone:Boolean = false)
		{
			mChunkList = aChunkList;
			mPunctuation = aPunctuation;
			mActivityToLaunch = (aActivityToLaunch ? aActivityToLaunch : ActivityType.NONE);
			mColorCode = (aColorCodeOverride == -1 ? mActivityToLaunch.ColorCode : aColorCodeOverride);
			mProgressDone = aProgressDone;
		}
	}
}