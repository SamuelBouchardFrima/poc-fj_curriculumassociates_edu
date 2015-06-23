package com.frimastudio.fj_curriculumassociates_edu.util
{
	import flash.geom.Point;
	
	public class Axis
	{
		private static var sI:int = 0;
		
		public static const NONE:Axis = new Axis(sI++, "NONE", new Point(0, 0));
		public static const HORIZONTAL:Axis = new Axis(sI++, "HORIZONTAL", new Point(1, 0));
		public static const VERTICAL:Axis = new Axis(sI++, "VERTICAL", new Point(0, 1));
		public static const BOTH:Axis = new Axis(sI++, "BOTH", new Point(1, 1));
		
		private var mID:int;
		private var mDescription:String;
		private var mAxisFactor:Point;
		
		public function get ID():int
		{
			return mID;
		}
		
		public function get Description():String
		{
			return mDescription;
		}
		
		public function get AxisFactor():Point
		{
			return mAxisFactor;
		}
		
		public function Axis(aID:int, aDescription:String, aAxisFactor:Point)
		{
			mID = aID;
			mDescription = aDescription;
			mAxisFactor = aAxisFactor;
		}
	}
}