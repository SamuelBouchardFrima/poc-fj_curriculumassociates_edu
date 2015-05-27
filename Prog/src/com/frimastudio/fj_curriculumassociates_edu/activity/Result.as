package com.frimastudio.fj_curriculumassociates_edu.activity
{
	import com.frimastudio.fj_curriculumassociates_edu.ui.Palette;
	
	public class Result
	{
		private static var sI:int = 0;
		
		public static var GREAT:Result = new Result(sI++, "GREAT", Palette.GREAT_BTN);
		public static var VALID:Result = new Result(sI++, "VALID", Palette.VALID_BTN);
		public static var WRONG:Result = new Result(sI++, "WRONG", Palette.WRONG_BTN);
		
		private var mID:int;
		private var mDescription:String;
		private var mColor:int;
		
		public function get ID():int
		{
			return mID;
		}
		
		public function get Description():String
		{
			return mDescription;
		}
		
		public function get Color():int
		{
			return mColor;
		}
		
		public function Result(aID:int, aDescription:String, aColor:int)
		{
			mID = aID;
			mDescription = aDescription;
			mColor = aColor;
		}
	}
}