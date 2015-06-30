package com.frimastudio.fj_curriculumassociates_edu.popup.message
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.popup.PopupTemplate;
	
	public class MessageTemplate extends PopupTemplate
	{		
		private var mTitle:String;
		private var mBody:String;
		private var mTitleVO:Class;
		private var mBodyVO:Class;
		
		public function get Title():String	{ return mTitle; }
		public function get Body():String	{ return mBody; }
		public function get TitleVO():Class	{ return mTitleVO; }
		public function get BodyVO():Class	{ return mBodyVO; }
		
		public function MessageTemplate(aLevel:Level, aTitle:String, aBody:String, aTitleVO:Class, aBodyVO:Class)
		{
			super(aLevel);
			
			mStepClass = Message;
			
			mTitle = aTitle;
			mBody = aBody;
			mTitleVO = aTitleVO;
			mBodyVO = aBodyVO;
		}
	}
}