package com.frimastudio.fj_curriculumassociates_edu.lucutaming
{
	import flash.display.Sprite;
	
	public class LucuTamingConfig
	{
		private static var sContainer:Sprite;
		
		public static function get Container():Sprite	{ return sContainer; }
		public static function set Container(aValue:Sprite):void	{ sContainer = aValue; }
		
		public function LucuTamingConfig()
		{
			throw new Error("LucuTamingConfig is static and not intended for instantiation.");
		}
	}
}