package com.frimastudio.fj_curriculumassociates_edu.util
{
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
		
		public function MathUtil()
		{
			throw new Error("MathUtil is a static class not intended for instantiation.");
		}
	}
}