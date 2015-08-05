package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	public class SpeakerType
	{
		private static var sInitialized:Boolean;
		private static var sI:int = 0;
		
		public static const NONE:SpeakerType = new SpeakerType(sI++, "NONE");
		public static const PLAYER:SpeakerType = new SpeakerType(sI++, "PLAYER");
		public static const PLORY:SpeakerType = new SpeakerType(sI++, "PLORY");
		public static const YOOP:SpeakerType = new SpeakerType(sI++, "YOOP");
		public static const NPC:SpeakerType = new SpeakerType(sI++, "NPC", true);
		
		private var mID:int;
		private var mDescription:String;
		
		public function get ID():int	{ return mID; }
		public function get Description():String	{ return mDescription; }
		
		public function SpeakerType(aID:int, aDescription:String, aInitialized:Boolean = false)
		{
			if (sInitialized)
			{
				throw new Error("SpeakerType is a multiton not intended for instantiation. Use one of its public members.");
				return;
			}
			
			sInitialized = aInitialized;
			
			mID = aID;
			mDescription = aDescription;
		}
	}
}