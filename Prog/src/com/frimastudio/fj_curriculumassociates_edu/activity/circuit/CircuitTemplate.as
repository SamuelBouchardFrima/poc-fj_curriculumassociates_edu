package com.frimastudio.fj_curriculumassociates_edu.activity.circuit
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	
	public class CircuitTemplate extends ActivityTemplate
	{
		private var mWordList:Vector.<String>;
		private var mDistractorList:Vector.<String>;
		private var mAnswerList:Vector.<int>;
		private var mSkipInstruction:Boolean;
		
		public function get WordList():Vector.<String>	{	return mWordList;	}
		public function get DistractorList():Vector.<String>	{	return mDistractorList;	}
		public function get AnswerList():Vector.<int>	{	return mAnswerList;	}
		public function get SkipInstruction():Boolean	{	return mSkipInstruction;	}
		
		public function CircuitTemplate(aWordList:Vector.<String>, aDistractorList:Vector.<String>, aAnswerList:Vector.<int>,
			aSkipInstruction:Boolean = false)
		{
			super();
			
			mStepClass = Circuit;
			
			mWordList = aWordList;
			mDistractorList = aDistractorList;
			mAnswerList = aAnswerList;
			mSkipInstruction = aSkipInstruction;
		}
	}
}