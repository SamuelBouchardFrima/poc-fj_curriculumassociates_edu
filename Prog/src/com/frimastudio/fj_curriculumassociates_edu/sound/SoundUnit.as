package com.frimastudio.fj_curriculumassociates_edu.sound
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class SoundUnit extends EventDispatcher
	{
		private var mSoundChannel:SoundChannel;
		private var mLength:Number;
		private var mTarget:*;
		private var mCallback:Function;
		
		public function get Length():Number	{ return mLength; }
		
		public function SoundUnit(aSound:Class, aTarget:* = null, aCallback:Function = null)
		{
			super();
			
			var sound:Sound = new aSound() as Sound;
			mSoundChannel = sound.play();
			mSoundChannel.addEventListener(Event.SOUND_COMPLETE, OnSoundComplete);
			mLength = sound.length;
			mTarget = aTarget;
			mCallback = aCallback;
		}
		
		public function Interrupt(aEnableCallback:Boolean = true):void
		{
			mSoundChannel.removeEventListener(Event.SOUND_COMPLETE, OnSoundComplete);
			mSoundChannel.stop();
			mSoundChannel = null;
			
			if (aEnableCallback)
			{
				if (mTarget && mCallback != null)
				{
					mCallback.call(mTarget);
				}
			}
			mTarget = null;
			mCallback = null;
			
			dispatchEvent(new SoundUnitEvent(SoundUnitEvent.COMPLETE));
		}
		
		private function OnSoundComplete(aEvent:Event):void
		{
			mSoundChannel.removeEventListener(Event.SOUND_COMPLETE, OnSoundComplete);
			mSoundChannel.stop();
			mSoundChannel = null;
			
			if (mTarget && mCallback != null)
			{
				mCallback.call(mTarget);
			}
			mTarget = null;
			mCallback = null;
			
			dispatchEvent(new SoundUnitEvent(SoundUnitEvent.COMPLETE));
		}
	}
}