package com.frimastudio.fj_curriculumassociates_edu.activity.spotlight
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	
	public class SpotlightTemplate extends ActivityTemplate
	{
		private var mRequest:String;
		private var mHighlight:String;
		private var mAnswer:int;
		private var mAudioList:Vector.<String>;
		private var mSkipInstruction:Boolean;
		
		public function get Request():String	{	return mRequest;	}
		public function get Highlight():String	{	return mHighlight;	}
		public function get Answer():int	{	return mAnswer;	}
		public function get AudioList():Vector.<String>	{	return mAudioList;	}
		public function get SkipInstruction():Boolean	{	return mSkipInstruction;	}
		
		public function SpotlightTemplate(aRequest:String, aHighlight:String, aAnswer:int, aAudioList:Vector.<String>,
			aSkipInstruction:Boolean = false)
		{
			super(Level.NONE);
			
			mStepClass = Spotlight;
			
			mRequest = aRequest;
			mHighlight = aHighlight;
			mAnswer = aAnswer;
			mAudioList = aAudioList;
			mSkipInstruction = aSkipInstruction;
		}
	}
}