package com.frimastudio.fj_curriculumassociates_edu.activity.activitybox
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	
	public class WordTemplate
	{
		protected var mChunkList:Vector.<String>;
		protected var mPunctuation:String;
		protected var mActivityToLaunch:ActivityType;
		protected var mColorCode:int;
		protected var mProgressDone:Boolean;
		protected var mVO:String;
		
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
		
		public function get VO():String	{ return mVO; }
		
		public function WordTemplate(aChunkList:Vector.<String>, aPunctuation:String = "", aActivityToLaunch:ActivityType = null,
			aColorCodeOverride:int = -1, aProgressDone:Boolean = false, aVO:String = null)
		{
			mChunkList = aChunkList;
			mPunctuation = aPunctuation;
			mActivityToLaunch = (aActivityToLaunch ? aActivityToLaunch : ActivityType.NONE);
			mColorCode = (aColorCodeOverride == -1 ? mActivityToLaunch.ColorCode : aColorCodeOverride);
			mProgressDone = aProgressDone;
			mVO = aVO;
		}
	}
}