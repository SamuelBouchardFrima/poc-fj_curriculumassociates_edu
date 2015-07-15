package com.frimastudio.fj_curriculumassociates_edu.inventory
{
	public class CardType
	{
		private static var sI:int = 0;
		private static var sInitialized:Boolean = false;
		
		public static const NONE:CardType = new CardType(sI++, "NONE");
		public static const LETTER_PATTERN:CardType = new CardType(sI++, "LETTER_PATTERN", true);
		
		private var mID:int;
		private var mDescription:String;
		
		public function get ID():int	{ return mID; }
		public function get Description():String	{ return mDescription; }
		
		public function CardType(aID:int, aDescription:String, aInitialized:Boolean = false)
		{
			if (sInitialized)
			{
				throw new Error("CardType is multiton and not intended for initialization. Use its public members.");
			}
			
			mID = aID;
			mDescription = aDescription;
			sInitialized = aInitialized;
		}
	}
}