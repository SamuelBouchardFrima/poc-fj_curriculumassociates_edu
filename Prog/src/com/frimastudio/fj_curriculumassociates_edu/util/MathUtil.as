package com.frimastudio.fj_curriculumassociates_edu.util
{
	import flash.geom.Point;
	
	public class MathUtil
	{
		public static function MinMax(aValue:Number, aMin:Number, aMax:Number):Number
		{
			return Math.min(Math.max(aValue, aMin), aMax);
		}
		
		public static function MinMaxInt(aValue:int, aMin:int, aMax:int):int
		{
			return MinMax(aValue, aMin, aMax) as int;
		}
		
		public static function MaxPoint(aValue1:Point, aValue2:Point):Point
		{
			return new Point(Math.max(aValue1.x, aValue2.x), Math.max(aValue1.y, aValue2.y));
		}
		
		public static function MinPoint(aValue1:Point, aValue2:Point):Point
		{
			return new Point(Math.min(aValue1.x, aValue2.x), Math.min(aValue1.y, aValue2.y));
		}
		
		public function MathUtil()
		{
			throw new Error("MathUtil is a static class not intended for instantiation.");
		}
	}
}