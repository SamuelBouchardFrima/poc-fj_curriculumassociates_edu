package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class SelectActivityTemplate extends QuestStepTemplate
	{
		private var mActivityWordList:Vector.<WordTemplate>;
		private var mSelectWholeBox:Boolean;
		
		public function get ActivityWordList():Vector.<WordTemplate>	{ return mActivityWordList; }
		public function get SelectWholeBox():Boolean	{ return mSelectWholeBox; }
		
		public function SelectActivityTemplate(aLevel:Level, aActivityWordList:Vector.<WordTemplate>, aSelectWholeBox:Boolean = false)
		{
			super(aLevel);
			
			mStepClass = SelectActivity;
			
			mActivityWordList = aActivityWordList;
			mSelectWholeBox = aSelectWholeBox;
		}
	}
}