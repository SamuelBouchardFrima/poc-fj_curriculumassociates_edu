package com.frimastudio.fj_curriculumassociates_edu.popup.reward
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.popup.PopupTemplate;
	
	public class RewardTemplate extends PopupTemplate
	{		
		private var mTitle:String;
		private var mTitleVO:Class;
		private var mType:RewardType;
		private var mRewardList:Vector.<String>;
		
		public function get Title():String	{ return mTitle; }
		public function get TitleVO():Class	{ return mTitleVO; }
		public function get Type():RewardType	{ return mType; }
		public function get RewardList():Vector.<String>	{ return mRewardList; }
		
		public function RewardTemplate(aLevel:Level, aTitle:String, aTitleVO:Class, aType:RewardType, aRewardList:Vector.<String>)
		{
			super(aLevel);
			
			mStepClass = Reward;
			
			mTitle = aTitle;
			mTitleVO = aTitleVO;
			mType = aType;
			mRewardList = aRewardList;
		}
	}
}