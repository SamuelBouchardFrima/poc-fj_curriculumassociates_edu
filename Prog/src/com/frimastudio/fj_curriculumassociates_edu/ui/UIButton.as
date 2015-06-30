package com.frimastudio.fj_curriculumassociates_edu.ui
{
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.BoxLabel;
	import com.frimastudio.fj_curriculumassociates_edu.ui.box.CurvedBox;
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Quad;
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.events.TimerEvent;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	public class UIButton extends CurvedBox
	{
		public function PositionAtChar(aCharIndex:int):Point
		{
			return new Point();
		}
		
		public function UIButton(aContent:String, aColor:int = 0xFFFFFF)
		{
			super(new Point(60, 60), aColor, new BoxLabel(aContent, 45, Palette.DIALOG_CONTENT), 12, null, Axis.HORIZONTAL);
		}
		
		public function Dispose():void
		{
		}
		
		public function CallAttention(aSpecialAnim:Boolean = false):void
		{
			if (aSpecialAnim)
			{
				// TODO:	replace glow with shining
				filters = [new GlowFilter(Palette.GREAT_BTN, 0, 16, 16, 2, BitmapFilterQuality.HIGH)];
				TweenLite.to(this, 0.5, { ease:Strong.easeOut, onComplete:OnTweenAttentionShowGlow, glowFilter:{ alpha:1 } });
			}
			else
			{
				TweenLite.to(this, 0.1, { ease:Quad.easeOut, onComplete:OnTweenAttentionJump, onCompleteParams:[0],
					y:-25, scaleX:0.9, scaleY:1.1 });
			}
		}
		
		private function OnTweenAttentionShowGlow():void
		{
			TweenLite.to(this, 0.5, { ease:Strong.easeIn, onComplete:OnTweenAttentionHideGlow, glowFilter:{ alpha:0 } });
		}
		
		private function OnTweenAttentionHideGlow():void 
		{
			filters = [];
		}
		
		private function OnTweenAttentionJump(aJumpAmount:int):void
		{
			TweenLite.to(this, 0.4, { ease:Bounce.easeOut, onComplete:OnTweenAttentionBounce, onCompleteParams:[aJumpAmount],
				y:0, scaleX:1, scaleY:1 });
		}
		
		private function OnTweenAttentionBounce(aJumpAmount:int):void
		{
			++aJumpAmount;
			if (aJumpAmount < 3)
			{
				TweenLite.to(this, 0.1, { ease:Quad.easeOut, onComplete:OnTweenAttentionJump, onCompleteParams:[aJumpAmount],
					y:-25, scaleX:0.9, scaleY:1.1 });
			}
		}
	}
}