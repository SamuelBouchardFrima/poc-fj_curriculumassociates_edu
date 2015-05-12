package com.frimastudio.fj_curriculumassociates_edu.rpt_sentenceunscrambling
{
	public class WordDraggingDemoState
	{
		private static var sIndex:int = 0;
		private static var sStateList:Vector.<WordDraggingDemoState> = new Vector.<WordDraggingDemoState>();
		private static var sInitialized:Boolean = false;
		
		public static var WORD_SELECTING:WordDraggingDemoState = new WordDraggingDemoState(sIndex++, "WORD_SELECTING");
		public static var WORD_SORTING:WordDraggingDemoState = new WordDraggingDemoState(sIndex++, "WORD_SORTING");
		public static var SENTENCE_SUBMITTING:WordDraggingDemoState = new WordDraggingDemoState(sIndex++, "SENTENCE_SUBMITTING", true);
		
		private var mID:int;
		private var mDescription:String;
		
		public function get ID():int
		{
			return mID;
		}
		
		public function get Description():String
		{
			return mDescription;
		}
		
		public function get PreviousState():WordDraggingDemoState
		{
			return sStateList[mID <= 0 ? sStateList.length - 1 : mID - 1];
		}
		
		public function get NextState():WordDraggingDemoState
		{
			return sStateList[mID >= sStateList.length - 1 ? 0 : mID + 1];
		}
		
		public function WordDraggingDemoState(aID:int, aDescription:String, aFinal:Boolean = false)
		{
			if (sInitialized)
			{
				throw new Error("WordDraggingDemoState is multiton! Use any one of its public static instances.");
				return;
			}
			
			if (aFinal)
			{
				sInitialized = true;
			}
			
			mID = aID;
			mDescription = aDescription;
			
			sStateList.push(this);
		}
	}
}