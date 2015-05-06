package com.frimastudio.fj_curriculumassociates_edu.ui.piecetray {
	import flash.events.Event;
	
	public class PieceTrayEvent extends Event
	{
		public static const PIECE_CAPTURED:String	= "com.frimastudio.fj_curriculumassociates_edu.piecetray.PieceTrayEvent::PIECE_CAPTURED";
		public static const PIECE_FREED:String		= "com.frimastudio.fj_curriculumassociates_edu.piecetray.PieceTrayEvent::PIECE_FREED";
		
		private var mPiece:Piece;
		
		public function get EventPiece():Piece	{	return mPiece;	}
		
		public function PieceTrayEvent(aType:String, aPiece:Piece = null, aBubbles:Boolean = false, aCancelable:Boolean = false)
		{
			super(aType, aBubbles, aCancelable);
			
			mPiece = aPiece;
		}
		
		override public function clone():Event
		{
			return new PieceTrayEvent(type, mPiece, bubbles, cancelable);
		}
		
		override public function toString():String
		{
			return formatToString("PieceTrayEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}