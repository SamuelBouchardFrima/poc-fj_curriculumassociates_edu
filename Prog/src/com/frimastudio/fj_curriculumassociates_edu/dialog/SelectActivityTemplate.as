package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	
	public class SelectActivityTemplate extends QuestStepTemplate
	{
		private var mActivityWordList:Vector.<WordTemplate>;
		private var mLineBreakList:Vector.<int>;
		private var mPhylacteryArrow:Direction;
		private var mSelectWholeBox:Boolean;
		
		public function get ActivityWordList():Vector.<WordTemplate>	{ return mActivityWordList; }
		public function get LineBreakList():Vector.<int>	{ return mLineBreakList; }
		public function get PhylacteryArrow():Direction	{ return mPhylacteryArrow; }
		public function get SelectWholeBox():Boolean	{ return mSelectWholeBox; }
		
		public function SelectActivityTemplate(aLevel:Level, aActivityWordList:Vector.<WordTemplate>,
			aLineBreakList:Vector.<int> = null, aPhylacteryArrow:Direction = null, aSelectWholeBox:Boolean = false)
		{
			super(aLevel);
			
			mStepClass = SelectActivity;
			
			mActivityWordList = aActivityWordList;
			mLineBreakList = (aLineBreakList ? aLineBreakList : new Vector.<int>());
			mPhylacteryArrow = (aPhylacteryArrow ? aPhylacteryArrow : Direction.DOWN_LEFT);
			mSelectWholeBox = aSelectWholeBox;
		}
	}
}