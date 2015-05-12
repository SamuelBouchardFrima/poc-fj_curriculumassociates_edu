package com.frimastudio.fj_curriculumassociates_edu.ui.piecetray {
	import flash.events.Event;
	
	public class PieceTrayEvent extends Event
	{
		public static const PIECE_CAPTURED:String	= "com.frimastudio.fj_curriculumassociates_edu.piecetray.PieceTrayEvent::PIECE_CAPTURED";
		public static const PIECE_FREED:String		= "com.frimastudio.fj_curriculumassociates_edu.piecetray.PieceTrayEvent::PIECE_FREED";
		
		private var mPiece:Piece;
		private var mDragged:Boolean;
		
		public function get EventPiece():Piece	{	return mPiece;		}
		public function get Dragged():Boolean	{	return mDragged;	}
		
		public function PieceTrayEvent(aType:String, aPiece:Piece = null, aDragged:Boolean = true, aBubbles:Boolean = false, aCancelable:Boolean = false)
		{
			super(aType, aBubbles, aCancelable);
			
			mPiece = aPiece;
			mDragged = aDragged;
		}
		
		override public function clone():Event
		{
			return new PieceTrayEvent(type, mPiece, mDragged, bubbles, cancelable);
		}
		
		override public function toString():String
		{
			return formatToString("PieceTrayEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}