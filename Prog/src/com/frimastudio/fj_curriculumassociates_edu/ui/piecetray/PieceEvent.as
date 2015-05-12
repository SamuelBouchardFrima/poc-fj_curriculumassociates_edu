package com.frimastudio.fj_curriculumassociates_edu.ui.piecetray {
	import flash.events.Event;
	
	public class PieceEvent extends Event
	{
		public static const REMOVE:String	= "com.frimastudio.fj_curriculumassociates_edu.piecetray.PieceEvent::REMOVE";
		
		private var mDragged:Boolean;
		
		public function get Dragged():Boolean	{	return mDragged;	}
		
		public function PieceEvent(aType:String, aDragged:Boolean = true, aBubbles:Boolean = false, aCancelable:Boolean = false)
		{
			super(aType, aBubbles, aCancelable);
			
			mDragged = aDragged;
		}
		
		override public function clone():Event
		{
			return new PieceEvent(type, mDragged, bubbles, cancelable);
		}
		
		override public function toString():String
		{
			return formatToString("PieceEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}