package com.frimastudio.fj_curriculumassociates_edu.navigation
{
	import flash.display.Sprite;
	
	public class NavigationManagerConfig
	{
		private static var sContainer:Sprite;
		
		public static function get Container():Sprite	{ return sContainer; }
		public static function set Container(aValue:Sprite):void	{ sContainer = aValue; }
		
		public function NavigationManagerConfig()
		{
			throw new Error("NavigationManagerConfig is static and not intended for instantiation.");
		}
	}
}