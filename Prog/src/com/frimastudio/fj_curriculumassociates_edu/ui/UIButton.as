package com.frimastudio.fj_curriculumassociates_edu.ui
{
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	//import com.frimastudio.fj_curriculumassociates_edu.util.DisplayObjectUtil;
	//import com.greensock.easing.Strong;
	//import com.greensock.TweenLite;
	//import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	//import flash.geom.Rectangle;
	//import flash.text.TextField;
	//import flash.text.TextFieldAutoSize;
	//import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class UIButton extends CurvedBox
	{
		//protected static const FORMAT:TextFormat = new TextFormat("SweaterSchoolRg-Regular", 36, null, null, null, null, null, null, "center");
		//protected static const MARGIN:Number = 10;
		
		//protected var mContent:String;
		//protected var mColor:int;
		//protected var mAsset:Sprite;
		//protected var mLabel:TextField;
		protected var mCallAttentionTimer:Timer;
		
		//public function get Content():String	{	return mContent;	}
		//public function set Content(aValue:String):void
		//{
			//mContent = aValue;
			//
			//mLabel.text = mContent;
			//mLabel.setTextFormat(FORMAT);
			//mLabel.x = -(mLabel.textWidth / 2);
			//mLabel.y = -(mLabel.height / 2);
		//}
		
		//public function set Color(aValue:int):void
		//{
			//mColor = aValue;
			//
			//mAsset.graphics.clear();
			//mAsset.graphics.lineStyle(2);
			//mAsset.graphics.beginFill(mColor);
			//mAsset.graphics.moveTo(mLabel.x - MARGIN, mLabel.y);
			//mAsset.graphics.lineTo(mLabel.x + mLabel.textWidth + MARGIN, mLabel.y);
			//mAsset.graphics.lineTo(mLabel.x + mLabel.textWidth + MARGIN, mLabel.y + mLabel.height);
			//mAsset.graphics.lineTo(mLabel.x - MARGIN, mLabel.y + mLabel.height);
			//mAsset.graphics.lineTo(mLabel.x - MARGIN, mLabel.y);
			//mAsset.graphics.endFill();
		//}
		
		public function PositionAtChar(aCharIndex:int):Point
		{
			return new Point();
			//var boundary:Rectangle = mLabel.getCharBoundaries(aCharIndex);
			//var charPosition:Point = new Point(((boundary.right - boundary.left) / 2) + boundary.left,
				//((boundary.bottom - boundary.top) / 2) + boundary.top);
			//return charPosition.add(DisplayObjectUtil.GetPosition(mLabel));
		}
		
		public function UIButton(aContent:String, aColor:int = 0xFFFFFF)
		{
			super(new Point(70, 70), Palette.GENERIC_BTN, new BoxLabel(aContent, 60, Palette.BTN_CONTENT),
				12, null, Axis.HORIZONTAL);
			
			//mContent = aContent;
			//mColor = aColor;
			
			//mAsset = new Sprite();
			//addChild(mAsset);
			
			//mLabel = new TextField();
			//mLabel.autoSize = TextFieldAutoSize.CENTER;
			//mLabel.selectable = false;
			//mLabel.text = mContent;
			//mLabel.setTextFormat(FORMAT);
			//mLabel.height = 50;
			//mLabel.x = -(mLabel.textWidth / 2);
			//mLabel.y = -(mLabel.height / 2);
			//addChild(mLabel);
			
			//mAsset.graphics.lineStyle(2);
			//mAsset.graphics.beginFill(mColor);
			//mAsset.graphics.moveTo(mLabel.x - MARGIN, mLabel.y);
			//mAsset.graphics.lineTo(mLabel.x + mLabel.textWidth + MARGIN, mLabel.y);
			//mAsset.graphics.lineTo(mLabel.x + mLabel.textWidth + MARGIN, mLabel.y + mLabel.height);
			//mAsset.graphics.lineTo(mLabel.x - MARGIN, mLabel.y + mLabel.height);
			//mAsset.graphics.lineTo(mLabel.x - MARGIN, mLabel.y);
			//mAsset.graphics.endFill();
			
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
			
			//if (aSpecialAnim)
			//{
				//TweenLite.to(mAsset, 0.1, { ease:Strong.easeOut, overwrite:true, onComplete:OnTweenScaleUp,
					//scaleX:1.05, scaleY:1.05 });
			//}
			//else
			//{
				//TweenLite.to(mAsset, 0.05, { ease:Strong.easeOut, overwrite:true, onComplete:OnTweenVibrateUp, y: -2 });
			//}
		}
		
		//private function OnTweenScaleUp():void
		//{
			//TweenLite.to(mAsset, 0.1, { ease:Strong.easeOut, overwrite:true, onComplete:OnTweenScaleDown,
					//scaleX:0.95, scaleY:0.95 });
		//}
		
		//private function OnTweenScaleDown():void
		//{
			//TweenLite.to(mAsset, 0.1, { ease:Strong.easeOut, overwrite:true, onComplete:OnTweenScaleUp,
					//scaleX:1.05, scaleY:1.05 });
		//}
		
		//private function OnTweenVibrateUp():void
		//{
			//TweenLite.to(mAsset, 0.05, { ease:Strong.easeOut, overwrite:true, onComplete:OnTweenVibrateDown, y:2 });
		//}
		
		//private function OnTweenVibrateDown():void
		//{
			//TweenLite.to(mAsset, 0.05, { ease:Strong.easeOut, overwrite:true, onComplete:OnTweenVibrateUp, y:-2 });
		//}
		
		private function OnCallAttentionTimerComplete(aEvent:TimerEvent):void
		{
			//TweenLite.to(mAsset, 0.05, { ease:Strong.easeOut, overwrite:true, scaleX:1, scaleY:1, y:0 } );
			
			mCallAttentionTimer.reset();
		}
	}
}