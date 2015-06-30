package com.frimastudio.fj_curriculumassociates_edu.popup.reward
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.popup.PopupTemplate;
	
	public class RewardTemplate extends PopupTemplate
	{		
		private var mTitle:String;
		private var mBody:String;
		private var mRewardList:Vector.<String>;
		private var mVO:Class;
		
		public function get Title():String	{ return mTitle; }
		public function get Body():String	{ return mBody; }
		public function get RewardList():Vector.<String>	{ return mRewardList; }
		public function get VO():Class	{ return mVO; }
		
		public function RewardTemplate(aLevel:Level, aTitle:String, aBody:String, aRewardList:Vector.<String>, aVO:Class)
		{
			super(aLevel);
			
			mStepClass = Reward;
			
			mTitle = aTitle;
			mBody = aBody;
			mRewardList = aRewardList;
			mVO = aVO;
		}
	}
}