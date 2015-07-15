package com.frimastudio.fj_curriculumassociates_edu.popup.reward
{
	public class RewardType
	{
		private static var sI:int = 0;
		private static var sInitialized:Boolean;
		
		public static const NONE:RewardType = new RewardType(sI++, "NONE");
		public static const WORD:RewardType = new RewardType(sI++, "WORD");
		public static const LETTER_PATTERN_CARD:RewardType = new RewardType(sI++, "LETTER_PATTERN_CARD", true);
		
		private var mID:int;
		private var mDescription:String;
		
		public function get ID():int	{ return mID; }
		public function get Description():String	{ return mDescription; }
		
		public function RewardType(aID:int, aDescription:String, aInitialized:Boolean = false)
		{
			if (sInitialized)
			{
				throw new Error("RewardType is multiton and not intended for instantiation. Use its public members.");
			}
			
			mID = aID;
			mDescription = aDescription;
			sInitialized = aInitialized;
		}
	}
}