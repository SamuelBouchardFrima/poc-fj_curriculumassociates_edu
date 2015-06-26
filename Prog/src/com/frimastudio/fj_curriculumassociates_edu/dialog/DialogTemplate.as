package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.util.Direction;
	
	public class DialogTemplate extends QuestStepTemplate
	{
		private var mDialogList:Vector.<String>;
		private var mDialogAudioList:Vector.<Class>;
		private var mActivityWordList:Vector.<WordTemplate>;
		private var mLineBreakList:Vector.<int>;
		private var mPhylacteryArrow:Direction;
		
		public function get DialogList():Vector.<String>	{ return mDialogList; }
		public function get DialogAudioList():Vector.<Class>	{ return mDialogAudioList; }
		public function get ActivityWordList():Vector.<WordTemplate>	{ return mActivityWordList; }
		public function get LineBreakList():Vector.<int>	{ return mLineBreakList; }
		public function get PhylacteryArrow():Direction	{ return mPhylacteryArrow; }
		
		public function DialogTemplate(aLevel:Level, aDialogList:Vector.<String>, aDialogAudioList:Vector.<Class>,
			aActivityWordList:Vector.<WordTemplate> = null, aLineBreakList:Vector.<int> = null, aPhylacteryArrow:Direction = null)
		{
			super(aLevel);
			
			mStepClass = Dialog;
			
			mDialogList = aDialogList;
			mDialogAudioList = aDialogAudioList;
			mActivityWordList = aActivityWordList;
			mLineBreakList = (aLineBreakList ? aLineBreakList : new Vector.<int>());
			mPhylacteryArrow = (aPhylacteryArrow ? aPhylacteryArrow : Direction.DOWN_LEFT);
		}
	}
}