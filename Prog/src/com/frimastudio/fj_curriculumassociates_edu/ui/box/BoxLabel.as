package com.frimastudio.fj_curriculumassociates_edu.ui.box
{
	public class BoxLabel extends BoxContent
	{
		private var mLabel:String;
		private var mSize:Number;
		private var mDropShadow:Boolean;
		
		public function get Label():String	{ return mLabel; }
		public function set Label(aValue:String):void	{ mLabel = aValue; }
		
		public function get Size():Number	{ return mSize; }
		public function set Size(aValue:Number):void { mSize = aValue; }
		
		public function get DropShadow():Boolean	{ return mDropShadow; }
		public function set DropShadow(aValue:Boolean):void { mDropShadow = aValue; }
		
		public function BoxLabel(aLabel:String = "", aSize:Number = NaN, aColor:int = NaN, aDropShadow:Boolean = false)
		{
			super(aColor);
			
			mLabel = aLabel;
			mSize = aSize;
			mDropShadow = aDropShadow;
		}
	}
}