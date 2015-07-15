package com.frimastudio.fj_curriculumassociates_edu.activity.activitybox
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	
	public class KnownWordTemplate extends ActivityWordTemplate
	{
		public function KnownWordTemplate(aWord:String, aPunctuation:String = "", aProgressDone:Boolean = false)
		{
			super(aWord, aPunctuation, ActivityType.NONE, aProgressDone);
		}
	}
}