package com.frimastudio.fj_curriculumassociates_edu.sound
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class SoundManager
	{
		private static const MAX_SFX:int = 10;
		
		private static var sVOSoundUnit:SoundUnit;
		private static var sSFXSoundUnitList:Vector.<SoundUnit> = new Vector.<SoundUnit>();
		
		public static function PlayVO(aVO:Class, aTarget:* = null, aCallback:Function = null, aInterrupt:Boolean = true):Number
		{
			if (!aVO)
			{
				return 0;
			}
			
			if (sVOSoundUnit)
			{
				if (aInterrupt)
				{
					sVOSoundUnit.Interrupt();
				}
				else
				{
					return 0;
				}
			}
			
			sVOSoundUnit = new SoundUnit(aVO, aTarget, aCallback);
			sVOSoundUnit.addEventListener(SoundUnitEvent.COMPLETE, OnCompleteVOSoundUnit);
			
			return sVOSoundUnit.Length;
		}
		
		private static function OnCompleteVOSoundUnit(aEvent:SoundUnitEvent):void
		{
			sVOSoundUnit.removeEventListener(SoundUnitEvent.COMPLETE, OnCompleteVOSoundUnit);
			sVOSoundUnit = null;
		}
		
		public static function PlaySFX(aSFX:Class, aTarget:* = null, aCallback:Function = null):Number
		{
			if (!aSFX)
			{
				return 0;
			}
			
			if (sSFXSoundUnitList.length >= MAX_SFX)
			{
				sSFXSoundUnitList[0].Interrupt();
			}
			
			var soundUnit:SoundUnit = new SoundUnit(aSFX, aTarget, aCallback);
			soundUnit.addEventListener(SoundUnitEvent.COMPLETE, OnCompleteSFXSoundUnit);
			sSFXSoundUnitList.push(soundUnit);
			
			return soundUnit.Length;
		}
		
		private static function OnCompleteSFXSoundUnit(aEvent:SoundUnitEvent):void
		{
			var soundUnit:SoundUnit = aEvent.currentTarget as SoundUnit;
			soundUnit.removeEventListener(SoundUnitEvent.COMPLETE, OnCompleteSFXSoundUnit);
			sSFXSoundUnitList.splice(sSFXSoundUnitList.indexOf(soundUnit), 1);
		}
		
		public function SoundManager()
		{
			throw new Error("SoundManager is static and not intended for instantiation.");
		}
	}
}