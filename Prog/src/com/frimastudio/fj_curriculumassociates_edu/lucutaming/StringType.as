package com.frimastudio.fj_curriculumassociates_edu.lucutaming
{
	import com.frimastudio.fj_curriculumassociates_edu.util.Random;
	
	public class StringType
	{
		private static var sInitialized:Boolean;
		private static var sI:int = 0;
		private static var sList:Vector.<StringType> = new Vector.<StringType>();
		
		public static const NONE:StringType = new StringType(sI++, "NONE", false);
		public static const WORD:StringType = new StringType(sI++, "WORD", true);
		public static const RHYME:StringType = new StringType(sI++, "RHYME", true);
		public static const ALLITERATION:StringType = new StringType(sI++, "ALLITERATION", true, true);
		
		public static function get RandomType():StringType
		{
			return Random.FromList(sList);
		}
		
		private var mID:int;
		private var mDescription:String;
		
		public function get ID():int	{ return mID; }
		public function get Description():String	{ return mDescription; }
		
		public function StringType(aID:int, aDescription:String, aAvailable:Boolean, aInitialized:Boolean = false)
		{
			if (sInitialized)
			{
				throw new Error("StringType is a multiton not intended for instantiation. Use one of its publig members.");
			}
			
			sInitialized = aInitialized;
			if (aAvailable)
			{
				sList.push(this);
			}
			
			mID = aID;
			mDescription = aDescription;
		}
	}
}