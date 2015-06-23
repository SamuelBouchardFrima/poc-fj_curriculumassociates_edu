package com.frimastudio.fj_curriculumassociates_edu.popup.navigation
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.popup.PopupTemplate;
	
	public class NavigationTemplate extends PopupTemplate
	{		
		private var mTitle:String;
		private var mLocationList:Vector.<String>;
		private var mLocationUnlockList:Vector.<Boolean>;
		
		public function get Title():String	{ return mTitle; }
		public function get LocationList():Vector.<String>	{ return mLocationList; }
		public function get LocationUnlockList():Vector.<Boolean>	{ return mLocationUnlockList; }
		
		public function NavigationTemplate(aLevel:Level, aTitle:String, aLocationList:Vector.<String>,
			aLocationUnlockList:Vector.<Boolean>)
		{
			super(aLevel);
			
			mStepClass = Navigation;
			
			mTitle = aTitle;
			mLocationList = aLocationList;
			mLocationUnlockList = aLocationUnlockList;
		}
	}
}