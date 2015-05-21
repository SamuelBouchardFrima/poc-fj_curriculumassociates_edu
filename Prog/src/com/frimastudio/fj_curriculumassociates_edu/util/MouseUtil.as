package com.frimastudio.fj_curriculumassociates_edu.util
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	public class MouseUtil
	{
		public static function PositionRelativeTo(aObject:DisplayObject):Point
		{
			return new Point(aObject.mouseX, aObject.mouseY);
		}
		
		public function MouseUtil()
		{
			throw new Error("MouseUtil is static and not intended for instatiation.");
		}
	}
}