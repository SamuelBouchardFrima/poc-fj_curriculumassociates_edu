package com.frimastudio.fj_curriculumassociates_edu.rpt_wordcrafting
{
	public class MiniFeedingDemoState
	{
		private static var sIndex:int = 0;
		private static var sStateList:Vector.<MiniFeedingDemoState> = new Vector.<MiniFeedingDemoState>();
		private static var sInitialized:Boolean = false;
		
		public static var WORD_FEEDING:MiniFeedingDemoState = new MiniFeedingDemoState(sIndex++, "WORD_FEEDING");
		public static var PIECE_SELECTING:MiniFeedingDemoState = new MiniFeedingDemoState(sIndex++, "PIECE_SELECTING");
		public static var PIECE_USING:MiniFeedingDemoState = new MiniFeedingDemoState(sIndex++, "PIECE_USING");
		public static var PIECE_SORTING:MiniFeedingDemoState = new MiniFeedingDemoState(sIndex++, "PIECE_SORTING");
		public static var WORD_SUBMITTING:MiniFeedingDemoState = new MiniFeedingDemoState(sIndex++, "WORD_SUBMITTING", true);
		
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
		
		public function get PreviousState():MiniFeedingDemoState
		{
			return sStateList[mID <= 0 ? sStateList.length - 1 : mID - 1];
		}
		
		public function get NextState():MiniFeedingDemoState
		{
			return sStateList[mID >= sStateList.length - 1 ? 0 : mID + 1];
		}
		
		public function MiniFeedingDemoState(aID:int, aDescription:String, aFinal:Boolean = false)
		{
			if (sInitialized)
			{
				throw new Error("MiniFeedingDemoState is multiton! Use any one of its public static instances.");
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