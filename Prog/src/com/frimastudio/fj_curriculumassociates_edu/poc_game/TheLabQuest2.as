package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.ActivateQuestTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.DialogTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.dialog.SpeakerType;
	import com.frimastudio.fj_curriculumassociates_edu.level.Level;
	import com.frimastudio.fj_curriculumassociates_edu.popup.locationunlocked.LocationUnlockedTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class TheLabQuest2 extends Quest
	{
		public function TheLabQuest2()
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			mStepList.push(new QuestlessStepTemplate(Level.THE_LAB));
			
			mStepList.push(new ActivateQuestTemplate(Level.THE_LAB, SpeakerType.PLORY));
			mStepList.push(new DialogTemplate(Level.THE_LAB,
				new <String>["What a song! I can't wait for the singing contest."],
				new <Class>[Asset.QuestFlowSound[28]], SpeakerType.PLORY));
			mStepList.push(new LocationUnlockedTemplate(Level.THE_LAB, "You unlocked the Singing Contest!", Asset.QuestFlowSound[29]));
			mStepList.push(new DialogTemplate(Level.THE_LAB,
				new <String>["Great job! You are ready for the next lesson."],
				new <Class>[Asset.QuestFlowSound[30]], SpeakerType.PLORY));
			
			mStepList.push(new ResetPOCTemplate(Level.THE_LAB));
			
			super();
		}
	}
}