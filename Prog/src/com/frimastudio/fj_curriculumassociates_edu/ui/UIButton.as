package com.frimastudio.fj_curriculumassociates_edu.ui
{
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class UIButton extends Sprite
	{
		protected static const FORMAT:TextFormat = new TextFormat(null, 36, null, null, null, null, null, null, "center");
		protected static const MARGIN:Number = 10;
		
		protected var mContent:String;
		protected var mAsset:Sprite;
		protected var mLabel:TextField;
		protected var mCallAttentionTimer:Timer;
		
		public function get Content():String	{	return mContent;	}
		public function set Content(aValue:String):void
		{
			mContent = aValue;
			
			mLabel.text = mContent;
			mLabel.setTextFormat(FORMAT);
			mLabel.x = -(mLabel.textWidth / 2);
			mLabel.y = -(mLabel.height / 2);
		}
		
		public function set Color(aValue:int):void
		{
			mAsset.graphics.clear();
			mAsset.graphics.lineStyle(2);
			mAsset.graphics.beginFill(aValue);
			mAsset.graphics.moveTo(mLabel.x - MARGIN, mLabel.y);
			mAsset.graphics.lineTo(mLabel.x + mLabel.textWidth + MARGIN, mLabel.y);
			mAsset.graphics.lineTo(mLabel.x + mLabel.textWidth + MARGIN, mLabel.y + mLabel.height);
			mAsset.graphics.lineTo(mLabel.x - MARGIN, mLabel.y + mLabel.height);
			mAsset.graphics.lineTo(mLabel.x - MARGIN, mLabel.y);
			mAsset.graphics.endFill();
		}
		
		public function UIButton(aContent:String, aColor:int = 0xFFFFFF)
		{
			super();
			
			mContent = aContent;
			
			mAsset = new Sprite();
			addChild(mAsset);
			
			mLabel = new TextField();
			mLabel.autoSize = TextFieldAutoSize.CENTER;
			mLabel.selectable = false;
			mLabel.text = mContent;
			mLabel.setTextFormat(FORMAT);
			mLabel.height = 50;
			mLabel.x = -(mLabel.textWidth / 2);
			mLabel.y = -(mLabel.height / 2);
			addChild(mLabel);
			
			mAsset.graphics.lineStyle(2);
			mAsset.graphics.beginFill(aColor);
			mAsset.graphics.moveTo(mLabel.x - MARGIN, mLabel.y);
			mAsset.graphics.lineTo(mLabel.x + mLabel.textWidth + MARGIN, mLabel.y);
			mAsset.graphics.lineTo(mLabel.x + mLabel.textWidth + MARGIN, mLabel.y + mLabel.height);
			mAsset.graphics.lineTo(mLabel.x - MARGIN, mLabel.y + mLabel.height);
			mAsset.graphics.lineTo(mLabel.x - MARGIN, mLabel.y);
			mAsset.graphics.endFill();
			
			mCallAttentionTimer = new Timer(100, 10);
			mCallAttentionTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnCallAttentionTimerComplete);
		}
		
		public function Dispose():void
		{
			mCallAttentionTimer.reset();
			mCallAttentionTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnCallAttentionTimerComplete);
		}
		
		public function CallAttention():void
		{
			mCallAttentionTimer.reset();
			mCallAttentionTimer.start();
			
			TweenLite.to(mAsset, 0.05, { ease:Strong.easeOut, overwrite:true, onComplete:OnTweenVibrateUp, y:-2 });
		}
		
		private function OnTweenVibrateUp():void
		{
			TweenLite.to(mAsset, 0.05, { ease:Strong.easeOut, overwrite:true, onComplete:OnTweenVibrateDown, y:2 });
		}
		
		private function OnTweenVibrateDown():void
		{
			TweenLite.to(mAsset, 0.05, { ease:Strong.easeOut, overwrite:true, onComplete:OnTweenVibrateUp, y:-2 });
		}
		
		private function OnCallAttentionTimerComplete(aEvent:TimerEvent):void
		{
			TweenLite.to(mAsset, 0.05, { ease:Strong.easeOut, overwrite:true, y:0 } );
			
			mCallAttentionTimer.reset();
		}
	}
}