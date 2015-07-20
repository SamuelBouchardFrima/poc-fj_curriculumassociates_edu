package com.frimastudio.fj_curriculumassociates_edu.quest
{
	import com.frimastudio.fj_curriculumassociates_edu.dialog.SelectActivity;
	import flash.display.Sprite;
	
	public class Quest extends Sprite
	{
		protected var mStepList:Vector.<QuestStepTemplate>;
		protected var mStep:QuestStep;
		protected var mTempStep:QuestStep;
		//protected var mLucuTaming:LucuTaming;
		
		public function Quest()
		{
			super();
			
			if (!mStepList)
			{
				throw new Error("Quest is abstract and requires its child classes to provide content for mStepList before Quest's constructor.");
			}
			
			NextStep();
		}
		
		private function NextStep():void
		{
			if (mStep)
			{
				mStep.removeEventListener(QuestStepEvent.LAUNCH_ACTIVITY, OnLaunchActivity);
				mStep.removeEventListener(QuestStepEvent.LAUNCH_LUCU_TAMING, OnLaunchLucuTaming);
				mStep.removeEventListener(QuestStepEvent.COMPLETE, OnCompleteStep);
				mStep.Dispose();
				if (contains(mStep))
				{
					removeChild(mStep);
				}
			}
			
			if (mStepList.length)
			{
				var template:QuestStepTemplate = mStepList.shift();
				mStep = new template.StepClass(template);
				mStep.addEventListener(QuestStepEvent.LAUNCH_ACTIVITY, OnLaunchActivity);
				mStep.addEventListener(QuestStepEvent.LAUNCH_LUCU_TAMING, OnLaunchLucuTaming);
				mStep.addEventListener(QuestStepEvent.COMPLETE, OnCompleteStep);
				addChild(mStep);
			}
			else
			{
				dispatchEvent(new QuestEvent(QuestEvent.COMPLETE));
			}
		}
		
		private function OnLaunchActivity(aEvent:QuestStepEvent):void
		{
			if (mTempStep)
			{
				mTempStep.removeEventListener(QuestStepEvent.LEAVE, OnLeaveActivity);
				mTempStep.removeEventListener(QuestStepEvent.LAUNCH_ACTIVITY, OnLaunchActivity);
				mTempStep.removeEventListener(QuestStepEvent.LAUNCH_LUCU_TAMING, OnLaunchLucuTaming);
				mTempStep.removeEventListener(QuestStepEvent.COMPLETE, OnCompleteActivity);
				removeChild(mTempStep);
				mTempStep = null;
			}
			else
			{
				removeChild(mStep);
			}
			
			mTempStep = new aEvent.ActivityToLaunch.StepClass(aEvent.ActivityToLaunch);
			mTempStep.addEventListener(QuestStepEvent.LEAVE, OnLeaveActivity);
			mTempStep.addEventListener(QuestStepEvent.LAUNCH_ACTIVITY, OnLaunchActivity);
			mTempStep.addEventListener(QuestStepEvent.LAUNCH_LUCU_TAMING, OnLaunchLucuTaming);
			mTempStep.addEventListener(QuestStepEvent.COMPLETE, OnCompleteActivity);
			addChild(mTempStep);
		}
		
		private function OnLeaveActivity(aEvent:QuestStepEvent):void
		{
			mTempStep.removeEventListener(QuestStepEvent.LEAVE, OnLeaveActivity);
			mTempStep.removeEventListener(QuestStepEvent.LAUNCH_ACTIVITY, OnLaunchActivity);
			mTempStep.removeEventListener(QuestStepEvent.LAUNCH_LUCU_TAMING, OnLaunchLucuTaming);
			mTempStep.removeEventListener(QuestStepEvent.COMPLETE, OnCompleteActivity);
			removeChild(mTempStep);
			mTempStep = null;
			
			addChild(mStep);
		}
		
		private function OnCompleteActivity(aEvent:QuestStepEvent):void
		{
			mTempStep.removeEventListener(QuestStepEvent.LEAVE, OnLeaveActivity);
			mTempStep.removeEventListener(QuestStepEvent.LAUNCH_ACTIVITY, OnLaunchActivity);
			mTempStep.removeEventListener(QuestStepEvent.LAUNCH_LUCU_TAMING, OnLaunchLucuTaming);
			mTempStep.removeEventListener(QuestStepEvent.COMPLETE, OnCompleteActivity);
			removeChild(mTempStep);
			mTempStep = null;
			
			(mStep as SelectActivity).CompleteCurrentActivity(aEvent.WordList);
			addChild(mStep);
		}
		
		private function OnLaunchLucuTaming(aEvent:QuestStepEvent):void
		{
			if (mTempStep)
			{
				removeChild(mTempStep);
			}
			else
			{
				removeChild(mStep);
			}
			
			
		}
		
		private function OnCompleteStep(aEvent:QuestStepEvent):void
		{
			NextStep();
		}
	}
}