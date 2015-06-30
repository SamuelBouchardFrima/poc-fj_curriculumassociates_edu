package com.frimastudio.fj_curriculumassociates_edu.popup.locationunlocked
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.popup.PopupTemplate;
	
	public class LocationUnlockedTemplate extends PopupTemplate
	{		
		private var mTitle:String;
		private var mVO:Class;
		
		public function get Title():String	{ return mTitle; }
		public function get VO():Class	{ return mVO; }
		
		public function LocationUnlockedTemplate(aLevel:Level, aTitle:String, aVO:Class)
		{
			super(aLevel);
			
			mStepClass = LocationUnlocked;
			
			mTitle = aTitle;
			mVO = aVO;
		}
	}
}