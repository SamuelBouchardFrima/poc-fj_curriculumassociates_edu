package com.frimastudio.fj_curriculumassociates_edu.popup.itemunlocked
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.popup.PopupTemplate;
	
	public class ItemUnlockedTemplate extends PopupTemplate
	{		
		private var mTitle:String;
		private var mItemAsset:Class;
		private var mVO:Class;
		
		public function get Title():String	{ return mTitle; }
		public function get ItemAsset():Class	{ return mItemAsset; }
		public function get VO():Class	{ return mVO; }
		
		public function ItemUnlockedTemplate(aLevel:Level, aTitle:String, aItemAsset:Class, aVO:Class)
		{
			super(aLevel);
			
			mStepClass = ItemUnlocked;
			
			mTitle = aTitle;
			mItemAsset = aItemAsset;
			mVO = aVO;
		}
	}
}