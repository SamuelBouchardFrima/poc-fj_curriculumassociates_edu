package com.frimastudio.fj_curriculumassociates_edu.quest
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.lucutaming.LucuTamingEnergy;
	import com.frimastudio.fj_curriculumassociates_edu.lucutaming.LucuTamingEnergyEvent;
	import com.frimastudio.fj_curriculumassociates_edu.navigation.NavigationManager;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	
	public class QuestStep extends Sprite
	{
		protected var mMap:CurvedBox;
		protected var mLevel:Level;
		//protected var mWildLucuChallengeBtn:CurvedBox;
		protected var mWildLucu:Sprite;
		
		public function get StepLevel():Level	{ return mLevel; }
		
		public function QuestStep(aTemplate:QuestStepTemplate)
		{
			super();
			
			if (aTemplate.StepLevel)
			{
				mLevel = aTemplate.StepLevel;
				addChild(mLevel);
				
				if (mLevel == Level.NONE)
				{
				}
				else if (mLevel == Level.THE_LAB)
				{
					LucuTamingEnergy.Instance.Charging = false;
				}
				else
				{
					LucuTamingEnergy.Instance.Charging = true;
				}
			}
		}
		
		public function Dispose():void
		{
			mLevel.Reset();
			
			if (mMap)
			{
				mMap.removeEventListener(MouseEvent.CLICK, OnClickMap);
			}
			if (mWildLucu)
			{
				mWildLucu.removeEventListener(MouseEvent.CLICK, OnClickWildLucu);
			}
		}
		
		public function Refresh():void
		{
			if (mLevel && mLevel != Level.NONE)
			{
				addChildAt(mLevel, 0);
				
				if (mLevel == Level.THE_LAB)
				{
					LucuTamingEnergy.Instance.Charging = false;
				}
				else
				{
					LucuTamingEnergy.Instance.Charging = true;
				}
			}
		}
		
		protected function InitializeMap(aEnabled:Boolean = true):void
		{
			aEnabled = (aEnabled && NavigationManager.UnlockedLevelList.length > 1);
			
			mMap = new CurvedBox(new Point(64, 64), (aEnabled ? 0xCCFF99 : 0xCCCCCC),
				new BoxLabel("M", 48, Palette.DIALOG_CONTENT), 6);
			mMap.x = 1024 - 10 - (mMap.width / 2);
			mMap.y = 768 - 10 - (mMap.height / 2);
			addChild(mMap);
			
			if (aEnabled)
			{
				mMap.addEventListener(MouseEvent.CLICK, OnClickMap);
			}
		}
		
		private function OnClickMap(aEvent:MouseEvent):void
		{
			dispatchEvent(new QuestStepEvent(QuestStepEvent.OPEN_MAP));
		}
		
		protected function InitializeWildLucu(aEnabled:Boolean = true):void
		{
			mWildLucu = new Sprite();
			var wildLucuBitmap:Bitmap = new Asset.WildLucuIdleBitmap() as Bitmap;
			wildLucuBitmap.smoothing = true;
			wildLucuBitmap.scaleY = 0.5;
			wildLucuBitmap.scaleX = -wildLucuBitmap.scaleY;
			wildLucuBitmap.x = wildLucuBitmap.width / 2;
			wildLucuBitmap.y = -wildLucuBitmap.height / 2;
			mWildLucu.addChild(wildLucuBitmap);
			mWildLucu.x = 1024 - 10 - (mWildLucu.width / 2);
			mWildLucu.y = mMap.y - (mMap.height / 2) - 10 - (mWildLucu.height / 2);
			//mWildLucu.addEventListener(MouseEvent.CLICK, OnClickWildLucu);
			addChild(mWildLucu);
			
			if (aEnabled)
			{
				if (mLevel != Level.THE_LAB && mLevel != Level.NONE)
				{
					if (LucuTamingEnergy.Instance.Charged)
					{
						mWildLucu.addEventListener(MouseEvent.CLICK, OnClickWildLucu);
						mWildLucu.filters = [new GlowFilter(Palette.GREAT_BTN, 0.5, 16, 16, 2, BitmapFilterQuality.HIGH)];
						LucuTamingEnergy.Instance.addEventListener(LucuTamingEnergyEvent.DISCHARGED, OnLucuTamingEnergyDischarged);
					}
					else
					{
						LucuTamingEnergy.Instance.addEventListener(LucuTamingEnergyEvent.CHARGED, OnLucuTamingEnergyCharged);
					}
				}
			}
		}
		
		protected function OnLucuTamingEnergyDischarged(aEvent:LucuTamingEnergyEvent):void
		{
			LucuTamingEnergy.Instance.removeEventListener(LucuTamingEnergyEvent.CHARGED, OnLucuTamingEnergyDischarged);
			mWildLucu.removeEventListener(MouseEvent.CLICK, OnClickWildLucu);
			mWildLucu.filters = [];
			TweenLite.killTweensOf(mWildLucu);
			LucuTamingEnergy.Instance.addEventListener(LucuTamingEnergyEvent.CHARGED, OnLucuTamingEnergyCharged);
		}
		
		protected function OnLucuTamingEnergyCharged(aEvent:LucuTamingEnergyEvent):void
		{
			LucuTamingEnergy.Instance.removeEventListener(LucuTamingEnergyEvent.CHARGED, OnLucuTamingEnergyCharged);
			mWildLucu.addEventListener(MouseEvent.CLICK, OnClickWildLucu);
			mWildLucu.filters = [new GlowFilter(Palette.GREAT_BTN, 0, 16, 16, 2, BitmapFilterQuality.HIGH)];
			TweenLite.to(mWildLucu, 2, { ease:Strong.easeOut, glowFilter:{ alpha:0.5 } });
			LucuTamingEnergy.Instance.addEventListener(LucuTamingEnergyEvent.DISCHARGED, OnLucuTamingEnergyDischarged);
		}
		
		//protected function OnClickWildLucuChallengeBtn(aEvent:MouseEvent):void
		//{
			//dispatchEvent(new QuestStepEvent(QuestStepEvent.LAUNCH_LUCU_TAMING));
		//}
		protected function OnClickWildLucu(aEvent:MouseEvent):void
		{
			if (mLevel != Level.THE_LAB && mLevel != Level.NONE)
			{
				dispatchEvent(new QuestStepEvent(QuestStepEvent.LAUNCH_LUCU_TAMING));
			}
		}
	}
}