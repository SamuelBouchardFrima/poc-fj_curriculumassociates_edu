package com.frimastudio.fj_curriculumassociates_edu.ui
{
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class UIButton extends CurvedBox
	{
		protected var mCallAttentionTimer:Timer;
		
		public function PositionAtChar(aCharIndex:int):Point
		{
			return new Point();
		}
		
		public function UIButton(aContent:String, aColor:int = 0xFFFFFF)
		{
			super(new Point(70, 70), aColor, new BoxLabel(aContent, 60,
				(aColor == Palette.DIALOG_BOX ? Palette.DIALOG_CONTENT : Palette.BTN_CONTENT)),
				12, null, Axis.HORIZONTAL);
			
			mCallAttentionTimer = new Timer(100, 10);
			mCallAttentionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnCallAttentionTimerComplete);
		}
		
		public function Dispose():void
		{
			mCallAttentionTimer.reset();
			mCallAttentionTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnCallAttentionTimerComplete);
		}
		
		public function CallAttention(aSpecialAnim:Boolean = false):void
		{
			mCallAttentionTimer.reset();
			mCallAttentionTimer.start();
		}
		
		private function OnCallAttentionTimerComplete(aEvent:TimerEvent):void
		{
			mCallAttentionTimer.reset();
		}
	}
}