package com.frimastudio.fj_curriculumassociates_edu.poc_game
{
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStep;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepEvent;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class ProgressLocationQuest extends QuestStep
	{
		private var mTemplate:ProgressLocationQuestTemplate;
		
		public function ProgressLocationQuest(aTemplate:ProgressLocationQuestTemplate)
		{
			super(aTemplate);
			
			mTemplate = aTemplate;
			
			mTemplate.ProgressingLevel.ProgressQuest();
			
			var completeStepTimer:Timer = new Timer(30, 1);
			completeStepTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnCompleteStepTimerComplete);
			completeStepTimer.start();
		}
		
		private function OnCompleteStepTimerComplete(aEvent:TimerEvent):void
		{
			(aEvent.currentTarget as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, OnCompleteStepTimerComplete);
			
			dispatchEvent(new QuestStepEvent(QuestStepEvent.COMPLETE));
		}
	}
}