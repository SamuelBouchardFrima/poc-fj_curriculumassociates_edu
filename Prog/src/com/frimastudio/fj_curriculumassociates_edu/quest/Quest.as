package com.frimastudio.fj_curriculumassociates_edu.quest
{
	import flash.display.Sprite;
	
	public class Quest extends Sprite
	{
		protected var mStepList:Vector.<QuestStepTemplate>;
		protected var mStep:QuestStep;
		
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
				mStep.removeEventListener(QuestStepEvent.COMPLETE, OnCompleteStep);
				mStep.Dispose();
				removeChild(mStep);
			}
			
			if (mStepList.length)
			{
				var template:QuestStepTemplate = mStepList.shift();
				mStep = new template.StepClass(template);
				mStep.addEventListener(QuestStepEvent.COMPLETE, OnCompleteStep);
				addChild(mStep);
			}
			else
			{
				dispatchEvent(new QuestEvent(QuestEvent.COMPLETE));
			}
		}
		
		private function OnCompleteStep(aEvent:QuestStepEvent):void
		{
			NextStep();
		}
	}
}