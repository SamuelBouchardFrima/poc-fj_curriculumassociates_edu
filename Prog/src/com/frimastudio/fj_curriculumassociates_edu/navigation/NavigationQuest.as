package com.frimastudio.fj_curriculumassociates_edu.navigation
{
	import com.frimastudio.fj_curriculumassociates_edu.popup.navigation.NavigationTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.quest.Quest;
	import com.frimastudio.fj_curriculumassociates_edu.quest.QuestStepTemplate;
	
	public class NavigationQuest extends Quest
	{
		public function NavigationQuest(aLevel:ExplorableLevel)
		{
			mStepList = new Vector.<QuestStepTemplate>();
			
			//mStepList.push(new NavigationTemplate(aLevel.ToLevel, "Choose a location.", new <String>["The Lab"],
				//new <Boolean>[true], new <int>[1]));
			mStepList.push(new NavigationTemplate(aLevel.ToLevel));
			
			super();
		}
	}
}