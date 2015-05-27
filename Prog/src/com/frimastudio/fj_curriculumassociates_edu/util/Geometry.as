package com.frimastudio.fj_curriculumassociates_edu.util
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Geometry
	{
		public static function RectangleCenter(aRectangle:Rectangle):Point
		{
			var halfSize:Point = aRectangle.size;
			halfSize.normalize(halfSize.length / 2);
			return aRectangle.topLeft.add(halfSize);
		}
		
		public static function RectangleAdd(aRectangle:Rectangle, aPoint:Point):Rectangle
		{
			aRectangle.x += aPoint.x;
			aRectangle.y += aPoint.y;
			return aRectangle;
		}
		
		public static function RectangleSubstract(aRectangle:Rectangle, aPoint:Point):Rectangle
		{
			aRectangle.x -= aPoint.x;
			aRectangle.y -= aPoint.y;
			return aRectangle;
		}
		
		public function Geometry()
		{
			throw new Error("Geometry is static and not intended for instantiation.");
		}
	}
}