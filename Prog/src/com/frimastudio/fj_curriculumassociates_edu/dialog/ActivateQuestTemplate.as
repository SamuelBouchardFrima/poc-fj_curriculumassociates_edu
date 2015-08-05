package com.frimastudio.fj_curriculumassociates_edu.dialog
{
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class ActivateQuestTemplate extends QuestStepTemplate
	{
		private var mSpeaker:SpeakerType;
		
		public function get Speaker():SpeakerType	{ return mSpeaker; }
		
		public function ActivateQuestTemplate(aLevel:Level, aSpeaker:SpeakerType)
		{
			super(aLevel);
			
			mStepClass = ActivateQuest;
			
			mSpeaker = aSpeaker;
		}
	}
}