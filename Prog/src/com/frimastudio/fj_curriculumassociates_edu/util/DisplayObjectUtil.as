package com.frimastudio.fj_curriculumassociates_edu.util
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	public class DisplayObjectUtil
	{
		public static function GetPosition(aObject:DisplayObject):Point
		{
			return new Point(aObject.x, aObject.y);
		}
		
		public static function SetPosition(aObject:DisplayObject, aPosition:Point):void
		{
			aObject.x = aPosition.x;
			aObject.y = aPosition.y;
		}
		
		public function DisplayObjectUtil()
		{
			throw new Error("DisplayObjectUtil is static and not intended for instatiation.");
		}
	}
}