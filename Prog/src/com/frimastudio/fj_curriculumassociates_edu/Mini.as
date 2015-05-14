package com.frimastudio.fj_curriculumassociates_edu
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Mini extends Sprite
	{
		private var mAsset:Sprite;
		private var mColor:int;
		private var mTimer:Timer;
		private var mSelected:Boolean;
		
		public function Mini(aColor:int)
		{
			super();
			
			mColor = aColor;
			
			mAsset = new Sprite();
			addChild(mAsset);
			
			mAsset.graphics.lineStyle(2);
			mAsset.graphics.beginFill(mColor);
			mAsset.graphics.drawEllipse(-100, -75, 200, 150);
			mAsset.graphics.endFill();
			mAsset.graphics.beginFill(0x000000);
			mAsset.graphics.drawCircle(-30, -25, 20);
			mAsset.graphics.drawCircle(30, -25, 20);
			mAsset.graphics.endFill();
			mAsset.graphics.moveTo(-60, 0);
			mAsset.graphics.curveTo(-50, 30, 0, 30);
			mAsset.graphics.curveTo(50, 30, 60, 0);
			
			mTimer = new Timer(1500, 1);
			mTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
		}
		
		public function Select():void
		{
			mTimer.reset();
			
			mAsset.graphics.clear();
			mAsset.graphics.lineStyle(2);
			mAsset.graphics.beginFill(mColor);
			mAsset.graphics.drawEllipse(-100, -75, 200, 150);
			mAsset.graphics.endFill();
			mAsset.graphics.beginFill(0x000000);
			mAsset.graphics.drawCircle(-30, -25, 20);
			mAsset.graphics.drawCircle(30, -25, 20);
			mAsset.graphics.drawRect(-50, 5, 100, 5);
			mAsset.graphics.moveTo(50, 10);
			mAsset.graphics.curveTo(50, 40, 0, 40);
			mAsset.graphics.curveTo(-50, 40, -50, 10);
			mAsset.graphics.endFill();
			
			mSelected = true;
		}
		
		public function Unselect():void
		{
			mTimer.reset();
			
			mAsset.graphics.lineStyle(2);
			mAsset.graphics.beginFill(mColor);
			mAsset.graphics.drawEllipse(-100, -75, 200, 150);
			mAsset.graphics.endFill();
			mAsset.graphics.beginFill(0x000000);
			mAsset.graphics.drawCircle(-30, -25, 20);
			mAsset.graphics.drawCircle(30, -25, 20);
			mAsset.graphics.endFill();
			mAsset.graphics.moveTo(-60, 0);
			mAsset.graphics.curveTo(-50, 30, 0, 30);
			mAsset.graphics.curveTo(50, 30, 60, 0);
			
			mSelected = false;
		}
		
		public function EatWord(aWord:String):void
		{
			mAsset.graphics.clear();
			mAsset.graphics.lineStyle(2);
			mAsset.graphics.beginFill(mColor);
			mAsset.graphics.drawEllipse(-100, -75, 200, 150);
			mAsset.graphics.endFill();
			mAsset.graphics.moveTo(-50, -25);
			mAsset.graphics.lineTo(-10, -25);
			mAsset.graphics.moveTo(10, -25);
			mAsset.graphics.lineTo(50, -25);
			mAsset.graphics.beginFill(0x000000);
			mAsset.graphics.drawEllipse(-50, -10, 100, 50);
			mAsset.graphics.endFill();
			
			mTimer.reset();
			mTimer.start();
		}
		
		private function OnTimerComplete(aEvent:TimerEvent):void
		{
			(mSelected ? Select() : Unselect());
		}
	}
}