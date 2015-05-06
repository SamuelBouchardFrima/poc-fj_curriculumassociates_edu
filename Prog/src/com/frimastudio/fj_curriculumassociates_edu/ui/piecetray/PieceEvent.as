package com.frimastudio.fj_curriculumassociates_edu.ui.piecetray {
	import flash.events.Event;
	
	public class PieceEvent extends Event
	{
		public static const REMOVE:String	= "com.frimastudio.fj_curriculumassociates_edu.piecetray.PieceEvent::REMOVE";
		
		public function PieceEvent(aType:String, aBubbles:Boolean = false, aCancelable:Boolean = false)
		{
			super(aType, aBubbles, aCancelable);
		}
		
		override public function clone():Event
		{
			return new PieceEvent(type, bubbles, cancelable);
		}
		
		override public function toString():String
		{
			return formatToString("PieceEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}