package com.frimastudio.fj_curriculumassociates_edu.ui.box
{
	import com.frimastudio.fj_curriculumassociates_edu.util.Axis;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class CurvedBox extends Box
	{
		private var mCurve:Number;
		
		public function get Curve():Number	{ return mCurve; }
		public function set Curve(aValue:Number):void
		{
			mCurve = aValue;
		}
		
		override public function get Size():Point	{ return new Point(mSize.width, mSize.height); }
		override public function set Size(aValue:Point):void
		{
			super.Size = aValue;
			
			mSize.width = Math.max(mSize.width, mCurve * 2);
			mSize.height = Math.max(mSize.height, mCurve * 2);
			mSize.x = -mSize.width / 2;
			mSize.y = -mSize.height / 2;
			
			DrawBox();
			DrawPoint();
		}
		
		public function CurvedBox(aSize:Point, aColor:int = -1, aContent:BoxContent = null, aMargin:Number = 0,
			aPointDirection:Direction = null, aAutoSizeAxis:Axis = null, aCurve:Number = 22)
		{
			mCurve = aCurve;
			
			var size:Point = aSize.clone();
			size.x = Math.max(size.x, mCurve * 2);
			size.y = Math.max(size.y, mCurve * 2);
			
			super(size, aColor, aContent, aMargin, aPointDirection, aAutoSizeAxis);
		}
		
		override protected function DrawBox():void
		{
			mGraphic.graphics.clear();
			
			if (mColorBorderOnly)
			{
				mGraphic.graphics.lineStyle(5, mColor);
				mGraphic.graphics.beginFill(0xFFFFFF);
			}
			else
			{
				mGraphic.graphics.lineStyle();
				mGraphic.graphics.beginFill(mColor);
			}
			mGraphic.graphics.moveTo(mSize.left + mCurve, mSize.top);
			mGraphic.graphics.lineTo(mSize.right - mCurve, mSize.top);
			mGraphic.graphics.curveTo(mSize.right, mSize.top, mSize.right, mSize.top + mCurve);
			mGraphic.graphics.lineTo(mSize.right, mSize.bottom - mCurve);
			mGraphic.graphics.curveTo(mSize.right, mSize.bottom, mSize.right - mCurve, mSize.bottom);
			mGraphic.graphics.lineTo(mSize.left + mCurve, mSize.bottom);
			mGraphic.graphics.curveTo(mSize.left, mSize.bottom, mSize.left, mSize.bottom - mCurve);
			mGraphic.graphics.lineTo(mSize.left, mSize.top + mCurve);
			mGraphic.graphics.curveTo(mSize.left, mSize.top, mSize.left + mCurve, mSize.top);
			mGraphic.graphics.endFill();
		}
	}
}