package com.frimastudio.fj_curriculumassociates_edu.ui.box
{
	public class BoxIcon extends BoxContent
	{
		private var mIconAsset:Class;
		
		public function get IconAsset():Class	{ return mIconAsset; }
		public function set IconAsset(aValue:Class):void	{ mIconAsset = aValue; }
		
		public function BoxIcon(aIconAsset:Class, aColor:int = NaN)
		{
			super(aColor);
			
			mIconAsset = aIconAsset;
		}
	}
}