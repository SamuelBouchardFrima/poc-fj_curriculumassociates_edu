package com.frimastudio.fj_curriculumassociates_edu.quest
{
	import com.frimastudio.fj_curriculumassociates_edu.dialog.SelectActivity;
	import com.frimastudio.fj_curriculumassociates_edu.lucutaming.LucuTamingConfig;
	import com.frimastudio.fj_curriculumassociates_edu.lucutaming.LucuTamingEnergy;
	import com.frimastudio.fj_curriculumassociates_edu.lucutaming.LucuTamingQuest;
	import flash.display.Sprite;
	
	public class Quest extends Sprite
	{
		protected var mStepList:Vector.<QuestStepTemplate>;
		protected var mStep:QuestStep;
		protected var mTempStep:QuestStep;
		protected var mLucuTaming:LucuTamingQuest;
		
		public function get CurrentStep():QuestStep
		{
			if (mTempStep)
			{
				return mTempStep;
			}
			return mStep;
		}
		
		public function Quest()
		{
			super();
			
			if (!mStepList)
			{
				throw new Error("Quest is abstract and requires its child classes to provide content for mStepList before Quest's constructor.");
			}
			
			NextStep();
		}
		
		public function Refresh():void
		{
			if (mLucuTaming)
			{
				mLucuTaming.Refresh();
			}
			else if (mTempStep)
			{
				mTempStep.Refresh();
			}
			else
			{
				mStep.Refresh();
			}
		}
		
		private function NextStep():void
		{
			if (mStep)
			{
				mStep.removeEventListener(QuestStepEvent.LAUNCH_ACTIVITY, OnLaunchActivity);
				mStep.removeEventListener(QuestStepEvent.LAUNCH_LUCU_TAMING, OnLaunchLucuTaming);
				mStep.removeEventListener(QuestStepEvent.COMPLETE, OnCompleteStep);
				mStep.removeEventListener(QuestStepEvent.OPEN_MAP, OnOpenMap);
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
				mStep.addEventListener(QuestStepEvent.OPEN_MAP, OnOpenMap);
				addChild(mStep);
			}
			else
			{
				CompleteQuest();
			}
		}
		
		protected function CompleteQuest():void 
		{
			dispatchEvent(new QuestEvent(QuestEvent.COMPLETE));
		}
		
		private function OnLaunchActivity(aEvent:QuestStepEvent):void
		{
			if (mTempStep)
			{
				mTempStep.removeEventListener(QuestStepEvent.LEAVE, OnLeaveActivity);
				mTempStep.removeEventListener(QuestStepEvent.LAUNCH_ACTIVITY, OnLaunchActivity);
				mTempStep.removeEventListener(QuestStepEvent.LAUNCH_LUCU_TAMING, OnLaunchLucuTaming);
				mTempStep.removeEventListener(QuestStepEvent.COMPLETE, OnCompleteActivity);
				mTempStep.removeEventListener(QuestStepEvent.OPEN_MAP, OnOpenMap);
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
			mTempStep.addEventListener(QuestStepEvent.OPEN_MAP, OnOpenMap);
			addChild(mTempStep);
		}
		
		private function OnLeaveActivity(aEvent:QuestStepEvent):void
		{
			mTempStep.removeEventListener(QuestStepEvent.LEAVE, OnLeaveActivity);
			mTempStep.removeEventListener(QuestStepEvent.LAUNCH_ACTIVITY, OnLaunchActivity);
			mTempStep.removeEventListener(QuestStepEvent.LAUNCH_LUCU_TAMING, OnLaunchLucuTaming);
			mTempStep.removeEventListener(QuestStepEvent.COMPLETE, OnCompleteActivity);
			mTempStep.removeEventListener(QuestStepEvent.OPEN_MAP, OnOpenMap);
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
			mTempStep.removeEventListener(QuestStepEvent.OPEN_MAP, OnOpenMap);
			removeChild(mTempStep);
			mTempStep = null;
			
			(mStep as SelectActivity).CompleteCurrentActivity(aEvent.WordList);
			addChild(mStep);
		}
		
		private function OnLaunchLucuTaming(aEvent:QuestStepEvent):void
		{
			if (!LucuTamingEnergy.Instance.Charged)
			{
				return;
			}
			
			LucuTamingEnergy.Instance.Discharge();
			
			if (mTempStep)
			{
				removeChild(mTempStep);
			}
			else
			{
				removeChild(mStep);
			}
			
			mLucuTaming = new LucuTamingQuest(mStep.StepLevel);
			mLucuTaming.addEventListener(QuestEvent.COMPLETE, OnCompleteLucuTaming);
			LucuTamingConfig.Container.addChild(mLucuTaming);
		}
		
		private function OnCompleteLucuTaming(aEvent:QuestEvent):void
		{
			LucuTamingConfig.Container.removeChild(mLucuTaming);
			mLucuTaming.removeEventListener(QuestEvent.COMPLETE, OnCompleteLucuTaming);
			mLucuTaming = null;
			
			LucuTamingEnergy.Instance.Charging = true;
			
			if (mTempStep)
			{
				addChild(mTempStep);
			}
			else
			{
				addChild(mStep);
			}
		}
		
		private function OnCompleteStep(aEvent:QuestStepEvent):void
		{
			NextStep();
		}
		
		private function OnOpenMap(aEvent:QuestStepEvent):void
		{
			dispatchEvent(new QuestEvent(QuestEvent.OPEN_MAP));
		}
	}
}