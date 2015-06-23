package com.frimastudio.fj_curriculumassociates_edu.activity.familysort
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	
	public class FamilySortTemplate extends ActivityTemplate
	{
		private var mFamilyList:Vector.<String>;
		private var mExampleList:Vector.<String>;
		private var mWordList:Vector.<String>;
		private var mSkipInstruction:Boolean;
		
		public function get FamilyList():Vector.<String>	{	return mFamilyList;	}
		public function get ExampleList():Vector.<String>	{	return mExampleList;	}
		public function get WordList():Vector.<String>	{	return mWordList;	}
		public function get SkipInstruction():Boolean	{	return mSkipInstruction;	}
		
		public function FamilySortTemplate(aFamilyList:Vector.<String>, aExampleList:Vector.<String>, aWordList:Vector.<String>,
			aSkipInstruction:Boolean = false)
		{
			super(Level.NONE);
			
			mStepClass = FamilySort;
			
			mFamilyList = aFamilyList;
			mExampleList = aExampleList;
			mWordList = aWordList;
			mSkipInstruction = aSkipInstruction;
		}
	}
}