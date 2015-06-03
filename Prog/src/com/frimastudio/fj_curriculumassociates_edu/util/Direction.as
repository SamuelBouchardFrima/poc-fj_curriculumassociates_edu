package com.frimastudio.fj_curriculumassociates_edu.util
{
	import flash.geom.Point;
	
	public class Direction
	{
		private static var sI:int = 0;
		
		public static const NONE:Direction = new Direction(sI++, "NONE", new Point(0, 0));
		public static const UP:Direction = new Direction(sI++, "UP", new Point(0, -1));
		public static const RIGHT:Direction = new Direction(sI++, "RIGHT", new Point(1, 0));
		public static const DOWN:Direction = new Direction(sI++, "DOWN", new Point(0, 1));
		public static const LEFT:Direction = new Direction(sI++, "LEFT", new Point(-1, 0));
		public static const DOWN_LEFT:Direction = new Direction(sI++, "DOWN_LEFT", new Point(-1, 1));
		
		private var mID:int;
		private var mDescription:String;
		private var mDirectionFactor:Point;
		
		public function get ID():int
		{
			return mID;
		}
		
		public function get Description():String
		{
			return mDescription;
		}
		
		public function get DirectionFactor():Point
		{
			return mDirectionFactor;
		}
		
		public function Direction(aID:int, aDescription:String, aDirectionFactor:Point)
		{
			mID = aID;
			mDescription = aDescription;
			mDirectionFactor = aDirectionFactor;
		}
	}
}