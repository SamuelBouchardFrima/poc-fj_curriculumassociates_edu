package com.frimastudio.fj_curriculumassociates_edu.ui
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class DecayingButton extends UIButton
	{
		private var mDecayTimer:Timer;
		
		public function DecayingButton(aContent:String, aDecayDelay:Number, aColor:int = 0xFFFFFF)
		{
			super(aContent, aColor);
			
			mDecayTimer = new Timer(aDecayDelay, 1);
			mDecayTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnDecayTimerComplete);
		}
		
		override public function Dispose():void
		{
			mDecayTimer.reset();
			mDecayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnDecayTimerComplete);
			
			super.Dispose();
		}
		
		public function StartDecay():void
		{
			mDecayTimer.reset();
			mDecayTimer.start();
		}
		
		public function StopDecay():void
		{
			mDecayTimer.reset();
		}
		
		private function OnDecayTimerComplete(aEvent:TimerEvent):void
		{
			mDecayTimer.reset();
			mDecayTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnDecayTimerComplete);
			
			dispatchEvent(new DecayingButtonEvent(DecayingButtonEvent.DECAY_COMPLETE));
		}
	}
}