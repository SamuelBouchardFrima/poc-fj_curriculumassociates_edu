package com.frimastudio.fj_curriculumassociates_edu.ui.box
{
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	public class BoxContent
	{
		private var mColor:int;
		
		public function get ContentColor():int	{ return mColor; }
		public function set ContentColor(aValue:int):void	{ mColor = aValue; }
		
		public function BoxContent(aColor:int = -1)
		{
			mColor = (aColor == -1 ? Palette.NONE : aColor);
		}
	}
}