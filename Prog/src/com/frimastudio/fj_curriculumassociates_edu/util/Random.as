package com.frimastudio.fj_curriculumassociates_edu.util
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	public class Random
	{
		public static function Range(aMin:Number, aMax:Number):Number
		{
			return aMin + Math.floor(Math.random() * (aMax - aMin + 1));
		}
		
		public static function RangeInt(aMin:int, aMax:int):int
		{
			return Range(aMin, aMax) as int;
		}
		
		public static function Bool():Boolean
		{
			return (RangeInt(0, 1) == 1);
		}
		
		public static function Sign():int
		{
			return (Bool() ? 1 : -1);
		}
		
		public static function FromList(aList:*):*
		{
			return aList[RangeInt(0, aList.length - 1)];
		}
		
		public static function FromString(aString:String):String
		{
			return aString.charAt(RangeInt(0, aString.length - 1));
		}
		
		public static function Position2D(aArea:Rectangle):Point
		{
			return new Point(Range(aArea.left, aArea.right), Range(aArea.top, aArea.bottom));
		}
		
		public function Random()
		{
			throw new Error("Random is a static class not intended for instantiation.");
		}
	}
}