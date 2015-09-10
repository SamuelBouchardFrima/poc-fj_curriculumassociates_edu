package com.frimastudio.fj_curriculumassociates_edu.activity.activitybox
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.WordTemplate;
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	
	public class ActivityWordTemplate extends WordTemplate
	{
		public function ActivityWordTemplate(aWord:String, aPunctuation:String = "", aType:ActivityType = null,
			aProgressDone:Boolean = false, aVO:String = null)
		{
			super(new <String>[aWord], aPunctuation, aType, -1, aProgressDone, aVO);
		}
	}
}