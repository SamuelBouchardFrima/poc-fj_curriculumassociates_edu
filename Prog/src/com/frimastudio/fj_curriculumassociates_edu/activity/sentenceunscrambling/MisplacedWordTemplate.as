package com.frimastudio.fj_curriculumassociates_edu.activity.sentenceunscrambling
{
	import com.frimastudio.fj_curriculumassociates_edu.activity.ActivityType;
	import com.frimastudio.fj_curriculumassociates_edu.activity.activitybox.ActivityWordTemplate;
	
	public class MisplacedWordTemplate extends ActivityWordTemplate
	{
		public function MisplacedWordTemplate(aWord:String, aPunctuation:String = "")
		{
			super(aWord, aPunctuation, ActivityType.SENTENCE_UNSCRAMBLING);
		}
	}
}