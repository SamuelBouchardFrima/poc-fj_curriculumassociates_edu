package com.frimastudio.fj_curriculumassociates_edu.navigation
{
	public class NavigationManager
	{
		private static var sUnlockedLevelList:Vector.<ExplorableLevel> = new <ExplorableLevel>[ExplorableLevel.THE_LAB];
		
		public static function get UnlockedLevelList():Vector.<ExplorableLevel>	{ return sUnlockedLevelList; }
		
		public static function Navigate(aLevel:ExplorableLevel):void
		{
			while (NavigationManagerConfig.Container.numChildren)
			{
				NavigationManagerConfig.Container.removeChildAt(0);
			}
			
			NavigationManagerConfig.Container.addChild(aLevel);
			aLevel.Refresh();
		}
		
		public static function Unlock(aLevel:ExplorableLevel):void
		{
			if (aLevel == ExplorableLevel.NONE)
			{
				return;
			}
			
			if (sUnlockedLevelList.indexOf(aLevel) == -1)
			{
				sUnlockedLevelList.push(aLevel);
			}
		}
		
		public static function Reset():void
		{
			sUnlockedLevelList = new <ExplorableLevel>[ExplorableLevel.THE_LAB];
		}
		
		public function NavigationManager()
		{
			throw new Error("NavigationManager is static and not intended for instantiation.");
		}
	}
}