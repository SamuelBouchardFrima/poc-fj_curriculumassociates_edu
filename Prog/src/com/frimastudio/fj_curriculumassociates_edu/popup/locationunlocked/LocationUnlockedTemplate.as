package com.frimastudio.fj_curriculumassociates_edu.popup.locationunlocked
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.navigation.ExplorableLevel;
	import com.frimastudio.fj_curriculumassociates_edu.popup.PopupTemplate;
	
	public class LocationUnlockedTemplate extends PopupTemplate
	{		
		private var mTitle:String;
		private var mVO:Class;
		private var mUnlockedLevel:ExplorableLevel;
		
		public function get Title():String	{ return mTitle; }
		public function get VO():Class	{ return mVO; }
		public function get UnlockedLevel():ExplorableLevel	{ return mUnlockedLevel; }
		
		public function LocationUnlockedTemplate(aLevel:Level, aTitle:String, aVO:Class,
			aUnlockedLevel:ExplorableLevel = null)
		{
			super(aLevel);
			
			mStepClass = LocationUnlocked;
			
			mTitle = aTitle;
			mVO = aVO;
			mUnlockedLevel = (aUnlockedLevel ? aUnlockedLevel : ExplorableLevel.NONE);
		}
	}
}