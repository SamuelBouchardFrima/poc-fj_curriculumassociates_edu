package com.frimastudio.fj_curriculumassociates_edu.lucutaming
{
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class LucuTamingEnergy extends EventDispatcher
	{
		private static const sInstance:LucuTamingEnergy = new LucuTamingEnergy();
		
		public static function get Instance():LucuTamingEnergy	{ return sInstance; }
		
		private var mEnergyRechargeTimer:Timer;
		private var mCharging:Boolean;
		private var mCharged:Boolean;
		
		public function get Charged():Boolean	{ return mCharged; }
		
		public function get Charging():Boolean	{ return mCharging; }
		public function set Charging(aValue:Boolean):void
		{
			if (!mCharged)
			{
				mCharging = aValue;
				if (mCharging)
				{
					mEnergyRechargeTimer.start();
				}
				else
				{
					mEnergyRechargeTimer.stop();
				}
			}
		}
		
		public function LucuTamingEnergy()
		{
			if (sInstance)
			{
				throw new Error("LucuTamingEnergy is a singleton not intended for instantiation. Use LucuTamingEnergy.Instance instead.");
				return;
			}
			
			mEnergyRechargeTimer = new Timer(15000, 1);
			mEnergyRechargeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnEnergyRechargeTimerComplete);
			mEnergyRechargeTimer.start();
			
			mCharging = true;
			mCharged = false;
		}
		
		public function Discharge():void
		{
			if (mCharged)
			{
				mCharged = false;
				
				dispatchEvent(new LucuTamingEnergyEvent(LucuTamingEnergyEvent.DISCHARGED));
			}
		}
		
		private function OnEnergyRechargeTimerComplete(aEvent:TimerEvent):void
		{
			mCharging = false;
			mCharged = true;
			
			dispatchEvent(new LucuTamingEnergyEvent(LucuTamingEnergyEvent.CHARGED));
		}
	}
}