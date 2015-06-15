package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class DialogTemplate extends QuestStepTemplate
	{
		private var mDialogList:Vector.<String>;
		private var mDialogAudioList:Vector.<Class>;
		private var mNPCAsset:Class;
		
		public function get DialogList():Vector.<String>
		{
			return mDialogList;
		}
		
		public function get DialogAudioList():Vector.<Class>
		{
			return mDialogAudioList;
		}
		
		public function get NPCAsset():Class
		{
			return mNPCAsset;
		}
		
		public function DialogTemplate(aDialogList:Vector.<String>, aDialogAudioList:Vector.<Class>, aNPCAsset:Class)
		{
			super();
			
			mStepClass = Dialog;
			mDialogList = aDialogList;
			mDialogAudioList = aDialogAudioList;
			mNPCAsset = aNPCAsset;
		}
	}
}