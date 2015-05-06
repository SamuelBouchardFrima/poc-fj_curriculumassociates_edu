package com.frimastudio.fj_curriculumassociates_edu.rpt_wordcrafting
{
	import flash.events.Event;
	
	public class WordMiniEvent extends Event
	{
		public static const BURP_PIECE:String = "com.frimastudio.fj_curriculumassociates_edu.rpt_wordcrafting.WordMiniEvent::BURP_PIECE";
		
		private var mPieceList:Vector.<String>;
		
		public function get PieceList():Vector.<String>
		{
			return mPieceList;
		}
		
		public function WordMiniEvent(aType:String, aPieceList:Vector.<String>, aBubbles:Boolean = false, aCancelable:Boolean = false)
		{
			super(aType, aBubbles, aCancelable);
			
			mPieceList = aPieceList;
		}
		
		public override function clone():Event
		{
			return new WordMiniEvent(type, mPieceList, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("WordMiniEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}