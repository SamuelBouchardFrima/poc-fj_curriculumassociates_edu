package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class DialogTemplate extends QuestStepTemplate
	{
		private var mDialogList:Vector.<String>;
		private var mDialogAudioList:Vector.<Class>;
		private var mActivityWordList:Vector.<WordTemplate>;
		
		public function get DialogList():Vector.<String>	{ return mDialogList; }
		public function get DialogAudioList():Vector.<Class>	{ return mDialogAudioList; }
		public function get ActivityWordList():Vector.<WordTemplate>	{ return mActivityWordList; }
		
		public function DialogTemplate(aLevel:Level, aDialogList:Vector.<String>, aDialogAudioList:Vector.<Class>,
			aActivityWordList:Vector.<WordTemplate> = null)
		{
			super(aLevel);
			
			mStepClass = Dialog;
			
			mDialogList = aDialogList;
			mDialogAudioList = aDialogAudioList;
			mActivityWordList = aActivityWordList;
		}
	}
}